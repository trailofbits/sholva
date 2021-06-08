# This file contains a set of terse encoding specifications for Tiny86.
# Each line looks something like this:
#
#    CMD_FOO:SPEC1,SPEC2,SPEC3,...
#
# ...where FOO is the name of the instruction class, and SPEC1, etc. are
# encoding specifications. Each specification takes the following form, with
# `[]` indicating "optional", `{X,Y}` indicating "choice", and `+` after either
# `[]` or `{}` indicating "one or more".
#
#  [x]HH[/D][+r{b,w,d,*}][+i{b,w,d,*}][~{I,D,M,O,MI,MR,RM,OI,AI,AO,RMI,MRI,MRC,ZO}][~{r,w,W,x}+]
#
# Where:
# * `x` indicates that that the `0Fh` opcode escape was used;
# * `HH` is the core opcode byte
# * `/D` indicates that the ModR/M reg field is used as an opcode extension
# * `+rb`, `+rw`, `+rd` indicate that the lower three opcode bits are a register selector
#   (of the specified width: byte, word, or dword), or `*` for both word and dword
# * `+ib`, `+iw`, `+id` indicate that the instruction is followed by an immediate operand
#   (of the specified width: byte, word, or dword), or `*` for both word and dword
# * `~I`, `~D`, `~M`, `~O`, `~MI`, `~MR`, `~RM`, ~OI`, `~ZO` indicate the operand encoding:
#   - `~I`: Unary, immediate only
#   - `~D`: Unary, displacement only
#   - `~M`: Unary, r/m of ModR/M only
#   - `~O`: Unary, reg of lower opcode bits only
#   - `~MI`: Binary, r/m of ModR/M for r(+w) and immediate for read
#   - `~MR`: Binary, r/m of ModR/M for r(+w) and reg of ModR/M for read
#   - `~RM`: Binary, reg of ModR/M for r(+w) and r/m of ModR/M for read
#   - `~OI`: Binary, reg of lower opcode bits for r(+w) and immediate for read
#   - `~AI`: Binary, implicit accumulator reg for r(+w) and immediate for read
#   - `~AO`: Binary, implicit accumulator reg for r(+w) and reg of opcode bits for r(+w)
#   - `~RMI`: Trinary, reg of Mod/RM for r(+w), r/m of ModR/M for read, immediate for read
#   - `~MRI`: Trinary, r/m of ModR/M for r(+w), reg of ModR/M for read, immediate for read
#   - `~MRC`: Trinary, r/m of ModR/M for r(+w), reg of ModR/M for read, implicit CL reg for read
#   - `~ZO`: No explicit operands whatsoever
# * `~{r,w,W,x}+` indicates the concrete read-write semantics of each operand, one operand
#   per character:
#   - `r`: operand is read-only
#   - `w`: operand is write-only
#   - `W`: operand is read+write
#   - `x`: operand is not read from or written to
#
# By way of example: here's the encoding form for `AND r/m32, imm8`:
#    CMD_AND:83/4+ib+MI~Wr
#
# Or `MOV r32, imm32`:
#    CMD_MOV:B8+rd+id+OI~Wr

# Misc notes:
#
# * These specs are definitely an overapproximation in some places.
#   For example, there are some MOV forms below that we probably shouldn't allow.


CMD_ADD:00~MR~Wr,01~MR,02~RM~Wr,03~RM~Wr,04+ib~AI~Wr,05+i*~AI~Wr,80/0+ib~MI~Wr,81/0+i*~MI~Wr,83/0+ib~MI~Wr

CMD_ADC:10~MR~Wr,11~MR~Wr,12~RM~Wr,13~RM~Wr,14+ib~AI~Wr,15+i*~AI~Wr,80/2+ib~MI~Wr,81/2+i*~MI~Wr,83/2+ib~MI~Wr

CMD_AND:20~MR~Wr,21~MR~Wr,22~RM~Wr,23~RM~Wr,24+ib~AI~Wr,25+i*~AI~Wr,80/4+ib~MI~Wr,81/4+i*~MI~Wr,83/4+ib~MI~Wr

CMD_BSF:xBC~RM~wr
CMD_BSR:xBD~RM~wr
CMD_BT:xA3~MR,xBA/4+ib~MI~wr
CMD_BTC:xBB~MR,xBA/7+ib~MI~Wr
CMD_BTR:xB3~MR,xBA/6+ib~MI~Wr
CMD_BTS:xAB~MR,xBA/5+ib~MI~Wr

# TODO(ww): Figure out rel16/32 notation.
# CMD_CALL:E8,9A,FF/2,FF/3

CMD_CBW:98~ZO
CMD_CLC:F8~ZO
CMD_CLD:FC~ZO
CMD_CMC:F5~ZO

CMD_CMP:38~MR,39~MR,3A~RM,3B~RM,3C+ib~I,3D+i*~I,80/7+ib~MI,81/7+i*~MI,83/7+ib~MI
CMD_CMPS:A6~ZO,A7~ZO
CMD_CWD:99~ZO
CMD_DEC:48+r*~O,FE/1~M,FF/1~M
CMD_DIV:F6/6~M,F7/6~M
CMD_IDIV:F6/7~M,F7/7~M

CMD_IMUL:69+i*~RMI,6B+ib~RMI,F6/5~M,F7/5~M,xAF~RM

CMD_INC:40+r*~O,FE/0~M,FF/0~M
CMD_Jcc:70~D,71~D,72~D,73~D,74~D,75~D,76~D,77~D,78~D,79~D,7A~D,7B~D,7C~D,7D~D,7E~D,7F~D,x80~D,x81~D,x82~D,x83~D,x84~D,x85~D,x86~D,x87~D,x88~D,x89~D,x8A~D,x8B~D,x8C~D,x8D~D,x8E~D,x8F~D
CMD_SETcc:x90~M,x91~M,x92~M,x93~M,x94~M,x95~M,x96~M,x97~M,x98~M,x99~M,x9A~M,x9B~M,x9C~M,x9D~M,x9E~M,x9F~M
CMD_JCXZ:E3~D
CMD_JMP:EA~D,EB~D,E9~D,FF/4~M,FF/5~D
CMD_LEA:8D~RM
CMD_LODS:AC~ZO,AD~ZO
CMD_LOOP:E0~D,E1~D,E2~D

# TODO(ww): Support A0, A1, A2, A3?
CMD_MOV:88~MR,89~MR,8A~RM,8B~RM,8C~MR,8E~RM,B0+rb+ib~OI,B8+r*+i*~OI,C6/0+ib~MI,C7/0+i*~MI

CMD_MOVS:A4~ZO,A5~ZO
CMD_MOVSX:63~RM,xBE~RM,xBF~RM
CMD_MOVZX:xB6~RM,xB7~RM

# TODO(ww): MUL writes to EDX:EAX, figure that out.
CMD_MUL:F6/4~M,F7/4~M
CMD_NEG:F6/3~M,F7/3~M
CMD_NOP:x1F/0~M
CMD_NOT:F6/2~M,F7/2~M
CMD_OR:08~MR,09~MR,0A~RM,0B~RM,0C+ib~I,0D+i*~I,80/1+ib~MI,81/1+i*~MI,83/1+ib~MI
CMD_POP:58+r*~O,8F/0~M
CMD_POPA:61~ZO
CMD_POPF:9D~ZO
CMD_PUSH:50+r*~O,6A+ib~I,68+i*~I,FF/6~M
CMD_PUSHA:60~ZO
CMD_PUSHF:9C~ZO

# CMD_Shift:C0/0,C0/1,C0/2,C0/3,C0/4,C0/5,C0/7,C1/1,C1/2,C1/3,C1/4,C1/5,C1/7,D0/0,D0/1,D0/2,D0/3,D0/4,D0/5,D0/7,D1/1,D1/2,D1/3,D1/4,D1/5,D1/7,D2/0,D2/1,D2/2,D2/3,D2/4,D2/5,D2/7,D3/0,D3/1,D3/2,D3/3,D3/4,D3/5,D3/7

CMD_RET:C3~ZO,CB~ZO
CMD_SAHF:9E~ZO
CMD_SBB:18~MR,19~MR,1A~RM,1B~RM,1C+ib~I,1D+i*~MI,80/3+ib~MI,81/3+i*~MI,83/3+ib~MI
CMD_SCAS:AE~ZO,AF~ZO

CMD_SHLD:xA4+ib~MRI,xA5~MRC
CMD_SHRD:xAC+ib~MRI,xAD~MRC

CMD_STC:F9~ZO
CMD_STD:FD~ZO

# NOTE(ww): SDM lists these as encoding "NA". Why?
CMD_STOS:AA~ZO,AB~ZO

CMD_SUB:28~MR,29~MR,2A~RM,2B~RM,2C+ib~I,2D+i*~I,80/5+ib~MI,81/5+i*~MI,83/5+ib~MI
CMD_TEST:84~MR,85~MR,A8+ib~I,A9+i*~I,F6/0+ib~MI,F7/0+i*~MI

# NOTE(ww): SDM lists XCHG 86 and 87 as both RM and MR, which doesn't make a lot of sense.
# Only the RM is represented here, since only one form is needed to cover all
# possible valid encodings.
CMD_XCHG:86~RM,87~RM,90+r*~AO
CMD_XOR:30~MR,31~MR,32~RM,33~RM,34+ib~I,35+i*~I,80/6+ib~MI,81/6+i*~MI,83/6+ib~MI
