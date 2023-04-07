#!/usr/bin/env python3

import argparse
import json
import pprint
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any


@dataclass
class WireTree:
    wire: dict
    deps: Any  # FIXME(jl): recursive dataclass type

    def __init__(self, wire, deps):
        self.wire = wire
        self.deps = deps


class Circuit:
    circuit: list[dict]

    def __init__(self, circuit):
        self.circuit = circuit

    def __getitem__(self, wire: int) -> dict:
        base = [op for op in self.circuit if wire == op.get("wire")]
        assert len(base) == 1  # all wires are single-assignment.
        return base[0]

    def require(self, op: dict) -> WireTree:
        """
        "top-down": what operations are required for the given op?
        """

        # filter non-"numbered wire" operands from op
        wires = [wire for wire in op["args"] if type(wire) == int]

        return WireTree(
            op,
            # termination condition: constants and inputs (any nullary op)
            [self.require(self.__getitem__(wire)) for wire in wires],
        )

    def depends(self, op: dict) -> WireTree:
        """
        "bottom-up": what operations depend on the given op?
        """

        return WireTree(
            op,
            [
                # termination condition: assertions (any void op)
                self.depends(dep)
                for dep in self.circuit
                if op.get("wire") in dep["args"]
            ],
        )


if __name__ == "__main__":
    parser = argparse.ArgumentParser("Recursively track tiny86 proof wires")
    parser.add_argument(
        "--traversal",
        choices=["require", "depend"],
        default="require",
        help="traversal method",
    )
    parser.add_argument(
        "--wire", "-w", type=int, required=True, help="target wire index"
    )
    parser.add_argument("jsonl", type=Path, help="proof JSONL artifact")
    args = parser.parse_args()

    with open(args.jsonl, "r") as f:
        circuit_json = [json.loads(line) for line in f]

    c = Circuit(circuit_json)
    op = c[args.wire]

    pp = pprint.PrettyPrinter(indent=1, compact=True)

    match args.traversal:
        case "depend":
            deps = c.depends(op)
            pp.pprint(deps)
        case "require":
            reqs = c.require(op)
            pp.pprint(reqs)
