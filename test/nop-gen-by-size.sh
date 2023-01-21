#!/usr/bin/env bash

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

n=$1
f=nop${n}

{ echo "${PRELUDE}";
  for _ in $(seq "$n"); do
  	echo "nop"
  done
  echo "${POSTLUDE}";
} > "$f".s

make "$f".circuit

# NOTE(jl): verify existance of directory.
mkdir -p $2
cp nop"${n}".{circuit,circuit.{public,private}_input} $2
