#!/usr/bin/env bash

for i in {0..10}; do
	n=$((2**i))
	cat ../nop.trace.txt | sv-compositor -b tiny86.blif -w /dev/stdin -o nop${n}.circuit
done

