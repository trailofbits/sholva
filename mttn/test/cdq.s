section .text
global _start

_start:
  mov     eax, -100
  cdq

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
