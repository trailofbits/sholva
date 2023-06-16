section .text
global _start

_start:
  nop
  nop
  nop
  nop
  jmp done
  nop
  nop
  nop
  nop
done:
  ; exit
  mov eax, 1
  int 0x80
