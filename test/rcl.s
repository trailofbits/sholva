section .text
global _start

_start:
  mov eax, 0xaabbccdd
  rcl al, 1

  ; exit
  mov eax, 1
  int 0x80
