TBGEN := ./codegen/tbgen
TVGEN := ./codegen/tvgen

MODULES := fetch \
	decode_prefix \
	decode_opc_phase1 \
	decode_opc_phase2 \
	decode \
	execute \
	mux8_32 \
	regfile \
	decode_opnds \
	alu \
	tiny86

TB_SPECS := $(addsuffix .tb.yml,$(MODULES))
TESTBENCHES := $(addsuffix .tb.gen.v,$(MODULES))
TESTVECTORS := $(addsuffix .tv,$(MODULES))
TESTBENCH_EXES := $(addsuffix .tb.vvp,$(MODULES))

.PHONY: all
all: $(TESTBENCH_EXES)

.PHONT: check
check: $(TESTBENCH_EXES)
	@./run-tests

$(TESTBENCH_EXES): $(TESTBENCHES) $(TESTVECTORS)
	iverilog -o $@ \
		-I.. -I../include \
		-y.. \
		-y../.. \
		-y../decode \
		-y../execute \
		$(basename $@).gen.v

$(TESTBENCHES): $(TB_SPECS) $(TBGEN)
	$(TBGEN) $(basename $(basename $@)).yml

$(TESTVECTORS): $(TB_SPECS) $(TVGEN)
	$(TVGEN) $(basename $(basename $@)).tb.yml

.PHONY: clean
clean:
	rm -rf $(TESTBENCHES) $(TESTVECTORS) $(TESTBENCH_EXES) *.vcd
