#!/usr/bin/env bash

# HACK(jl): for this example, the trace lengths do not increase exponential below buffer sizes of ~1024 bytes.
# we also want to demonstrate exponential behavior, but not spend exponentially more time tracing.
# so, pick:
# - a base _n_ s.t. n > 1... but not much bigger
# - a shift  _k_ s.t. n^k > 1024... but not much bigger
#
# here, for n=1.3 k=28, exponential behavior is clear with a max/min of only ~10.
#
# ```python
# >>> list(map(lambda n: round(1.3 ** (n + 28)), range(10)))
# [1550, 2015, 2620, 3406, 4428, 5756, 7483, 9728, 12646, 16440]
# ```
n=$1
CFLAGS="-DBUF_LEN=${n}" make buffer_overflow.trace.txt -B
mv buffer_overflow.trace.txt buffer_overflow"${n}".trace.txt

make ${buffer_overflow"${n}"%.trace.txt}.circuit 
# another step here to make .private_input, .public_input?
mkdir -p ~/test-infrastructure/tests/buffer-overflow
# mv buffer_overflow"${n}".{circuit,private_input,public_input} ~/test-infrastructure/tests/buffer-overflow