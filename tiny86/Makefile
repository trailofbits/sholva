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

# Hand-written verilog.
VERILOG_SRC = \
  	$(shell find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -path '*/verilog/*' \
		! -name '*.gen.v' \
)

# All verilog.
CIRCUIT_CODEGEN = circuit/codegen/commands.gen.v cicuit/codegen/opc_map.gen.v
$(CIRCUIT_CODEGEN):
	$(MAKE) -C circuit/codegen
CIRCUIT_SRC = $(VERILOG_CLASH) $(VERILOG_SRC)
$(CIRCUIT_SRC): $(CIRCUIT_CODEGEN)

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

circuit/execute/alu.v: src/Alu.hs src/Alu/*.hs
	clash -isrc $< --verilog
	sed '/timescale/d' verilog/Alu.top/alu.v > $@

circuit/syscall.v: src/Syscall.hs src/Syscall/*.hs
	clash -isrc $< --verilog
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


.PHONY: _test-clash
_test-clash: $(CLASH_SRC) $(CLASH_TESTS)
	$(MAKE) -C test-clash

.PHONY: _test-verilog
_test-verilog: $(TESTBENCHES)
	./test/run-tests $^ 

check.tb.yml: check.e2e.tv

# NOTE(jl): traces are populated by the mttn test suite.
test/check.e2e.tv: $(E2EGEN)
	$(E2EGEN) $(wildcard test/*.trace.txt) > $@

test/check.tb.yml: test/check.e2e.tv

test/check.tv: test/check.e2e.tv

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
#
# Circuit artifacts
#

## ZK gate mappings
synth.tcl: zk.lib

## TCL builder script
$(CIRCUIT_SRC): synth.tcl

## circuit synthesis
tiny86.blif: $(CIRCUIT_SRC)
	yosys -c synth.tcl $^

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
_lint-synth: $(CIRCUIT_CODEGEN) $(VERILOG_SRC)
	iverilog $(IVERILOG_FLAGS) $(IFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-ycircuit/execute \
		-t null check.v

.PHONY: clean
clean:
	$(MAKE) -C circuit/codegen clean
	rm -rf $(VERILOG_CLASH) verilog/ \
		circuit/codegen/*.gen.v \
		tiny86.* *.vcd \
		test/*.gen.v test/*.tb.vvp test/*.tv
