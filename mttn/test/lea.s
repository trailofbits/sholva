section .text
global _start

_start:
  mov     eax, 0xaaaaaaaa
  mov     ebx, 0xbbbbbbbb
  lea     ecx, [(eax * 2) + ebx + 2]

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
