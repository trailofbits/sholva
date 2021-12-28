#!/usr/bin/env python3

# parse_encodings.py: convert "encodings.spec" into "commands.json"

import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Optional

_HERE = Path(__file__).parent
_ENCODINGS_SPEC = _HERE / "encodings.spec"
_COMMANDS_JSON = _HERE / "commands.json"

# Valid "pseudo" operand encoding identifiers.
# These are decomposed into their true encoding identifier (the corresponding value)
# and some additional encoding-specific semantics (e.g., D32r is a relative 32-bit displacement).
_PSEUDO_OPERAND_ENCODINGS = {
    "D32r": "D32",
    "D8r": "D8",
}

# Valid operand encoding identifiers (values are corresponding arities).
_OPERAND_ENCODINGS = {
    "I": 1,
    "D8": 1,
    "D32": 1,
    "M": 1,
    "O": 1,
    "A": 1,
    "MI": 2,
    "MR": 2,
    "RM": 2,
    "OI": 2,
    "AI": 2,
    "AO": 2,
    "MC": 2,
    "RMI": 3,
    "MRI": 3,
    "MRC": 3,
    "ZO": 0,
}
_OPERAND_MODES = {"1", "r", "w", "W", "x"}
_MODIFIERS = {"ib", "iw", "id", "i*", "rb", "rw", "rd", "r*"}
_EXTENSION_MODES = {"S", "Z"}


@dataclass(frozen=True)
class Encoding:
    opc: int
    """
    The opcode byte for this encoding.
    """

    opc_reg_bits: bool
    """
    Does the opcode byte include a register selector in its lowest 3 bits?
    """

    op_enc: str
    """
    The "operand encoding" for this encoding. See `_OPERAND_ENCODINGS`.
    """

    num_opnds: int
    """
    The number of explicit operands for this encoding.
    """

    ext: Optional[int]
    """
    The value of the opcode extension, if this encoding has one.
    """

    esc: bool
    """
    Does this encoding require an escape prefix?
    """

    ib: bool
    """
    Is the immediate operand (if present) a byte?
    """

    iw_or_id: bool
    """
    Is the immediate operand (if present) a word/dword?
    """

    rb: bool
    """
    Is the register operand (if present) a byte?
    """

    rw_or_rd: bool
    """
    Is the register operand (if present) a word/dword?
    """

    opnd0_mode: str
    """
    The mode that the first operand is in. See `_OPERAND_MODES`.
    """

    opnd1_mode: str
    """
    The mode that the second operand is in. See `_OPERAND_MODES`.
    """

    opnd2_mode: str
    """
    The mode that the third operand is in. See `_OPERAND_MODES`.
    """

    source_sign_ext: str
    """
    The sign extension mode for the "source" operand. See `_EXTENSION_MODES`.
    """

    disp_is_rel: bool
    """
    Is the displacement operand (if present) a relative displacement?
    """

    @classmethod
    def parse(cls, raw_enc):
        esc = raw_enc.startswith("x")
        if esc:
            raw_enc = raw_enc[1:]

        enc_body, op_enc = raw_enc.split("~", 1)

        assert "~" in op_enc, f"missing operand modes for {raw_enc}"

        op_enc, rest = op_enc.split("~", 1)

        if "~" in rest:
            opnd_modes, sign_spec = rest.split("~", 1)
            assert sign_spec in _EXTENSION_MODES, f"invalid extension mode: {sign_spec}"
        else:
            opnd_modes = rest
            sign_spec = "Z"
        assert sign_spec is not None

        opnd_modes = list(opnd_modes)
        assert (
            len(opnd_modes) <= 3
        ), f"more modes than plausible operands: {len(opnd_modes)}"
        assert all(
            m in _OPERAND_MODES for m in opnd_modes
        ), f"unknown opnd mode(s): {opnd_modes}"
        opnd_modes += ["x"] * (3 - len(opnd_modes))

        # Handle "pseudo" operand encodings by transforming them
        # into their real encodings and extracting the special semantics.
        # For now, the only special semantic is treating displacements
        # as relative instead of absolute.
        disp_is_rel = False
        if op_enc in _PSEUDO_OPERAND_ENCODINGS:
            disp_is_rel = True
            op_enc = _PSEUDO_OPERAND_ENCODINGS[op_enc]

        assert (
            op_enc in _OPERAND_ENCODINGS.keys()
        ), f"unknown operand encoding: {op_enc}"

        enc_body, *modifiers = enc_body.split("+")

        if modifiers:
            assert [
                m in _MODIFIERS for m in modifiers
            ], f"unknown modifiers in list: {modifiers}"

        ib = "ib" in modifiers
        iw_or_id = "i*" in modifiers or "iw" in modifiers or "id" in modifiers
        rb = "rb" in modifiers
        rw_or_rd = "r*" in modifiers or "rw" in modifiers or "rd" in modifiers

        parts = enc_body.split("/", 1)
        if len(parts) == 1:
            opc = int(parts[0], 16)
            ext = None
        elif len(parts) == 2:
            opc = int(parts[0], 16)
            ext = int(parts[1])

            assert ext <= 7, f"invalid opcode extension: {ext}"
        else:
            assert False, f"bad encoding: {raw_enc}"

        opc_reg_bits = op_enc in {"O", "OI", "AO"}

        assert opc < 2 ** 8, f"oversized opcode: {opc}"
        return cls(
            opc,
            opc_reg_bits,
            op_enc,
            _OPERAND_ENCODINGS[op_enc],
            ext,
            esc,
            ib,
            iw_or_id,
            rb,
            rw_or_rd,
            opnd_modes[0],
            opnd_modes[1],
            opnd_modes[2],
            sign_spec,
            disp_is_rel,
        )


@dataclass(frozen=True)
class Spec:
    cmd: str
    encs: list[Encoding]


def main():
    assert _ENCODINGS_SPEC.exists(), f"parse encodings dep missing: {_ENCODINGS_SPEC}"

    seen_cmds = set()
    seen_encs = set()
    specs = []
    for line in _ENCODINGS_SPEC.read_text().split("\n"):
        if not line or line.startswith("#"):
            continue

        cmd, spec_body = line.split(":", 1)
        assert cmd not in seen_cmds, f"barf: {cmd} specified more than once"
        seen_cmds.add(cmd)

        raw_encs = spec_body.split(",")
        encs = []
        for raw_enc in raw_encs:
            enc = Encoding.parse(raw_enc)
            assert enc not in seen_encs, f"barf: duped encoding: {enc} ({raw_enc})"
            seen_encs.add(enc)
            encs.append(enc)

        specs.append(asdict(Spec(cmd, encs)))

    with _COMMANDS_JSON.open(mode="w+") as io:
        print(json.dumps(specs, sort_keys=True, indent=4), file=io)


if __name__ == "__main__":
    main()
