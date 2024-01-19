#!/usr/bin/env bash

# buffer-overflow-gen-by-size.sh
#
# in an attempt to make a "real world exploit" that's also scalable
# to an arbitrary number of trace steps, we've contrived a simple
# buffer overflow example parametrized by the C preprocessor `-DBUF_LEN`
#
# arguments:
# - $1: the defined buffer size. Larger generates number generates more trace steps.
# - $2: the output directory to be formatted in the expected T&E format.
#
# NOTE(jl): because this script directly calls `make`, it needs to be run from
# sholva's test/ directory.

set -e

SIZE=$1

CFLAGS="-DBUF_LEN=${SIZE}" MTTN="cargo run --" nix develop .#mttn -c make -C ../mttn/test buffer_overflow.nostdlib.trace.txt
mv ../mttn/test/buffer_overflow.nostdlib.trace.txt "buffer_overflow${SIZE}.trace.txt"
nix shell .#sv_circuit nixpkgs#gnumake -c make "buffer_overflow${SIZE}.circuit"

mkdir -p "$2"
mkdir -p "$2"/instance
mv buffer_overflow"${SIZE}".public_input "$2"/instance/
mkdir -p "$2"/witness
mv buffer_overflow"${SIZE}".private_input "$2"/witness/
mkdir -p "$2"/relation
mv buffer_overflow"${SIZE}".circuit "$2"/relation/
