TBGEN := ./codegen/tbgen
TVGEN := ./codegen/tvgen
E2EGEN := ./codegen/e2egen

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
	decode_opnd_signals \
	alu \
	agu \
	meta \
	move \
	cfu \
	tiny86 \
	check

TESTBENCHES := $(addsuffix .tb.gen.v,$(MODULES))
TESTVECTORS := $(addsuffix .tv,$(MODULES))
TESTBENCH_EXES := $(addsuffix .tb.vvp,$(MODULES))

TRACES := $(wildcard *.trace.txt)
TRACE_BASES := $(basename $(basename $(TRACES)))

.PHONY: all
all: $(TESTBENCH_EXES) $(TESTVECTORS)

.PHONY: check
check: all
	@./run-tests $(CHECKS)

.PHONY: clean
clean:
	rm -rf $(TESTBENCHES) $(TESTVECTORS) $(TESTBENCH_EXES) *.vcd *.e2e.tv

check.tb.yml: check.e2e.tv

check.e2e.tv: $(E2EGEN) $(TRACES)
	$(E2EGEN) $(TRACE_BASES) > $@

%.tb.yml: $(TBGEN) $(TVGEN) $(E2EGEN)

%.tb.gen.v: %.tb.yml
	$(TBGEN) $<

check.tv: check.e2e.tv

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
