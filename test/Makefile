TBGEN := ./codegen/tbgen
TVGEN := ./codegen/tvgen
E2EGEN := ./codegen/e2egen
COMMON := ./codegen/common.rb

SHOLVA_PREFIX := ../tiny86
SHOLVA_MODULES := fetch \
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

ASM_TESTS := \
	cdq \
	memops \
	stosb \
	stosw \
	stosd \
	alu_adc \
	alu_add_neg \
	alu_add \
	mov_r_r \
	xchg_r_r \
	lea \
	loop_ \
	rcl \
	rol \
	jmp \
	push_pop \
	push_pop2 \
	tinysyscall

C_TESTS := \
	seteip \
	smallcall \
	jumptable \
	condition

TESTBENCHES := $(addsuffix .tb.gen.v,$(SHOLVA_MODULES))
TESTVECTORS := $(addsuffix .tv,$(SHOLVA_MODULES))
TESTBENCH_EXES := $(addsuffix .tb.vvp,$(SHOLVA_MODULES))

MTTN_PREFIX := ../mttn
MTTN := cargo run --manifest-path=$(MTTN_PREFIX)/Cargo.toml --quiet --bin mttn --

ASM_SOURCES := $(ASM_TESTS:=.s)
ASM_OBJS := $(ASM_SOURCES:.s=.o)
ASM_ELFS := $(ASM_OBJS:.o=.elf)

C_SOURCES := $(C_TESTS:=.c)
C_ELFS := $(C_SOURCES:.c=.elf)

ALL_OBJS := $(ASM_OBJS)
ALL_ELFS := $(ASM_ELFS) $(C_ELFS)

# NOTE(ww): No default traces for the C tests, since some are interactive/take
# environmental inputs.
TRACE_JSONLS := $(ASM_ELFS:.elf=.trace.jsonl)
TRACE_TEXTS := $(ASM_ELFS:.elf=.trace.txt)

$(TBGEN) $(TVGEN) $(E2EGEN): $(COMMON)

%.tb.yml: $(TBGEN) $(TVGEN) $(E2EGEN)

%.tb.gen.v: %.tb.yml
	$(TBGEN) $<

check.tb.yml: check.e2e.tv

check.e2e.tv : $(E2EGEN) $(TRACES)
	$(E2EGEN) $(TRACE_BASES) > $@

check.tv: check.e2e.tv

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

%.elf: %.o
	ld -m elf_i386 $(basename $@).o -o $(basename $@).elf
	chmod +x $(basename $@).elf

%.o: %.s
	nasm -f elf32 $(basename $@).s -o $(basename $@).o

%.elf: %.c
	$(CC) -fno-pic -g -m32 -mtune=i386 -Wl,-emain -nostdlib -static -std=c99 \
		$(basename $@).c -o $(basename $@).elf -mpreferred-stack-boundary=2 \
		-fno-stack-protector -z execstack

.DELETE_ON_ERROR:
%.trace.jsonl: %.elf
	$(MTTN) -At --syscall-model=decree -m32 -F jsonl ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.elf
	$(MTTN) -At --syscall-model=decree -m32 -F tiny86-text ./$< > $@

.PHONY: all
all: $(TESTBENCH_EXES) $(TESTVECTORS) $(ALL_ELF)

.PHONY: test
test: all
	runghc -i$(SHOLVA_PREFIX)/src Main.hs
	@./run-tests $(CHECKS)

.PHONY: clean
clean:
	rm -rf $(TESTBENCHES) $(TESTVECTORS) $(TESTBENCH_EXES) *.vcd *.e2e.tv \
	       $(ALL_OBJS) $(ALL_ELFS) $(TRACE_JSONLS) $(TRACE_TEXTS)
