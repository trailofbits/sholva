section .text
global _start

_start:
  mov     eax, 0xaaaaaaaa
  mov     ebx, 0xbbbbbbbb
  xchg    ebx, eax

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
