VFLAGS := -gstrict-expr-width

.PHONY: all
all: codegen
	iverilog $(VFLAGS) -ycircuit \
		-Icircuit \
		-Icircuit/include \
		-t null tiny86.v

.PHONY: codegen
codegen:
	$(MAKE) -C circuit/codegen
