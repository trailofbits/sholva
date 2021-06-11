#!/usr/bin/env python3

# parse_encodings.py: convert "encodings.spec" into "commands.json"

import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Optional

_HERE = Path(__file__).parent
_ENCODINGS_SPEC = _HERE / "encodings.spec"
_COMMANDS_JSON = _HERE / "commands.json"


# Valid operand encoding identifiers (values are corresponding arities).
_OPERAND_ENCODINGS = {
    "I": 1,
    "D": 1,
    "M": 1,
    "O": 1,
    "A": 1,
    "MI": 2,
    "MR": 2,
    "RM": 2,
    "OI": 2,
    "AI": 2,
    "AO": 2,
    "RMI": 3,
    "MRI": 3,
    "MRC": 3,
    "ZO": 0,
}
_OPERAND_MODES = {"r", "w", "W", "x"}
_MODIFIERS = {"ib", "iw", "id", "i*", "rb", "rw", "rd", "r*"}


@dataclass(frozen=True)
class Encoding:
    opc: int
    op_enc: str
    num_opnds: int
    ext: Optional[int]
    esc: bool
    ib: bool
    iw_or_id: bool
    rb: bool
    rw_or_rd: bool
    opnd0_mode: str
    opnd1_mode: str
    opnd2_mode: str

    @classmethod
    def parse(cls, raw_enc):
        esc = raw_enc.startswith("x")
        if esc:
            raw_enc = raw_enc[1:]

        enc_body, op_enc = raw_enc.split("~", 1)

        assert "~" in op_enc, f"missing operand modes for {raw_enc}"

        op_enc, opnd_modes = op_enc.split("~", 1)
        opnd_modes = list(opnd_modes)
        assert (
            len(opnd_modes) <= 3
        ), f"more modes than plausible operands: {len(opnd_modes)}"
        assert all(
            m in _OPERAND_MODES for m in opnd_modes
        ), f"unknown opnd mode(s): {opnd_modes}"
        opnd_modes += ["x"] * (3 - len(opnd_modes))

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

        assert opc < 2 ** 8, f"oversized opcode: {opc}"
        return cls(
            opc,
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
