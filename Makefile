.PHONY: all
all: codegen
	iverilog -ycircuit \
		-Icircuit \
		-Icircuit/include \
		-t null tiny86.v

.PHONY: codegen
codegen:
	$(MAKE) -C circuit/codegen
