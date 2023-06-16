section .text
global _start

_start:
  mov ebp, esp       ; save the base pointer for cross-check
  sub esp, 4         ; save a dword of space to write to
  push 1             ; [esp]=1, esp - 4
  lea ebx, [esp + 4] ; load the address of the first stack slot into ebx
  pop DWORD [ebx]    ; [ebx]=[esp], esp + 4

  ; exit
  mov eax, 1
  int 0x80
