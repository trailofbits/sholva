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

for i in {0..20}; do
	n=$((2**i))
	f=nop${n}.s

        { echo "${PRELUDE}";
	  for _ in $(seq "$n"); do
		  echo "nop"
	  done
	  echo "${POSTLUDE}";
        } > "$f"

	make ${f%.s}.trace.txt
done

