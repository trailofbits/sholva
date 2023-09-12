# NOTE(jl): these files are not commited locally, and are passed from the output of mttn.
TRACES := $(wildcard *.trace.txt)

.PHONY: test
all: $(TRACES:.trace.txt=.circuit)

.PHONY: test
test: $(TRACES:.trace.txt=.verify)

#
# IR Backend
#
.PHONY: %.verify
%.verify: %.circuit
	wtk-firealarm $^ $(basename $^).public_input $(basename $^).private_input

%.circuit %.public_input %.private_input: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $@

%.ir1: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $@

#
# Benchmarks
#
.PHONY: nop_benchmark
nop_benchmark:
	@./nop-benchmark/gen.sh

.PHONY: buffer_overflow_benchmark
buffer_overflow_benchmark: buffer_overflow.c
	@./buffer-overflow-benchmark.sh

.PHONY: clean
clean:
	rm -f *.trace.txt *.circuit *.*_input tiny86.blif
