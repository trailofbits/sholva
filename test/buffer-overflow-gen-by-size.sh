#!/usr/bin/env bash

#
# NOTE(jl): needs to be run from sholva's test directory.
# returns: the IR0 artifacts in directory $2 for a buffer overflow of size $1
#

n=$1
CFLAGS="-fno-pic -g -m32 -mtune=i386 -Wl,-emain -nostdlib -static -std=c99 -mpreferred-stack-boundary=2 -fno-stack-protector -z execstack -DBUF_LEN=${n}" 
gcc ${CFLAGS} buffer_overflow.c -o buffer_overflow"${n}".elf
make buffer_overflow"${n}".trace.txt
make buffer_overflow"${n}".circuit

# NOTE(jl): verify existance of directory.
mkdir -p "$2"
mkdir -p "$2"/instance
mv buffer_overflow"${n}".public_input "$2"/instance/buffer_overflow"${n}".public_input
mkdir -p "$2"/witness
mv buffer_overflow"${n}".private_input "$2"/witness/buffer_overflow"${n}".private_input
mkdir -p "$2"/relation
mv buffer_overflow"${n}".circuit "$2"/relation/buffer_overflow"${n}".circuit

