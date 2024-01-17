section .text
global _start

_start:
  ; 1-byte write
  mov     eax, 4
  mov     ebx, 1
  mov     ecx, msg
  mov     edx, 5
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .data
msg:  db "Hey!", 0
