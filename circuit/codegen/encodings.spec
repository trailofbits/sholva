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
#  [x]HH[/D][+r{b,w,d,*}][+i{b,w,d,*}][~{I,D{8,32},M,O,MI,MR,RM,OI,AI,AO,RMI,MRI,MRC,ZO}][~{r,w,W,x}+][~{Z,S}]
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
#   - `~D8`: Unary, 8-bit displacement only
#   - `~D32`: Unary, 32-bit displacement only
#   - `~M`: Unary, r/m of ModR/M only
#   - `~O`: Unary, reg of lower opcode bits only
#   - `~A`: Unary, implicit accumulator reg for r(+w)
#   - `~MI`: Binary, r/m of ModR/M for r(+w) and immediate for read
#   - `~MR`: Binary, r/m of ModR/M for r(+w) and reg of ModR/M for read
#   - `~RM`: Binary, reg of ModR/M for r(+w) and r/m of ModR/M for read
#   - `~OI`: Binary, reg of lower opcode bits for r(+w) and immediate for read
#   - `~AI`: Binary, implicit accumulator reg for r(+w) and immediate for read
#   - `~AO`: Binary, implicit accumulator reg for r(+w) and reg of opcode bits for r(+w)
#   - `~MC`: Binary, r/m of ModR/M for r(+w) and CL for read
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
# * `~{Z,S}` indicates the sign- or zero-extension semantics of the "source" operand,
#   when applicable.
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
#
# * The order of spec definition in this file determines the "command number" in
#   the generated Tiny86 circuit. As such, new specification lines should be added
#   only at the bottom, to preserve the current order.


CMD_ADD:00~MR~Wr,01~MR~Wr,02~RM~Wr,03~RM~Wr,04+ib~AI~Wr,05+i*~AI~Wr,80/0+ib~MI~Wr,81/0+i*~MI~Wr,83/0+ib~MI~Wr~S

CMD_ADC:10~MR~Wr,11~MR~Wr,12~RM~Wr,13~RM~Wr,14+ib~AI~Wr,15+i*~AI~Wr,80/2+ib~MI~Wr,81/2+i*~MI~Wr,83/2+ib~MI~Wr~S

CMD_AND:20~MR~Wr,21~MR~Wr,22~RM~Wr,23~RM~Wr,24+ib~AI~Wr,25+i*~AI~Wr,80/4+ib~MI~Wr,81/4+i*~MI~Wr,83/4+ib~MI~Wr~S

CMD_BSF:xBC~RM~wr
CMD_BSR:xBD~RM~wr
CMD_BT:xA3~MR~rr,xBA/4+ib~MI~rr
CMD_BTC:xBB~MR~Wr,xBA/7+ib~MI~Wr
CMD_BTR:xB3~MR~Wr,xBA/6+ib~MI~Wr
CMD_BTS:xAB~MR~Wr,xBA/5+ib~MI~Wr

# TODO(ww): Figure out rel16/32 notation.
# CMD_CALL:E8,9A,FF/2,FF/3

CMD_CBW:98~A~W~S
CMD_CLC:F8~ZO~x
CMD_CLD:FC~ZO~x
CMD_CMC:F5~ZO~x

CMD_CMP:38~MR~rr,39~MR~rr,3A~RM~rr,3B~RM~rr,3C+ib~I~rr,3D+i*~I~rr,80/7+ib~MI~rr,81/7+i*~MI~rr,83/7+ib~MI~rr
CMD_CMPS:A6~ZO~rr,A7~ZO~rr
CMD_CWD:99~ZO~Wr~S
CMD_DEC:48+r*~O~W,FE/1~M~W,FF/1~M~W
CMD_DIV:F6/6~M~Wr,F7/6~M~Wr
CMD_IDIV:F6/7~M~Wr,F7/7~M~Wr~S

CMD_IMUL:69+i*~RMI~wrr~S,6B+ib~RMI~wrr~S,F6/5~M~Wr~S,F7/5~M~wWr~S,xAF~RM~Wr~S

CMD_INC:40+r*~O~Wr,FE/0~M~Wr,FF/0~M~Wr
CMD_Jcc:70~D8~r,71~D8~r,72~D8~r,73~D8~r,74~D8~r,75~D8~r,76~D8~r,77~D8~r,78~D8~r,79~D8~r,7A~D8~r,7B~D8~r,7C~D8~r,7D~D8~r,7E~D8~r,7F~D8~r,x80~D32~r,x81~D32~r,x82~D32~r,x83~D32~r,x84~D32~r,x85~D32~r,x86~D32~r,x87~D32~r,x88~D32~r,x89~D32~r,x8A~D32~r,x8B~D32~r,x8C~D32~r,x8D~D32~r,x8E~D32~r,x8F~D32~r
CMD_SETcc:x90~M~w,x91~M~w,x92~M~w,x93~M~w,x94~M~w,x95~M~w,x96~M~w,x97~M~w,x98~M~w,x99~M~w,x9A~M~w,x9B~M~w,x9C~M~w,x9D~M~w,x9E~M~w,x9F~M~w
CMD_JCXZ:E3~D8~r

# TODO(ww): Do we need to support far jumps?
CMD_JMP:EB~D8~r~S,E9~D32~r,FF/4~M~r
CMD_LEA:8D~RM~wr
CMD_LODS:AC~ZO~wr,AD~ZO~wr
CMD_LOOP:E0~D8~rr,E1~D8~rr,E2~D8~rr

# TODO(ww): Support A0, A1, A2, A3?
CMD_MOV:88~MR~wr,89~MR~wr,8A~RM~wr,8B~RM~wr,8C~MR~wr,8E~RM~wr,B0+rb+ib~OI~wr,B8+r*+i*~OI~wr,C6/0+ib~MI~wr,C7/0+i*~MI~wr

CMD_MOVS:A4~ZO~wr,A5~ZO~wr
CMD_MOVSX:63~RM~wr~S,xBE~RM~wr~S,xBF~RM~wr~S
CMD_MOVZX:xB6~RM~wr~Z,xB7~RM~wr~Z

# TODO(ww): MUL writes to EDX:EAX, figure that out.
CMD_MUL:F6/4~M~Wr,F7/4~M~wWr
CMD_NEG:F6/3~M~W,F7/3~M~W
CMD_NOP:x1F/0~M~W
CMD_NOT:F6/2~M~W,F7/2~M~W
CMD_OR:08~MR~Wr,09~MR~Wr,0A~RM~Wr,0B~RM~Wr,0C+ib~I~Wr,0D+i*~I~Wr,80/1+ib~MI~Wr,81/1+i*~MI~Wr,83/1+ib~MI~Wr~S
CMD_POP:58+r*~O~W,8F/0~M~W

# TODO(ww): r/w semantics for POPA?
CMD_POPA:61~ZO~x

CMD_POPF:9D~ZO~x
CMD_PUSH:50+r*~O~r,6A+ib~I~r,68+i*~I~r,FF/6~M~r

# TODO(ww): r/w semantics for PUSHA?
CMD_PUSHA:60~ZO~x

CMD_PUSHF:9C~ZO~x

CMD_RET:C3~ZO~x,CB~ZO~x
CMD_SAHF:9E~ZO~r
CMD_LAHF:9F~ZO~r
CMD_SBB:18~MR~Wr,19~MR~Wr,1A~RM~Wr,1B~RM~Wr,1C+ib~I~Wr,1D+i*~MI~Wr,80/3+ib~MI~Wr,81/3+i*~MI~Wr,83/3+ib~MI~Wr~S
CMD_SCAS:AE~ZO~rr,AF~ZO~rr

CMD_SHLD:xA4+ib~MRI~Wrr,xA5~MRC~Wrr
CMD_SHRD:xAC+ib~MRI~Wrr,xAD~MRC~Wrr

CMD_STC:F9~ZO~x
CMD_STD:FD~ZO~x

# NOTE(ww): SDM lists these as encoding "NA". Why?
CMD_STOS:AA~ZO~wr,AB~ZO~wr

CMD_SUB:28~MR~Wr,29~MR~Wr,2A~RM~Wr,2B~RM~Wr,2C+ib~I~Wr,2D+i*~I~Wr,80/5+ib~MI~Wr,81/5+i*~MI~Wr,83/5+ib~MI~Wr~S
CMD_TEST:84~MR~rr,85~MR~rr,A8+ib~I~rr,A9+i*~I~rr,F6/0+ib~MI~rr,F7/0+i*~MI~rr

# NOTE(ww): SDM lists XCHG 86 and 87 as both RM and MR, which doesn't make a lot of sense.
# Only the RM is represented here, since only one form is needed to cover all
# possible valid encodings.
CMD_XCHG:86~RM~WW,87~RM~WW,90+r*~AO~WW
CMD_XOR:30~MR~Wr,31~MR~Wr,32~RM~Wr,33~RM~Wr,34+ib~I~Wr,35+i*~I~Wr,80/6+ib~MI~Wr,81/6+i*~MI~Wr,83/6+ib~MI~Wr~S

# TODO(ww): Support all the hellish shift variants.
# TODO(ww): Maybe remove RCL/RCR, since nothing uses them.
# TODO(ww): Figure out how to differentiate the 8 bit semantics here.
# NOTE(ww): x86's SAL and SHL semantics are identical, and share the same encoding.
# NOTE(ww): D0/6 is undocumented but supposedly identical to D0/4. Worth supporting?
CMD_SHL:D0/4~M~Wr,D2/4~MC~Wr,C0/4+ib~MI~Wr,D1/4~M~Wr,D3/4~MC~Wr,C1/4+ib~MI~Wr

CMD_SAR:D0/7~M~Wr,D2/7~MC~Wr,C0/7+ib~MI~Wr,D1/7~M~Wr,D3/7~MC~Wr,C1/7+ib~MI~Wr
CMD_SHR:D0/5~M~Wr,D2/5~MC~Wr,C0/5+ib~MI~Wr,D1/5~M~Wr,D3/5~MC~Wr,C1/5+ib~MI~Wr

CMD_ROL:D0/0~M~Wr,D2/0~MC~Wr,C0/0+ib~MI~Wr,D1/0~M~Wr,D3/0~MC~Wr,C1/0+ib~MI~Wr
CMD_RCL:D0/2~M~Wr,D2/2~MC~Wr,C0/2+ib~MI~Wr,D1/2~M~Wr,D3/2~MC~Wr,C1/2+ib~MI~Wr

CMD_ROR:D0/1~M~Wr,D2/1~MC~Wr,C0/1+ib~MI~Wr,D1/1~M~Wr,D3/1~MC~Wr,C1/1+ib~MI~Wr
CMD_RCR:D0/3~M~Wr,D2/3~MC~Wr,C0/3+ib~MI~Wr,D1/3~M~Wr,D3/3~MC~Wr,C1/3+ib~MI~Wr
