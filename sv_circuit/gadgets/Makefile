all: intra_bucket.blif

intra_bucket.blif: src/IntraBucket.hs
	clash -isrc $< --verilog
	yosys verilog/IntraBucket.top/intra_bucket.v -o $@

.PHONY: clean
clean:
	rm -f *.blif
