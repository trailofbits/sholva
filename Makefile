all:
	iverilog -ycircuit \
		-Icircuit \
		-Icircuit/include \
		-t null tiny86.v
