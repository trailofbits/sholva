#!/usr/bin/env python3

# codegen.py: generate various verilog files for instruction decoding
# from "commands.json", which in turn is generated from "encodings.spec"
# by "parse_encodings.py"

import functools
import json
from collections import defaultdict
from datetime import datetime
from pathlib import Path
from textwrap import dedent

_US = Path(__file__)
_HERE = _US.parent
_COMMANDS_JSON = _HERE / "commands.json"
_COMMANDS_GEN_V = _HERE / "commands.gen.v"
_OPC_MAP_GEN_V = _HERE / "opc_map.gen.v"

_OPND_ENC_MAP = {
    "I": ("OPND_ENC_IMM", 1),
    "D": ("OPND_ENC_DISP", 1),
    "M": ("OPND_ENC_MODREGRM_RM", 1),
    "O": ("OPND_ENC_REG", 1),
    "A": ("OPND_ENC_EAX", 1),
    "MI": ("OPND_ENC_MODREGRM_RM_IMM", 2),
    "MR": ("OPND_ENC_MODREGRM_RM_REG", 2),
    "RM": ("OPND_ENC_MODREGRM_REG_RM", 2),
    "OI": ("OPND_ENC_REG_IMM", 2),
    "AI": ("OPND_ENC_EAX_IMM", 2),
    "AO": ("OPND_ENC_EAX_REG", 2),
    "RMI": ("OPND_ENC_MODREGRM_REG_RM_IMM", 3),
    "MRI": ("OPND_ENC_MODREGRM_RM_REG_IMM", 3),
    "MRC": ("OPND_ENC_MODREGRM_RM_REG_CL", 3),
    "ZO": ("OPND_ENC_NONE", 0),
}


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
    return _eq("unescaped_instr[7:0]", f"8'h{rhs:x}")


def _opc_ext_eq(rhs):
    """
    Emit an equality expression against the opcode extension bits (reg of ModR/M)
    of the instruction.
    """
    return _eq("unescaped_instr[12:10]", f"3'h{rhs:x}")


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


def _gen_commands_v(commands):
    """
    Generate `commands.gen.v`.
    """
    with _COMMANDS_GEN_V.open(mode="w+") as io:
        print(_header(), file=io)

        # Numeric forms.
        for idx, cmd in enumerate(commands):
            print(_define(cmd["cmd"], f"6'd{idx}"), file=io)
        print(_define("CMD_UNKNOWN", f"6'd{idx + 1}"), file=io)

        _br(io, 2)

        # One-hot forms.
        hotlen = 2 ** 6
        for idx, cmd in enumerate(commands):
            bitstring = _1hot(hotlen, idx)
            print(_define(f"{cmd['cmd']}_1HOT", f"{hotlen}'b{bitstring}"), file=io)
        bitstring = _1hot(hotlen, idx + 1)
        print(_define("CMD_UNKNOWN_1HOT", f"{hotlen}'b{bitstring}"), file=io)


def _gen_opc_map_v(commands):
    """
    Generate `opc_map.gen.v`.
    """
    with _OPC_MAP_GEN_V.open(mode="w+") as io:
        print(_header(), file=io)

        # Create the main `opc` assignment.
        cmd_exprs = []
        for cmd in commands:
            enc_exprs = []
            for enc in cmd["encs"]:
                enc_expr = _and(_bool(enc["esc"], "is_2byte"), _opc_eq(enc["opc"]))
                if enc["ext"] is not None:
                    enc_expr = _and(enc_expr, _opc_ext_eq(enc["ext"]))
                enc_exprs.append(enc_expr)
            cmd_expr = functools.reduce(_or, enc_exprs)
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
                enc_expr = _and(
                    _bool(op_enc["esc"], "is_2byte"), _opc_eq(op_enc["opc"])
                )
                if op_enc["ext"] is not None:
                    enc_expr = _and(enc_expr, _opc_ext_eq(op_enc["ext"]))
                enc_exprs.append(enc_expr)
            opnd_enc_expr = functools.reduce(_or, enc_exprs)
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
            rb_form_expr = _and(_bool(enc["esc"], "is_2byte"), _opc_eq(enc["opc"]))
            if enc["ext"] is not None:
                rb_form_expr = _and(rb_form_expr, _opc_ext_eq(enc["ext"]))
            rb_form_exprs.append(rb_form_expr)
        print(_assign("reg_1byte", functools.reduce(_or, rb_form_exprs)), file=io)

        _br(io, 2)

        ib_form_exprs = []
        for enc in ib_forms:
            ib_form_expr = _and(_bool(enc["esc"], "is_2byte"), _opc_eq(enc["opc"]))
            if enc["ext"] is not None:
                ib_form_expr = _and(ib_form_expr, _opc_ext_eq(enc["ext"]))
            ib_form_exprs.append(ib_form_expr)
        print(_assign("imm_1byte", functools.reduce(_or, ib_form_exprs)), file=io)

        _br(io, 2)

        # Generate the opnd_count assignment.
        arity_map = defaultdict(list)
        for form, arity in _OPND_ENC_MAP.values():
            arity_map[arity].append(form)
        arity_exprs = []
        for arity, forms in arity_map.items():
            arity_expr = functools.reduce(
                _or, [_eq("opnd_form", _asdef(form)) for form in forms]
            )
            arity_exprs.append((f"2'd{arity}", arity_expr))
        print(_assign("opnd_count", _ternary_chain(arity_exprs)), file=io)


def main():
    assert _COMMANDS_JSON.exists(), f"codegen dep missing: {_COMMANDS_JSON}"

    commands = json.loads(_COMMANDS_JSON.read_text())

    assert len(commands) < (2 ** 6) - 1, "|commands| > 63; increase the wire size"

    _gen_commands_v(commands)
    _gen_opc_map_v(commands)


if __name__ == "__main__":
    main()
