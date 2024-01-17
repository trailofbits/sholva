section .text
global _start

_start:
  ; 10-byte write
  mov     eax, 4
  mov     ebx, 1
  mov     ecx, msg
  mov     edx, 10
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .data
msg:  db "Hey world", 0
