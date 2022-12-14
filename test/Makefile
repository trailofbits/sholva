#
# HDL TESTS
#
SHOLVA_PREFIX  := ../tiny86
SHOLVA_MODULES := \
	agu \
	alu \
	cfu \
	check \
	decode \
	decode_hint \
	decode_opc_phase1 \
	decode_opc_phase2 \
	decode_opnd_signals \
	decode_opnds \
	decode_prefix \
	execute \
	fetch \
	meta \
	move \
	mux8_32 \
	regfile \
	tiny86
TESTBENCH_EXES := $(addsuffix .tb.vvp,$(SHOLVA_MODULES))

%.tb.yml: $(TBGEN) $(TVGEN) $(E2EGEN)

%.tb.gen.v: %.tb.yml
	$(TBGEN) $<

%.tv: %.tb.yml
	$(TVGEN) $<

%.tb.vvp: %.tb.gen.v
	iverilog -o $@ \
		-I$(SHOLVA_PREFIX)/circuit/ \
		-I$(SHOLVA_PREFIX)/circuit/include \
		-y$(SHOLVA_PREFIX) \
		-y$(SHOLVA_PREFIX)/circuit \
		-y$(SHOLVA_PREFIX)/circuit/decode \
		-y$(SHOLVA_PREFIX)/circuit/execute \
		$<

#
# TESTS
#
ASM_TESTS := \
	alu_adc \
	alu_add \
	alu_add_neg \
	cdq \
	jmp \
	lea \
	loop_ \
	memops \
	mov_r_r \
	push_pop \
	push_pop2 \
	rcl \
	rol \
	stosb \
	stosd \
	stosw \
	tinysyscall \
	xchg_r_r
ASM_SOURCES := $(ASM_TESTS:=.s)
ASM_OBJS := $(ASM_SOURCES:.s=.o)
ASM_ELFS := $(ASM_OBJS:.o=.elf)

C_TESTS := \
	condition \
	jumptable \
	seteip \
	smallcall
C_SOURCES := $(C_TESTS:=.c)
C_ELFS := $(C_SOURCES:.c=.elf)
CFLAGS += -fno-pic -g -m32 -mtune=i386 -Wl,-emain -nostdlib -static -std=c99 \
		-mpreferred-stack-boundary=2 -fno-stack-protector -z execstack


ALL_ELFS := $(ASM_ELFS) $(C_ELFS)

%.elf: %.o
	ld -m elf_i386 $(basename $@).o -o $(basename $@).elf
	chmod +x $(basename $@).elf

%.o: %.s
	nasm -f elf32 $(basename $@).s -o $(basename $@).o

%.elf: %.c
	$(CC) $(CFLAGS) $(basename $@).c -o $(basename $@).elf 


#
# TRACING
#
MTTN_PREFIX := ../mttn
MTTN := cargo run --manifest-path=$(MTTN_PREFIX)/Cargo.toml --quiet --bin mttn --

# NOTE(ww): No default traces for the C tests, since some are interactive/take
# environmental inputs.
TRACE_JSONLS := $(ASM_ELFS:.elf=.trace.jsonl)
TRACE_TEXTS := $(ASM_ELFS:.elf=.trace.txt)

.DELETE_ON_ERROR:
%.trace.jsonl: %.elf
	$(MTTN) -At --syscall-model=decree -m32 -F jsonl ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.elf
	$(MTTN) -At --syscall-model=decree -m32 -F tiny86-text ./$< > $@

#
# INTEGRATION
#
TBGEN  := ./codegen/tbgen
TVGEN  := ./codegen/tvgen
E2EGEN := ./codegen/e2egen
COMMON := ./codegen/common.rb
$(TBGEN) $(TVGEN) $(E2EGEN): $(COMMON)

check.tb.yml: check.e2e.tv

check.e2e.tv: $(E2EGEN) $(TRACE_TEXTS)
	$(E2EGEN) $(TRACE_BASES) > $@

check.tv: check.e2e.tv

#
# TOP-LEVEL
#
.PHONY: all
all: $(TESTBENCH_EXES) $(ALL_ELF)

.PHONY: test
test: _test-mttn _test-sholva

.PHONY: _test-mttn
_test-mttn: $(ALL_ELFS)
	cargo test --manifest-path=$(MTTN_PREFIX)/Cargo.toml

.PHONY: _test-sholva
_test-sholva: _test-clash _test-verilog

.PHONY: _test-clash
_test-clash:
	runghc -i$(SHOLVA_PREFIX)/src Main.hs

.PHONY: _test-verilog
_test-verilog: $(TESTBENCH_EXES)
	@./run-tests $(CHECKS)

.PHONY: clean
clean:
	rm -rf $(TESTBENCH_EXES) *.vcd *.e2e.tv \
	       *.trace.* *.circuit *.*_input

#
# ARTIFACTS
#
.PHONY: nop_benchmark
nop_benchmark:
	@./nop-benchmark/gen.sh

.PHONY: buffer_overflow_benchmark
buffer_overflow_benchmark: buffer_overflow.c
	@./buffer-overflow-benchmark.sh

TRACES := $(wildcard *.trace.txt)

# produce consumable IR0 artifacts for all generated program traces.
.PHONY: artifacts
artifacts: $(TRACES:.trace.txt=.circuit)

%.circuit: %.trace.txt
	sv-compositor -b $(TOP_CIRCUIT) -o $@ -w $^

tiny86.bristol: tiny86.blif
	# use a test trace as witness.
	cat circuit/test/alu_add.trace.txt | head -n1 | sv-compositor -b $^ -o $@ -w /dev/stdin
