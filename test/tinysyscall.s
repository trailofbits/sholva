section .text
global _start

_start:
  ; exit
  mov eax, 1
  mov ebx, 42
  int 0x80

  ; exit
  mov eax, 1
  mov ebx, 42
  int 0x80
