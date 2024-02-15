section .text
global _start

_start:
  mov     eax, 0x12345678
  mov     ebx, 0x90abcdef
  add     eax, ebx

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
