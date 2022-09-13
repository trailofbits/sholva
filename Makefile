TOP_MODULE := check
IVERILOG_FLAGS := -gstrict-expr-width
IFLAGS := -Icircuit -Icircuit/include

ALL_V := $(shell find . -name "*.v")
ALL_V_WITHOUT_TESTS_OR_CODEGEN := $(shell \
	find . -type f -name '*.v' \
		! -path '*/test/*' \
		! -name '*.gen.v' \
)
CLASH_VERILOG = circuit/execute/alu.v


.PHONY: all
all: codegen $(ALL_V) $(CLASH_VERILOG)
	iverilog $(IVERILOG_FLAGS) $(IFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-ycircuit/execute \
		-t null check.v

tiny86.blif:
	sv-netlist $(IFLAGS) --top tiny86 $@ $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)

tiny86.bristol: tiny86.blif
	# use a test trace as witness.
	cat circuit/test/alu_add.trace.txt | head -n1 | sv-compositor -b $^ -o $@ -w /dev/stdin

.PHONY: stat
stat:
	sv-stat $(IFLAGS) --top tiny86 $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)

.PHONY: codegen
codegen:
	$(MAKE) -C circuit/codegen

.PHONY: lint
lint:
	# TODO(ww): Add -Wall here once we're actually using more of our wires.
	verilator --top-module $(TOP_MODULE) --lint-only $(IFLAGS) $(ALL_V_WITHOUT_TESTS_OR_CODEGEN)
	hlint -g

check: _check-verilog _check-haskell

.PHONY: _check-verilog
_check-verilog:
	@$(MAKE) V=1 -C circuit/test check

.PHONY: _check-haskell
_check-haskell:
	runghc -isrc -itest test/Main.hs

.PHONY: clean
clean:
	$(MAKE) -C circuit/test clean
	rm -rf verilog/

verilog/Alu.alu/alu.v: src/Alu.hs
	clash -isrc -fclash-clear $^ --verilog
	sed -i '/timescale/d' $@

circuit/execute/alu.v: verilog/Alu.alu/alu.v
	@echo "overwriting with compiled clash"
	mv verilog/Alu.alu/alu.v $@
