section .text
global _start

_start:
  mov eax, -5
  mov ebx, -3
  add eax, ebx

  ; exit
  mov     eax, 1
  int     0x80
