section .text
global _start

_start:
  stc
  mov eax, 4
  mov ebx, 3
  adc eax, ebx

  ; exit
  mov     eax, 1
  int     0x80
