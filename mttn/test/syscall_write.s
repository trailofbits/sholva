section .text
global _start

_start:
  ; 0-byte write
  mov     eax, 4
  mov     ebx, 1
  mov     ecx, msg2       ; (using pointer to non-zero data, but count = 0)
  mov     edx, 0
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .data
msg2:  db "H", 0              ; Word
msg3:  db "He", 0             ; DWord
msg5:  db "Hell", 0           ; DWord, Byte
msg6:  db "Hello", 0          ; DWord, Word
msg12: db "Hello World", 0    ; DWord, DWord, DWord
