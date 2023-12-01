section .text
global _start

_start:
  nop

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
