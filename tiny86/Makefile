TOP_MODULE := check
IVERILOG_FLAGS := -gstrict-expr-width
VERILATOR_FLAGS := -Wno-WIDTH
IFLAGS := -Icircuit -Icircuit/include

CLASH_SRC = $(shell find . -type f -name "*.hs")
CLASH_VERILOG = circuit/execute/alu.v circuit/syscall.v

ALL_V := $(CLASH_VERILOG) \
  $(shell find . -name "*.v")

ALL_V_WITHOUT_TESTS_OR_CODEGEN := $(CLASH_VERILOG) \
  $(shell find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -path '*/verilog/*' \
		! -name '*.gen.v' \
)

.PHONY: all
all: tiny86.blif

#
# Circuit artifacts
#

tiny86.blif: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	sv-netlist $(IFLAGS) --top check $^ -o $@

tiny86.json: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	sv-netlist $(IFLAGS) --json --top check $^ -o $@


# the parametrized verilog module; defaults to top-level
# e.g., `YOSYS_MODULE=alu make yosys-show` will generate an SVG of the ALU circuit.
YOSYS_MODULE ?=

.PHONY: yosys-stat
yosys-stat:
	yosys -QT -p 'read_json tiny86.json; stat $(YOSYS_MODULE)'

.PHONY: sv-stat
sv-stat: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	sv-stat $(IFLAGS) --top tiny86 $^

.PHONY: codegen
codegen:
	$(MAKE) -C circuit/codegen

#
# Clash targets
#
circuit/execute/alu.v: src/Alu.hs src/Alu/*.hs
	clash -isrc -fclash-clear $< --verilog
	sed '/timescale/d' verilog/Alu.top/alu.v > $@

circuit/syscall.v: src/Syscall.hs src/Syscall/*.hs
	clash -isrc -fclash-clear $< --verilog
	sed '/timescale/d' verilog/Syscall.top/syscall.v > $@

.PHONY: lint
lint: _lint-verilog _lint-haskell _lint-synth _lint-yosys

.PHONY: _lint-verilog
_lint-verilog: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	# TODO(ww): Add -Wall here once we're actually using more of our wires.
	verilator $(VERILATOR_FLAGS) --top-module $(TOP_MODULE) --lint-only $(IFLAGS) $^

.PHONY: _lint-haskell
_lint-haskell: $(CLASH_SRC)
	hlint $^

.PHONY: _lint-yosys
_lint-yosys: tiny86.json
	yosys -QT -p 'read_json tiny86.json; check'

.PHONY: _lint-synth
_lint-synth: codegen $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	iverilog $(IVERILOG_FLAGS) $(IFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-ycircuit/execute \
		-t null check.v

.PHONY: install
install:

.PHONY: clean
clean:
	rm -rf $(CLASH_VERILOG) verilog/ tiny86.*
