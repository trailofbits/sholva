section .text
global _start

_start:
  ; read 0
  mov     eax, 3
  mov     ebx, 0
  mov     ecx, msg
  mov     edx, 0
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .bss
msg: resb 0
