#!/usr/bin/env bash

#
# NOTE(jl): needs to be ran from sholva's test directory.
# returns: the IR0 artifacts in directory $2 for a buffer overflow of size $1
#

n=$1
CFLAGS="-DBUF_LEN=${n}" make buffer_overflow.trace.txt -B
mv buffer_overflow.trace.txt buffer_overflow"${n}".trace.txt
make buffer_overflow"${n}".circuit

# NOTE(jl): verify existance of directory.
mkdir -p $2
cp buffer_overflow"${n}".{circuit,circuit.{public,private}_input} $2
