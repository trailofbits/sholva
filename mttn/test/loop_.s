section .text
global _start

_start:
  mov     ecx, 10
  mov     eax, 0
loop_begin:
  add     eax, 1
  loop    loop_begin

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
