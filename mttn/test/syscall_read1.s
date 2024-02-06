section .text
global _start

_start:
  ; read 1
  mov     eax, 3
  mov     ebx, 0
  mov     ecx, msg
  mov     edx, 1
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .bss
msg: resb 1
