TBGEN := ./codegen/tbgen
TVGEN := ./codegen/tvgen

MODULES := fetch \
	decode_hint \
	decode_prefix \
	decode_opc_phase1 \
	decode_opc_phase2 \
	decode \
	execute \
	mux8_32 \
	regfile \
	decode_opnds \
	alu \
	agu \
	tiny86

TESTBENCHES := $(addsuffix .tb.gen.v,$(MODULES))
TESTVECTORS := $(addsuffix .tv,$(MODULES))
TESTBENCH_EXES := $(addsuffix .tb.vvp,$(MODULES))

.PHONY: all
all: $(TESTBENCH_EXES) $(TESTVECTORS)

.PHONY: check
check: all
	@./run-tests

.PHONY: clean
clean:
	rm -rf $(TESTBENCHES) $(TESTVECTORS) $(TESTBENCH_EXES) *.vcd

%.tb.yml: $(TBGEN) $(TVGEN)

%.tb.gen.v: %.tb.yml
	$(TBGEN) $<

%.tv: %.tb.yml
	$(TVGEN) $<

%.tb.vvp: %.tb.gen.v
	iverilog -o $@ \
		-I.. -I../include \
		-y.. \
		-y../.. \
		-y../decode \
		-y../execute \
		$<
