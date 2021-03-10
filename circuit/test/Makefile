TBGEN := ./codegen/tbgen
TVGEN := ./codegen/tvgen

MODULES := fetch decode_prefix

TB_SPECS := $(addsuffix .tb.yml,$(MODULES))
TESTBENCHES := $(addsuffix .tb.gen.v,$(MODULES))
TESTVECTORS := $(addsuffix .tv,$(MODULES))
TESTBENCH_EXES := $(addsuffix .tb.vvp,$(MODULES))

.PHONY: all
all: $(TESTBENCH_EXES)

$(TESTBENCH_EXES): $(TESTBENCHES) $(TESTVECTORS)
	iverilog -o $@ -I.. -I../include -y.. $(basename $@).gen.v

$(TESTBENCHES): $(TB_SPECS) $(TBGEN)
	$(TBGEN) $(basename $(basename $@)).yml

$(TESTVECTORS): $(TB_SPECS) $(TVGEN)
	$(TVGEN) $(basename $(basename $@)).tb.yml

.PHONY: clean
clean:
	rm -rf $(TESTBENCHES) $(TESTVECTORS) $(TESTBENCH_EXES)
