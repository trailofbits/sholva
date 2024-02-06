section .text
global _start

_start:
  nop
  nop
  nop
  nop
  jmp     done
  nop
  nop
  nop
  nop
done:
  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
