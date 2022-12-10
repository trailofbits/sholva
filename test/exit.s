section .text
global _start

_start:
  mov eax, 1
  int 0x80
