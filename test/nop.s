section .text
global _start

_start:
  nop

  ; exit
  mov eax, 1
  int 0x80
