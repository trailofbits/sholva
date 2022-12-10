section .text
global _start

_start:
  mov eax, 2
  mov ebx, 0
  mov ecx, 0
  int 0x80

  mov eax, 1
  int 0x80
