#
# BACK-ENDS
# 
tiny86.blif:
	tiny86.sh > $@

.PHONY: %.verify
%.verify: %.circuit
	wtk-firealarm $^ $(basename $^).public_input $(basename $^).private_input

%.circuit %.public_input %.private_input: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $@

%.ir1: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $@

#
# TOP-LEVEL
#
ARCH := $(shell uname -m)
.PHONY: test
ifeq ($(ARCH), x86_64)
test: _test-tiny86 _test-pipeline
else
test: _test-tiny86
	$(warning "mttn tests only possible on x86 architectures.")
endif

# mttn self tests
.PHONY: _test-mttn
_test-mttn: $(ALL_ELFS)
	cargo test --manifest-path=$(MTTN_PREFIX)/Cargo.toml

## sholva self tests
.PHONY: _test-tiny86
_test-tiny86: _test-clash _test-verilog

.PHONY: _test-clash
_test-clash:
	runghc -i$(SHOLVA_PREFIX)/src -iClash Clash.hs

.PHONY: _test-verilog
_test-verilog: $(TESTBENCH_EXES)
	./run-tests $(SHOLVA_MODULES)

.PHONY: _test-pipeline
_test-pipeline: $(PIPELINE_EXES)
	./run-tests $(PIPELINE_MODULES)

.PHONY: clean
clean:
	rm -rf $(TESTBENCH_EXES) $(PIPELINE_EXES) *.vcd *.e2e.tv \
	       *.elf *.jsonl *.trace.txt \
	       *.trace.* *.circuit *.*_input

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
