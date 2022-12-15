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

n=$((2**$1))
f=nop${n}.s

{ echo "${PRELUDE}";
for _ in $(seq "$n"); do
	echo "nop"
done
echo "${POSTLUDE}";
} > "$f"

make ${f%.s}.trace.txt
make ${f%.s}.circuit 
# another step here?
mkdir -p ~/test-infrastructure/tests/nop
# Something like cp ${f%.s}.{circuit,private_input,public_input}
