section .text
global _start

_start:
  mov     eax, 0xaabbccdd
  rol     eax, 8

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
