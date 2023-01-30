section .text
global _start

_start:
  stc

  mov eax, 0xaaaaaaaa
  mov ebx, 0xbbbbbbbb

  cmovb eax, ebx

  ; exit
  mov eax, 1
  int 0x80
