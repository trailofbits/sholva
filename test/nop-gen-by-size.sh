#!/usr/bin/env bash

# nop-gen-by-size.sh
#
# a contrived scalability test that generates a trace of all NOPs.
#
# arguments:
# - $1: the number of NOPs.
# - $2: the output directory to be formatted in the expected T&E format.
#
# NOTE(jl): because this script directly calls `make`, it needs to be run from
# sholva's test/ directory.

PRELUDE="""
section .text
global _start

_start:
"""

POSTLUDE="""
; exit
mov eax, 1
int 0x80
"""

set -eu

SIZE=$1
TARGET=nop${SIZE}

# write to $TARGET.s assembly source containing $SIZE nops.
{ echo "${PRELUDE}";
  for _ in $(seq "$SIZE"); do
  	echo "nop"
  done
  echo "${POSTLUDE}";
} > "$TARGET".s

nix shell .#{mttn,sv_circuit} nixpkgs#{nasm,gnumake,pkgsi686Linux.gcc} -c make "$TARGET".circuit

mkdir -p "$2"
mkdir -p "$2/instance"
mv "${TARGET}.public_input" "$2/instance/${TARGET}.public_input"
mkdir -p "$2/witness"
mv "${TARGET}.private_input" "$2/witness/${TARGET}.private_input"
mkdir -p "$2/relation"
mv "${TARGET}.circuit" "$2/relation/${TARGET}.circuit"
