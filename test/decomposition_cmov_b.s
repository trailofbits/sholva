section .text
global _start

_start:
  clc

  mov eax, 0xaaaaaaaa
  mov ebx, 0xbbbbbbbb

  ; carry flag unset, decomposed to NOP.
  cmovb eax, ebx

  ; exit
  mov eax, 1
  int 0x80
