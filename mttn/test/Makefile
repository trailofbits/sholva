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
	nop \
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
	smallcall \
C_SOURCES := $(C_TESTS:=.c)
C_ELFS := $(C_SOURCES:.c=.elf)
CFLAGS += -fno-pic -g -m32 -mtune=i386 -std=c99 \
		-mpreferred-stack-boundary=2 -fno-stack-protector -z execstack
CFLAGS_NOSTDLIB = $(CFLAGS) -Wl,-emain -nostdlib -static

ALL_ELFS := $(ASM_ELFS) $(C_ELFS)
elfs: $(ALL_ELFS)

%.elf: %.o
	ld -m elf_i386 $^ -o $@
	chmod +x $@

%.o: %.s
	nasm -f elf32 $^ -o $@

%.nostdlib.elf: %.nostdlib.c
	$(CC) $(CFLAGS_NOSTDLIB) $^ -o $@

%.elf: %.c
	$(CC) $(CFLAGS) $^ -o $@

#
# TRACING
#
MTTN ?= mttn
MTTN_FLAGS += -At -m32

TRACE_JSONLS := $(ALL_ELFS:.elf=.trace.jsonl)
TRACE_TEXTS := $(ALL_ELFS:.elf=.trace.txt)
traces: $(TRACE_TEXTS)

.DELETE_ON_ERROR:
%.trace.jsonl: %.elf
	$(MTTN) $(MTTN_FLAGS) --syscall_model=decree -F jsonl ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.elf
	$(MTTN) $(MTTN_FLAGS) --syscall_model=decree -F tiny86-text ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.cgc
	$(MTTN) $(MTTN_FLAGS) --syscall_model=linux32 -F tiny86-text ./$<
