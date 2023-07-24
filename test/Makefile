.PHONY: %.verify
%.verify: %.circuit
	wtk-firealarm $^ $(basename $^).public_input $(basename $^).private_input

%.circuit %.public_input %.private_input: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $@

%.ir1: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $@

## sholva self tests
.PHONY: _test-pipeline
_test-pipeline: $(PIPELINE_EXES)
	./run-tests $(PIPELINE_MODULES)
#
# ARTIFACTS
#
.PHONY: nop_benchmark
nop_benchmark:
	@./nop-benchmark/gen.sh

.PHONY: buffer_overflow_benchmark
buffer_overflow_benchmark: buffer_overflow.c
	@./buffer-overflow-benchmark.sh

# produce consumable IR0 artifacts for all generated program traces.
.PHONY: artifacts
artifacts: $(TRACE_TEXTS:.trace.txt=.circuit)
