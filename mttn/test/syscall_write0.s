section .text
global _start

_start:
  ; 0-byte write
  mov     eax, 4
  mov     ebx, 1
  mov     ecx, msg        ; (using pointer to non-zero data, but count = 0)
  mov     edx, 0
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .data
msg:  db 0
