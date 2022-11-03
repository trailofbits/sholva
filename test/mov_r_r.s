section .text
global _start

_start:
  mov eax, 0xaaaaaaaa
  mov ebx, eax

  ; exit
  mov eax, 1
  int 0x80
