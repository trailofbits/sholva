#!/bin/sh

qemu-i386 -d in_asm $(which "$1") 2>&1 | tee "$1".qemu.trace
