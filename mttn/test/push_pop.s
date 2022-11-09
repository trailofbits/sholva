section .text
global _start

_start:
  mov eax, 1
  push 2
  push eax
  pop ebx ; ebx = 1
  pop eax ; eax = 2

  ; exit
  mov eax, 1
  int 0x80
