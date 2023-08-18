#
# Top-level Targets
#
.PHONY: all
all: tiny86.blif

.PHONY: test
test: _test-clash _test-verilog

# verilog module, implicitly defaults to `-auto-top` ($TOP_MODULE, here)
# e.g., `YOSYS_MODULE=alu make yosys-stat` for isolated ALU statistics.
YOSYS_MODULE ?=

.PHONY: stat
stat: tiny86.blif
	yosys -QT -p 'read_blif $^; stat $(YOSYS_MODULE)'

#
# Build Definitions
#
TOP_MODULE := check
IVERILOG_FLAGS := -gstrict-expr-width
VERILATOR_FLAGS := -Wno-WIDTH
IFLAGS := -Icircuit -Icircuit/include

CLASH_SRC = $(shell find src/ -type f -name "*.hs")
CLASH_TESTS = $(shell find test/ -type f -name "*.hs")
VERILOG_CLASH = circuit/execute/alu.v circuit/syscall.v

VERILOG_SRC = \
  	$(shell find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -path '*/verilog/*' \
		! -name '*.gen.v' \
)

CIRCUIT_SRC := $(VERILOG_CLASH) $(VERILOG_SRC)

SHOLVA_MODULES ?= \
	agu \
	alu \
	cfu \
	decode \
	decode_hint \
	decode_opc_phase1 \
	decode_opc_phase2 \
	decode_opnd_signals \
	decode_opnds \
	decode_prefix \
	execute \
	fetch \
	meta \
	move \
	mux8_32 \
	regfile \
	tiny86 \
	syscall

#
# Synthesis
#
.PHONY: circuit-codegen
circuit-codegen:
	$(MAKE) -C circuit/codegen

circuit/execute/alu.v: src/Alu.hs src/Alu/*.hs
	clash -isrc -fclash-clear $< --verilog
	sed '/timescale/d' verilog/Alu.top/alu.v > $@

circuit/syscall.v: src/Syscall.hs src/Syscall/*.hs
	clash -isrc -fclash-clear $< --verilog
	sed '/timescale/d' verilog/Syscall.top/syscall.v > $@

#
# Tests
#
TBGEN  := ./test/codegen/tbgen
TVGEN  := ./test/codegen/tvgen
E2EGEN := ./test/codegen/e2egen
COMMON := ./test/codegen/common.rb
$(TBGEN) $(TVGEN) $(E2EGEN): $(COMMON)

TESTBENCHES := $(addprefix test/, $(addsuffix .tb.vvp, $(SHOLVA_MODULES)))
TESTVECTORS := $(addprefix test/, $(addsuffix .tv,     $(SHOLVA_MODULES)))
$(TESTBENCHES): $(CIRCUIT_SRC) $(TESTVECTORS)

.PHONY: _test-verilog
_test-verilog: $(TESTBENCHES)
	./test/run-tests $^ || true # FIXME

.PHONY: _test-clash
_test-clash: $(CLASH_SRC) $(CLASH_TESTS)
	$(MAKE) -C test-clash

test/%.tb.yml: $(TBGEN) $(TVGEN) $(E2EGEN)

test/%.tb.gen.v: test/%.tb.yml
	$(TBGEN) $<

test/%.tv: test/%.tb.yml
	$(TVGEN) $<

test/%.tb.vvp: test/%.tb.gen.v
	iverilog -o $@ \
		-I./circuit \
		-I./circuit/include \
		-y. \
		-y./circuit \
		-y./circuit/decode \
		-y./circuit/execute \
		$<

test/check.e2e.tv: $(E2EGEN)
	$(E2EGEN) $(wildcard *.trace.txt) > $@

test/check.tb.yml: test/check.e2e.tv

#
# Circuit artifacts
#
tiny86.blif: $(CIRCUIT_SRC)
	sv-netlist $(IFLAGS) --top check $^ -o $@

#
# Formatting
#
.PHONY: format
format: # FIXME(jl) _format-verilog

.PHONY: _format-verilog
_format-verilog: $(VERILOG_SRC)
	verible-verilog-format --inplace $^

#
# Linting
#
.PHONY: lint
lint: _lint-verilog _lint-haskell _lint-synth _lint-yosys

.PHONY: _lint-verilog
_lint-verilog: _lint-verilog-verilator _lint-verilog-verible

_lint-verilog-verilator: $(VERILOG_SRC)
	verilator $(VERILATOR_FLAGS) --top-module $(TOP_MODULE) --lint-only $(IFLAGS) $^

_lint-verilog-verible: $(VERILOG_SRC)
	verible-verilog-lint $^

.PHONY: _lint-haskell
_lint-haskell: $(CLASH_SRC)
	hlint $^

.PHONY: _lint-yosys
_lint-yosys: tiny86.blif
	yosys -QT -p 'read_blif $^; check'

.PHONY: _lint-synth
_lint-synth: circuit-codegen $(VERILOG_SRC)
	iverilog $(IVERILOG_FLAGS) $(IFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-ycircuit/execute \
		-t null check.v

.PHONY: clean
clean:
	rm -rf $(VERILOG_CLASH) verilog/ tiny86.* \
		*.vcd test/*.gen.v test/*.tb.vvp test/*.tv
