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
	decree/alu_adc \
	decree/alu_add \
	decree/alu_add_neg \
	decree/cdq \
	decree/jmp \
	decree/lea \
	decree/loop_ \
	decree/memops \
	decree/mov_r_r \
	decree/push_pop \
	decree/push_pop2 \
	decree/rcl \
	decree/rol \
	decree/stosb \
	decree/stosd \
	decree/stosw \
	decree/syscall_receive \
	decree/syscall_terminate \
	decree/syscall_transmit \
	decree/xchg_r_r

ASM_SOURCES := $(ASM_TESTS:=.s)
ASM_OBJS := $(ASM_SOURCES:.s=.o)
ASM_ELFS := $(ASM_OBJS:.o=.elf)

C_TESTS := \
	decree/condition \
	decree/jumptable \
	decree/seteip \
	decree/smallcall
C_SOURCES := $(C_TESTS:=.c)
C_ELFS := $(C_SOURCES:.c=.elf)

CGC_TESTS := \
	Palindrome

DECREE_ELFS := $(ASM_ELFS) $(C_ELFS)

LINUX_TESTS := \
	linux32/file_read

LINUX_SOURCES := $(LINUX_TESTS:=.s)
LINUX_OBJS := $(LINUX_SOURCES:.s=.o)
LINUX_ELFS := $(LINUX_OBJS:.o=.elf)

LINUX_ELFS := $(LINUX_ELFS) 

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
MTTN_PREFIX := ../mttn
MTTN := cargo run --manifest-path=$(MTTN_PREFIX)/Cargo.toml --bin mttn --

# NOTE(ww): No default traces for the C tests, since some are interactive/take
# environmental inputs.
TRACE_JSONLS := $(ASM_ELFS:.elf=.trace.jsonl) $(C_ELFS:.elf=.trace.jsonl)
TRACE_TEXTS := $(ASM_ELFS:.elf=.trace.txt)

.DELETE_ON_ERROR:
decree/%.trace.jsonl: decree/%.elf
	$(MTTN) -At --syscall-model=decree -m32 -F jsonl ./$< > $@

.DELETE_ON_ERROR:
decree/%.trace.txt: decree/%.elf
	$(MTTN) -At --syscall-model=decree -m32 -F tiny86-text ./$< > $@

.DELETE_ON_ERROR:
linux32/%.trace.txt: linux32/%.elf
	$(MTTN) -At --syscall-model=linux32 -m32 -F tiny86-text ./$< > $@

.DELETE_ON_ERROR:
linux32/%.trace.txt: linux32/%.cgc
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
test: _test-sholva _test-pipeline _test-mttn-decree
else
test: _test-sholva
	$(warning "mttn tests only possible on x86 architectures.")
endif

# mttn self tests
.PHONY: _test-mttn-decree
_test-mttn-decree: $(DECREE_ELFS)
	cargo test --manifest-path=$(MTTN_PREFIX)/Cargo.toml

.PHONY: _test-mttn-linux
_test-mttn-linux: $(LINUX_ELFS)
	cargo test --manifest-path=$(MTTN_PREFIX)/Cargo.toml

## sholva self tests
.PHONY: _test-sholva
_test-sholva: _test-clash _test-verilog

.PHONY: _test-clash
_test-clash:
	runghc -i$(SHOLVA_PREFIX)/src Main.hs

.PHONY: _test-verilog
_test-verilog: $(TESTBENCH_EXES)
	@./run-tests $(SHOLVA_MODULES)

.PHONY: _test-pipeline
_test-pipeline: $(PIPELINE_EXES)
	@./run-tests $(PIPELINE_MODULES)

.PHONY: clean
clean:
	rm -rf $(TESTBENCH_EXES) $(PIPELINE_EXES) *.vcd *.e2e.tv \
	       $(LINUX_ELFS) $(DECREE_ELFS) $(TRACE_JSONLS) $(TRACE_TEXTS)
