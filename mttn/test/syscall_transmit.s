section .text
global _start

_start:
  ; transmit
  mov eax, 2
  mov ebx, 1
  mov ecx, msg
  mov edx, 12
  int 0x80

  ; exit
  mov eax, 1
  int 0x80

section .data
msg: db "Hello World\n", 0
