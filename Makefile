VFLAGS := -gstrict-expr-width

ALL_V := $(shell find . -name "*.v")

.PHONY: all
all: codegen $(ALL_V)
	iverilog $(VFLAGS) \
		-ycircuit \
		-ycircuit/decode \
		-Icircuit \
		-Icircuit/include \
		-t null tiny86.v

.PHONY: codegen
codegen:
	$(MAKE) -C circuit/codegen

.PHONY: test
test:
	$(MAKE) -C circuit/test check
