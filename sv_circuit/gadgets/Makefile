all: intra_bucket.blif

intra_bucket.blif: src/IntraBucket.hs src/MemoryHint.hs src/MemoryBucket.hs
	clash -isrc $< --verilog
	yosys -c synth.tcl verilog/IntraBucket.top/intra_bucket.v

.PHONY: clean
clean:
	rm -f *.blif
