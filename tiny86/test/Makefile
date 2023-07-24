#
# Integration tests
#
TBGEN  := ./codegen/tbgen
TVGEN  := ./codegen/tvgen
E2EGEN := ./codegen/e2egen
COMMON := ./codegen/common.rb
$(TBGEN) $(TVGEN) $(E2EGEN): $(COMMON)

test/%.tb.yml: $(TBGEN) $(TVGEN) $(E2EGEN)

test/%.tb.gen.v: test/%.tb.yml
	$(TBGEN) $<

test/%.tv: test/%.tb.yml
	$(TVGEN) $<

test/%.tb.vvp: test/%.tb.gen.v
	iverilog -o $@ \
		-I./circuit/ \
		-I./circuit/include \
		-y./circuit \
		-y./circuit/decode \
		-y./circuit/execute \
		$<

test/check.tb.yml: test/check.e2e.tv

test/check.e2e.tv: $(E2EGEN) $(TRACE_TEXTS)
	$(E2EGEN) $(TRACE_BASES) > $@

test/check.tv: test/check.e2e.tv
