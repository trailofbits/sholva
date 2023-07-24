#
# Top-level Targets
#

# verilog module, implicit defaults to $TOP_MODULE
# e.g., `YOSYS_MODULE=alu make yosys-stat` for isolated ALU statistics.
YOSYS_MODULE ?=

.PHONY: all
all: tiny86.blif

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
CLASH_VERILOG = circuit/execute/alu.v circuit/syscall.v

ALL_V := $(CLASH_VERILOG) \
	$(shell find . -type f -name "*.v")
ALL_V_WITHOUT_TESTS_OR_CODEGEN := $(CLASH_VERILOG) \
  	$(shell find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -path '*/verilog/*' \
		! -name '*.gen.v' \
)

SHOLVA_MODULES ?= \
	agu \
	alu \
	cfu \
	check \
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
PIPELINE_MODULES := check

TESTBENCH_EXES := $(addsuffix .tb.vvp, $(SHOLVA_MODULES))
PIPELINE_EXES  := $(addsuffix .tb.vvp, $(PIPELINE_MODULES))

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
# Circuit artifacts
#
tiny86.blif: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	sv-netlist $(IFLAGS) --top check $^ -o $@
#
# Formatting
#
.PHONY: format
format: # FIXME(jl) _format-verilog

.PHONY: _format-verilog
_format-verilog: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	verible-verilog-format --inplace $^

#
# Linting
#
.PHONY: lint
lint: _lint-verilog _lint-haskell _lint-synth _lint-yosys

.PHONY: _lint-verilog
_lint-verilog: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	# TODO(ww): Add -Wall here once we're actually using more of our wires.
	verilator $(VERILATOR_FLAGS) --top-module $(TOP_MODULE) --lint-only $(IFLAGS) $^
	verible-verilog-lint $^

.PHONY: _lint-haskell
_lint-haskell: $(CLASH_SRC)
	hlint $^

.PHONY: _lint-yosys
_lint-yosys: tiny86.blif
	yosys -QT -p 'read_blif $^; check'

.PHONY: _lint-synth
_lint-synth: circuit-codegen $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	iverilog $(IVERILOG_FLAGS) $(IFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-ycircuit/execute \
		-t null check.v

.PHONY: clean
clean:
	rm -rf $(CLASH_VERILOG) verilog/ tiny86.*
