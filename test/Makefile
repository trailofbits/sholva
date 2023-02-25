.PHONY: all
all: test

#
# HDL TESTS
#
SHOLVA_PREFIX  := ../tiny86
SHOLVA_MODULES := \
	agu \
	alu \
	cfu \
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
	tiny86 \
	syscall
PIPELINE_MODULES := check

TESTBENCH_EXES := $(addsuffix .tb.vvp,$(SHOLVA_MODULES))
PIPELINE_EXES  := $(addsuffix .tb.vvp,$(PIPELINE_MODULES))

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
# PROGRAM TESTS
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
	syscall_receive \
	syscall_terminate \
	syscall_transmit \
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

CGC_TESTS := \
	Palindrome

ALL_ELFS := $(ASM_ELFS) $(C_ELFS)

%.elf: %.o
	ld -m elf_i386 $(basename $@).o -o $(basename $@).elf
	chmod +x $(basename $@).elf

%.o: %.s
	nasm -f elf32 $(basename $@).s -o $(basename $@).o

%.elf: %.c
	$(CC) -fno-pic -g -m32 -mtune=i386 -Wl,-emain -nostdlib -static -std=c99 \
		$(basename $@).c -o $(basename $@).elf -mpreferred-stack-boundary=2 \
		-fno-stack-protector -z execstack


#
# TRACING
#
MTTN := mttn

# NOTE(ww): No default traces for the C tests, since some are interactive/take
# environmental inputs.
TRACE_JSONLS := $(ASM_ELFS:.elf=.trace.jsonl) $(C_ELFS:.elf=.trace.jsonl)
TRACE_TEXTS := $(ASM_ELFS:.elf=.trace.txt)

.DELETE_ON_ERROR:
%.trace.jsonl: %.elf
	$(MTTN) -At --syscall-model=decree -m32 -F jsonl ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.elf
	$(MTTN) -At --syscall-model=decree -m32 -F tiny86-text ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.cgc
	$(MTTN) -At --syscall-model=linux32 -m32 -F tiny86-text ./$<

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
ARCH := $(shell uname -m)
.PHONY: test
ifeq ($(ARCH), x86_64)
test: _test-sholva _test-pipeline
else
test: _test-sholva
	$(warning "tracing tests only possible on x86 architectures!")
endif

# run normal test suite in addition to any developer-specific release tooling.
# this target may include dependencies not publicly available, and is not intended for general use.
.PHONY: _test-dev
_test-dev: test
	wtk-firealarm

# mttn self tests
.PHONY: _test-mttn
_test-mttn: $(ALL_ELFS)
	cargo test --manifest-path=$(MTTN_PREFIX)/Cargo.toml

>>>>>>> 2f7035f (TASK(jl): updated Makefile targets)
## sholva self tests
.PHONY: _test-sholva
_test-sholva: _test-clash _test-verilog

.PHONY: _test-clash
_test-clash:
	runghc -i$(SHOLVA_PREFIX)/src Main.hs

.PHONY: _test-verilog
_test-verilog: $(TESTBENCH_EXES)
	ruby run-tests $(SHOLVA_MODULES)

.PHONY: _test-pipeline
_test-pipeline: $(PIPELINE_EXES)
	ruby run-tests $(PIPELINE_MODULES)

.PHONY: clean
clean:
	rm -rf $(TESTBENCH_EXES) $(PIPELINE_EXES) *.vcd *.e2e.tv \
	       $(ALL_ELFS) $(TRACE_JSONLS) $(TRACE_TEXTS)
