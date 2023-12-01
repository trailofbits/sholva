section .text
global _start

_start:
  ; write
  mov     eax, 4
  mov     ebx, 1
  mov     ecx, msg
  mov     edx, 12
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .data
msg: db "Hello World", 0
