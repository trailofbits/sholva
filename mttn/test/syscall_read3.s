section .text
global _start

_start:
  ; read 3
  mov     eax, 3
  mov     ebx, 0
  mov     ecx, msg
  mov     edx, 3
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .bss
msg: resb 3
