section .text
global _start

_start:
  ; receive
  mov eax, 3
  mov ebx, 0
  mov ecx, msg
  mov edx, 12
  int 0x80

  ; exit
  mov eax, 1
  int 0x80

section .bss
msg: resb 12
