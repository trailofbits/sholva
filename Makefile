TOP_MODULE := check
IVERILOG_FLAGS := -gstrict-expr-width
IFLAGS := -Icircuit -Icircuit/include

ALL_V := $(shell find . -name "*.v")
ALL_V_WITHOUT_TESTS_OR_CODEGEN := $(shell \
	find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -name '*.gen.v' \
)

.PHONY: all
all: codegen $(ALL_V)
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
stat: codegen/
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

PROJ = Project
MAIN = topEntity
TOP = $(PROJ).$(MAIN)

.PHONY: clash
clash: src/$(PROJ).hs
	stack run -- clash src/$(PROJ).hs --verilog
	# FIXME(jl) just a hack at the moment for a single compiled verilog output.
	cp verilog/

.PHONY: test
test:
	stack test

.PHONY: clashi
clashi:
	stack run -- clashi
