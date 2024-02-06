section .text
global _start

_start:
  ; read
  mov     eax, 3    ; syscall
  mov     ebx, 0    ; unsigned int fd (stdin)
  mov     ecx, msg  ; char *buf
  mov     edx, 12   ; size_t count
  int     0x80

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80

section .bss
msg: resb 12
