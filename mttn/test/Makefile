#
# PROGRAM TESTS
#

ASM := \
	alu_adc.s \
	alu_add_neg.s \
	alu_add.s \
	cdq.s \
	jmp.s \
	lea.s \
	loop_.s \
	memops.s \
	mov_r_r.s \
	nop.s \
	push_pop2.s \
	push_pop.s \
	rcl.s \
	rol.s \
	stosb.s \
	stosd.s \
	stosw.s \
	syscall_exit.s \
	syscall_write0.s \
	syscall_write1.s \
	syscall_write2.s \
	syscall_write3.s \
	syscall_write4.s \
	syscall_write5.s \
	syscall_write10.s \
	xchg_r_r.s

C_NOSTDLIB := \
	condition.nostdlib.c \
	jumptable.nostdlib.c \
	smallcall.nostdlib.c
C_STDLIB := \
	condition.c \
	jumptable.c \
	smallcall.c
	# brk.c \
	# brk_loop.c \
	# empty.c \
	# getrandom.c \
	# mmap.c
CFLAGS += -O0 -fno-pic -g -m32 -mtune=i386 -std=c99 \
		-mpreferred-stack-boundary=2 -fno-stack-protector -z execstack
CFLAGS_NOSTDLIB = $(CFLAGS) -Wl,-emain -nostdlib -static

ALL_ELFS := $(ASM:.s=.elf) $(C_NOSTDLIB:.c=.elf) $(C_STDLIB:.c=.elf)
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
MTTN_FLAGS += --tiny86_only -d -m32 --syscall_model=linux32

# NOTE: do not trace any libc examples here; test instrumentation of libc/nostdlib examples in src/trace.rs.
TRACE_JSONLS := $(ASM_SOURCES:.s=.trace.jsonl) $(C_NOSTDLIB:.c=.trace.jsonl)
TRACE_TEXTS := $(ASM:.s=.trace.txt) $(C_NOSTDLIB:.c=.trace.txt)
traces: $(TRACE_TEXTS)

nop.trace.jsonl: nop.elf
	$(MTTN) -o $@ $(MTTN_FLAGS) -n 0x8049000 -F jsonl ./$<

%.trace.jsonl: %.elf
	$(MTTN) -o $@ $(MTTN_FLAGS) --disable_aslr -F jsonl ./$<

%.trace.txt: %.elf
	$(MTTN) -o $@ $(MTTN_FLAGS) --disable_aslr -F tiny86-text ./$<

%.trace.txt: %.cgc
	$(MTTN) -o $@ $(MTTN_FLAGS) --syscall_model=linux32 -F tiny86-text ./$<

.PHONY: clean
clean:
	rm -f *.o *.trace.* *.elf *.memory
