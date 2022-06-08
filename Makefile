TOP_MODULE := check
IVERILOG_FLAGS := -gstrict-expr-width
IFLAGS := -Icircuit -Icircuit/include

ALL_V := $(shell find . -name "*.v")
ALL_V_WITHOUT_TESTS_OR_CODEGEN := $(shell \
	find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -name '*.gen.v' \
)
ALL_V := $(ALL_V) circuit/execute/alu.v


.PHONY: all
all: codegen $(ALL_V) $(CLASH_VERILOG)
	iverilog $(IVERILOG_FLAGS) $(IFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-ycircuit/execute \
		-t null check.v

.PHONY: netlistify
netlistify: tiny86.blif

tiny86.blif: codegen
	sv-netlist $(IFLAGS) --top tiny86 $@ $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)

.PHONY: stat
stat: codegen
	sv-stat $(IFLAGS) --top tiny86 $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)

.PHONY: codegen
codegen:
	$(MAKE) -C circuit/codegen

.PHONY: lint
lint:
	# TODO(ww): Add -Wall here once we're actually using more of our wires.
	verilator --top-module $(TOP_MODULE) --lint-only $(IFLAGS) $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)

.PHONY: check
check:
	@$(MAKE) -C circuit/test check

.PHONY: clean
clean:
	$(MAKE) -C circuit/test clean
	stack clean
	rm -rf verilog/

verilog/%.v: src/%.hs
	stack run -- clash $^ --verilog

circuit/execute/alu.v: verilog/Alu.v
	@echo "overwriting with compiled clash"
	# move to prevent duplicates with `find . -name "*.v"` (hack)
	mv verilog/Alu.alu/alu.v $@

.PHONY: test
test:
	stack test

.PHONY: clashi
clashi:
	stack run -- clashi
