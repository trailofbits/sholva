#!/usr/bin/env python3

# parse_encodings.py: convert "encodings.spec" into "commands.json"

import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Optional

_HERE = Path(__file__).parent
_ENCODINGS_SPEC = _HERE / "encodings.spec"
_COMMANDS_JSON = _HERE / "commands.json"


_OPERAND_ENCODINGS = {"I", "D", "M", "O", "MI", "MR", "RM", "OI", "AI", "RMI", "MRI", "MRC", "ZO"}
_MODIFIERS = {"ib", "iw", "id", "i*", "rb", "rw", "rd", "r*"}


@dataclass(frozen=True)
class Encoding:
    opc: int
    op_enc: str
    ext: Optional[int]
    esc: bool
    ib: bool
    iw_or_id: bool
    rb: bool
    rw_or_rd: bool

    @classmethod
    def parse(cls, raw_enc):
        esc = raw_enc.startswith("x")
        if esc:
            raw_enc = raw_enc[1:]

        enc_body, op_enc = raw_enc.split("~", 1)
        assert op_enc in _OPERAND_ENCODINGS, f"unknown operand encoding: {op_enc}"

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
        return cls(opc, op_enc, ext, esc, ib, iw_or_id, rb, rw_or_rd)


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
        print(json.dumps(specs), file=io)


if __name__ == "__main__":
    main()
