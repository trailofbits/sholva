TOP_MODULE := check
IVERILOG_FLAGS := -gstrict-expr-width
VERILATOR_FLAGS := -Wno-WIDTH
IFLAGS := -Icircuit -Icircuit/include

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

.PHONY: tiny86.blif
tiny86.blif: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	sv-netlist $(IFLAGS) --top tiny86 $^ -o $@

%.circuit: %.blif
	sv-compositor 

.PHONY: stat
stat: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	sv-stat $(IFLAGS) --top tiny86 $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)

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
lint: _lint-syntax _lint-synth

.PHONY: _lint-syntax
_lint-syntax: $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	# TODO(ww): Add -Wall here once we're actually using more of our wires.
	verilator $(VERILATOR_FLAGS) --top-module $(TOP_MODULE) --lint-only $(IFLAGS) $^
	hlint -g


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
	rm -rf $(CLASH_VERILOG) verilog/
