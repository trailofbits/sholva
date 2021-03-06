#!/usr/bin/env python3

# codegen.py: generate various verilog files for instruction decoding
# from "commands.json", which in turn is generated from "encodings.spec"
# by "parse_encodings.py"

import json
from collections import defaultdict
from datetime import datetime
from functools import reduce
from pathlib import Path
from textwrap import dedent

_US = Path(__file__)
_HERE = _US.parent
_COMMANDS_JSON = _HERE / "commands.json"
_COMMANDS_GEN_V = _HERE / "commands.gen.v"
_OPC_MAP_GEN_V = _HERE / "opc_map.gen.v"
_IMM_GEN_V = _HERE / "imm.gen.v"

# TODO(ww): The associated arities here are misleading, since they don't
# necessarily include implicit operands. Remove them.
_OPND_ENC_MAP = {
    "I": ("OPND_ENC_IMM", 1),
    "D8": ("OPND_ENC_DISP8", 1),
    "D32": ("OPND_ENC_DISP32", 1),
    "M": ("OPND_ENC_MODREGRM_RM", 1),
    "O": ("OPND_ENC_REG", 1),
    "A": ("OPND_ENC_EAX", 1),
    "MI": ("OPND_ENC_MODREGRM_RM_IMM", 2),
    "MR": ("OPND_ENC_MODREGRM_RM_REG", 2),
    "RM": ("OPND_ENC_MODREGRM_REG_RM", 2),
    "OI": ("OPND_ENC_REG_IMM", 2),
    "AI": ("OPND_ENC_EAX_IMM", 2),
    "AO": ("OPND_ENC_EAX_REG", 2),
    "MC": ("OPND_ENC_MODREGRM_RM_CL", 2),
    "RMI": ("OPND_ENC_MODREGRM_REG_RM_IMM", 3),
    "MRI": ("OPND_ENC_MODREGRM_RM_REG_IMM", 3),
    "MRC": ("OPND_ENC_MODREGRM_RM_REG_CL", 3),
    "ZO": ("OPND_ENC_NONE", 0),
}

_V_TRUE = "1'b1"
_V_FALSE = "1'b0"

CMD_WIRE_SIZE = 7
CMD_MAX = (2 ** CMD_WIRE_SIZE) - 1


def _header():
    """
    Emit a codegen header.
    """
    return dedent(
        f"""
        // this file was generated by {_US.name} on {datetime.now()}
        // do NOT edit it by hand
        """
    )


def _br(io, n=1):
    print("\n" * n, file=io)


def _paren(thing):
    """
    Parenthesize `thing` if not already parenthesized.

    Why? Makes the generated code slightly easier to read than unconditional parentheticals.
    """
    if thing[0] == "(" and thing[-1] == ")":
        return thing
    else:
        return f"({thing})"


def _asdef(name):
    """
    Emit `name` as a defined macro.
    """
    return f"`{name}"


def _define(name, val):
    """
    Use the `define` macro to define a new macro.
    """
    return f"`define {name} {val}"


def _lit(w, n):
    """
    Emit a literal (`n`) of `w` bits.
    """
    # Readability: use binary, hex, etc. based on some common widths.
    if w == 2:
        lit = f"b{n:b}"
    elif w == 8:
        lit = f"h{n:x}"
    else:
        lit = f"d{n}"
    return f"{w}'{lit}"


def _assign(lhs, rhs):
    """
    Emit an assignment statement.
    """
    return f"assign {lhs} = {rhs};"


def _eq(lhs, rhs):
    """
    Emit an equality expression.
    """
    return f"({_paren(lhs)} == {_paren(rhs)})"


def _opc_eq(rhs):
    """
    Emit an equality expression against the opcode bits of the instruction.
    """
    return _eq("unescaped_instr[7:0]", _lit(8, rhs))


def _basic_enc_expr(enc):
    """
    Return a generic expression for selecting against an instruction encoding.
    """
    if enc["opc_reg_bits"]:
        # All embedded register operand forms are single-byte, so we keep
        # it simple here.
        # TODO(ww): Do we need something else here? We shouldn't since the 0-bit
        # form of all embedded register encodings is also valid (as EAX), but
        # maybe I'm forgetting something.
        enc_expr = _eq("opc_without_regs", _lit(8, enc["opc"]))
    else:
        enc_expr = _and(_bool(enc["esc"], "is_2byte"), _opc_eq(enc["opc"]))

    if enc["ext"] is not None:
        enc_expr = _and(enc_expr, _opc_ext_eq(enc["ext"]))
    return enc_expr


def _opc_ext_eq(rhs):
    """
    Emit an equality expression against the opcode extension bits (reg of ModR/M)
    of the instruction.
    """
    return _eq("unescaped_instr[13:11]", _lit(3, rhs))


def _and(lhs, rhs):
    """
    Emit a logical AND expression.
    """
    return f"({_paren(lhs)} && {_paren(rhs)})"


def _or(lhs, rhs):
    """
    Emit a logical OR expression.
    """
    return f"({_paren(lhs)} ||\n    {_paren(rhs)})"


def _not(expr):
    """
    Emit a logical NOT expression.
    """
    return f"(~{_paren(expr)})"


def _bool(p, expr):
    """
    Emit an expression if `p`, or NOT expression if not `p`.
    """
    if p:
        return expr
    else:
        return _not(expr)


def _ternary(cond, ifthen, elsethen):
    """
    Emit a ternary expression.
    """
    return f"{_paren(cond)} ?\n    {_paren(ifthen)} :\n    {_paren(elsethen)}"


def _ternary_chain(exprs, lastelsethen=None):
    """
    Emit a ternary chain, with each leaf evaluating to an opcode command.
    """

    def _ternary_chain_(exprs, lastelsethen):
        if exprs == []:
            return lastelsethen
        else:
            return _ternary(
                exprs[0][1],
                exprs[0][0],
                _ternary_chain_(exprs[1:], lastelsethen),
            )

    if lastelsethen is None:
        lastelsethen = exprs[-1][0]
        exprs = exprs[0:-1]

    return _ternary_chain_(exprs, lastelsethen)


def _1hot(width, n):
    """
    Emit a one-hot `width` bitstring of value `n`, with `n=0` being hot index 0.
    """
    return (((width - 1) - n) * "0") + "1" + ((width - (((width - 1) - n) + 1)) * "0")


def _sextN_32(n, var, x, y):
    """
    Emit a call to `sextN_32` for the given range in `var`.
    """
    return _paren(f"sext{n}_32({var}[{x}:{y}])")


def _zextN_32(n, var, x, y):
    """
    Emit a call to `zextN_32` for the given range in `var`.
    """
    return _paren(f"zext{n}_32({var}[{x}:{y}])")


def _extN_32(n, var, x, y):
    """
    Emits a ternary for `{s,z}extN_32` for the given range in `var`.

    The ternary is predicated on the `source_is_sext` wire.
    """
    return _ternary("source_is_sext", _sextN_32(n, var, x, y), _zextN_32(n, var, x, y))


def _gen_commands_v(commands):
    """
    Generate `commands.gen.v`.
    """
    with _COMMANDS_GEN_V.open(mode="w+") as io:
        print(_header(), file=io)

        # Numeric forms.
        for idx, cmd in enumerate(commands):
            print(_define(cmd["cmd"], _lit(CMD_WIRE_SIZE, idx)), file=io)
        print(_define("CMD_UNKNOWN", _lit(CMD_WIRE_SIZE, idx + 1)), file=io)

        _br(io, 2)

        # One-hot forms.
        hotlen = 2 ** CMD_WIRE_SIZE
        for idx, cmd in enumerate(commands):
            bitstring = _1hot(hotlen, idx)
            print(_define(f"{cmd['cmd']}_1HOT", f"{hotlen}'b{bitstring}"), file=io)
        bitstring = _1hot(hotlen, idx + 1)
        print(_define("CMD_UNKNOWN_1HOT", f"{hotlen}'b{bitstring}"), file=io)


def _gen_opc_map_v(commands):
    """
    Generate `opc_map.gen.v`.
    """

    def enc_iter():
        for cmd in commands:
            for enc in cmd["encs"]:
                yield enc

    with _OPC_MAP_GEN_V.open(mode="w+") as io:
        print(_header(), file=io)

        # Create the main `opc` assignment.
        cmd_exprs = []
        for cmd in commands:
            enc_exprs = []
            for enc in cmd["encs"]:
                enc_expr = _basic_enc_expr(enc)
                enc_exprs.append(enc_expr)
            cmd_expr = reduce(_or, enc_exprs)
            cmd_exprs.append((_asdef(cmd["cmd"]), cmd_expr))
        print(_assign("opc", _ternary_chain(cmd_exprs, _asdef("CMD_UNKNOWN"))), file=io)

        _br(io, 2)

        # Create a map of operand encoding forms => opcode encoding forms,
        # then use that map to generate the `opnd_form` assignment.
        opnd_enc_map = defaultdict(list)
        for cmd in commands:
            for enc in cmd["encs"]:
                opnd_enc_map[enc["op_enc"]].append(enc)
        opnd_enc_exprs = []
        for opnd_enc, op_encs in opnd_enc_map.items():
            enc_exprs = []
            for op_enc in op_encs:
                enc_expr = _basic_enc_expr(op_enc)
                enc_exprs.append(enc_expr)
            opnd_enc_expr = reduce(_or, enc_exprs)
            opnd_enc_exprs.append((_asdef(_OPND_ENC_MAP[opnd_enc][0]), opnd_enc_expr))
        print(
            _assign(
                "opnd_form", _ternary_chain(opnd_enc_exprs, _asdef("OPND_ENC_UNKNOWN"))
            ),
            file=io,
        )

        _br(io, 2)

        # Create lists of `rb` and `ib` opcode encoding forms, then use
        # those lists to generate the `reg_1byte` and `imm_1byte` assignments.
        rb_forms = []
        ib_forms = []
        for cmd in commands:
            [rb_forms.append(enc) for enc in cmd["encs"] if enc["rb"]]
            [ib_forms.append(enc) for enc in cmd["encs"] if enc["ib"]]

        rb_form_exprs = []
        for enc in rb_forms:
            rb_form_expr = _basic_enc_expr(enc)
            rb_form_exprs.append(rb_form_expr)
        print(_assign("reg_1byte", reduce(_or, rb_form_exprs)), file=io)

        _br(io, 2)

        ib_form_exprs = []
        for enc in ib_forms:
            ib_form_expr = _basic_enc_expr(enc)
            ib_form_exprs.append(ib_form_expr)
        print(_assign("imm_1byte", reduce(_or, ib_form_exprs)), file=io)

        _br(io, 2)

        # Generate the opnd_count assignment.
        arity_map = defaultdict(list)
        for enc in enc_iter():
            arity_map[enc["opnd_count"]].append(enc)

        arity_exprs = []
        for arity, encs in arity_map.items():
            arity_expr = reduce(_or, [_basic_enc_expr(enc) for enc in encs])
            arity_exprs.append((_lit(2, arity), arity_expr))
        print(_assign("opnd_count", _ternary_chain(arity_exprs)), file=io)

        # Generate the opnd{0,1,2}_is_{one,read,write} assignments.
        for n in [0, 1, 2]:
            _br(io, 2)

            opndN_is_one_exprs = []
            opndN_is_read_exprs = []
            opndN_is_write_exprs = []
            for cmd in commands:
                for enc in cmd["encs"]:
                    opndN_mode = enc[f"opnd{n}_mode"]

                    enc_expr = _basic_enc_expr(enc)

                    # This encoding "reads" a constant of 1 from this operand.
                    if opndN_mode == "1":
                        opndN_is_one_exprs.append(enc_expr)

                    # This encoding reads from this operand.
                    if opndN_mode == "W" or opndN_mode == "r":
                        opndN_is_read_exprs.append(enc_expr)

                    # This encoding writes to this operand.
                    if opndN_mode == "W" or opndN_mode == "w":
                        opndN_is_write_exprs.append(enc_expr)

            if len(opndN_is_one_exprs) > 0:
                # For now, we only expect operand#1 to be one.
                # Other parts of the circuit will need to be updated if this changes,
                # so explicitly catch it early here.
                assert n == 1, f"barf: opnd#{n} has unexpected 'one' value"

                opndN_is_one_expr = reduce(_or, opndN_is_one_exprs)
                print(
                    _assign(f"opnd{n}_is_one", opndN_is_one_expr),
                    file=io,
                )
                _br(io, 2)

            if len(opndN_is_read_exprs) > 0:
                opndN_is_read_expr = reduce(_or, opndN_is_read_exprs)
            else:
                opndN_is_read_expr = _V_FALSE

            print(
                _assign(f"opnd{n}_is_read", opndN_is_read_expr),
                file=io,
            )

            _br(io, 2)

            if len(opndN_is_write_exprs) > 0:
                opndN_is_write_expr = reduce(_or, opndN_is_write_exprs)
            else:
                opndN_is_write_expr = _V_FALSE

            print(
                _assign(f"opnd{n}_is_write", opndN_is_write_expr),
                file=io,
            )

        _br(io, 2)

        # Generate the "source_is_sext" assignment.
        source_is_sext_exprs = []
        for cmd in commands:
            for enc in cmd["encs"]:
                if enc["source_sign_ext"] != "S":
                    continue
                enc_expr = _basic_enc_expr(enc)
                source_is_sext_exprs.append(enc_expr)
        print(
            _assign("source_is_sext", reduce(_or, source_is_sext_exprs)),
            file=io,
        )

        # Generate the "disp_is_rel" assignment.
        disp_is_rel_exprs = []
        for cmd in commands:
            for enc in cmd["encs"]:
                if not enc["disp_is_rel"]:
                    continue
                disp_is_rel_exprs.append(_basic_enc_expr(enc))
        print(_assign("disp_is_rel", reduce(_or, disp_is_rel_exprs)), file=io)


def _gen_imm_v():
    with _IMM_GEN_V.open(mode="w+") as io:
        print(_header(), file=io)

        # This is a little bit of a brain-bender: for every instruction that can
        # take an immediate, that immediate can come in one of three forms:
        # 8, 16, or 32-bit. We need to perform different amounts of sign extension
        # for each of these cases, *while also* accessing different parts of the
        # `unescaped_instr` (since we might be dealing with an instruction that
        # has a ModR/M byte, or SIB, or displacement, or none of the above).
        #
        # `imm_leaves_unrealized` is our generic representation of immediate handling,
        # without any reference to concrete offsets into `unescaped_instr`.
        # For each concrete case, we realize it.
        imm_leaves_unrealized = [
            (lambda x: _extN_32(8, "unescaped_instr", x + 7, x), "is_imm8"),
            (lambda x: _extN_32(16, "unescaped_instr", x + 15, x), "is_imm16"),
            (lambda x: _paren(f"unescaped_instr[{x + 31}:{x}]"), "is_imm32"),
        ]

        def _chain_imm_leaves(offset):
            # Why +8? The first byte of unescaped_instr is the opcode, so we always skip it.
            imm_leaves = [
                (expr_f(offset + 8), pred) for (expr_f, pred) in imm_leaves_unrealized
            ]
            return _ternary_chain(imm_leaves)

        # Next, our decision tree: we build up the appropriate concrete offset
        # to the immediate byte(s) based on whether our instruction:
        # * Has a ModR/M byte (+8)
        # * Has a SIB byte (+8)
        # * Has a displacement...
        #   * If that displacement is 8 bits (+8)
        #   * If that displacement is 32 bits (+32)
        # We bail out at the top level if we don't have any immediate byte(s) at all.
        # Also, note that each offset above is relative to the end of the opcode byte.
        imm_decisions = _ternary(
            "has_imm",
            _ternary(
                "has_modrm",
                _ternary(
                    "has_sib",
                    _ternary(
                        "has_disp",
                        _ternary(
                            "is_disp8", _chain_imm_leaves(24), _chain_imm_leaves(48)
                        ),
                        _chain_imm_leaves(16),
                    ),
                    _ternary(
                        "has_disp",
                        _ternary(
                            "is_disp8", _chain_imm_leaves(16), _chain_imm_leaves(40)
                        ),
                        _chain_imm_leaves(8),
                    ),
                ),
                _chain_imm_leaves(0),
            ),
            "32'd0",
        )

        print(_assign("imm", imm_decisions), file=io)


def main():
    assert _COMMANDS_JSON.exists(), f"codegen dep missing: {_COMMANDS_JSON}"

    commands = json.loads(_COMMANDS_JSON.read_text())

    assert (
        len(commands) < CMD_MAX
    ), f"|commands| ({len(commands)}) >= {CMD_MAX}; increase the wire size"

    _gen_commands_v(commands)
    _gen_opc_map_v(commands)
    _gen_imm_v()


if __name__ == "__main__":
    main()
