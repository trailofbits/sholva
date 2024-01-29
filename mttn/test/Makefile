#
# PROGRAM TESTS
#

ASM_SOURCES := $(wildcard *.s)
ASM_OBJS := $(ASM_SOURCES:.s=.o)
ASM_ELFS := $(ASM_OBJS:.o=.elf)

C_SOURCES := \
	condition.nostdlib.c \
	jumptable.nostdlib.c \
	smallcall.nostdlib.c
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
MTTN ?= cargo run --
MTTN_FLAGS += --tiny86_only -m32 --syscall_model=linux32

TRACE_JSONLS := $(ALL_ELFS:.elf=.trace.jsonl)
TRACE_TEXTS := $(ALL_ELFS:.elf=.trace.txt)
traces: $(TRACE_TEXTS)

.DELETE_ON_ERROR:
%.trace.jsonl: %.gdb %.elf
	@# HACK: `-batch-silent` seem to be the only method of disabling logging.
	@# unfortunately it takes all stdio with it; use stderr for passing PID to mttn.
	gdb -batch-silent -x $< 2>&1 | xargs -I {} $(MTTN) $(MTTN_FLAGS) -F jsonl -a {} > $@

.DELETE_ON_ERROR:
%.trace.txt: %.gdb %.elf
	@# HACK: see above.
	gdb -batch-silent -x $< 2>&1 | xargs -I {} $(MTTN) $(MTTN_FLAGS) -F tiny86-text -a {} > $@

.DELETE_ON_ERROR:
%.trace.jsonl: %.elf
	$(MTTN) $(MTTN_FLAGS) --disable_aslr -F jsonl ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.elf
	$(MTTN) $(MTTN_FLAGS) --disable_aslr -F tiny86-text ./$< > $@

.DELETE_ON_ERROR:
%.trace.txt: %.cgc
	$(MTTN) $(MTTN_FLAGS) --syscall_model=linux32 -F tiny86-text ./$<

.PHONY: clean
clean:
	rm -f *.o *.trace.* *.elf *.memory
