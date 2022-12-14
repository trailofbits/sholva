section .text
global _start

_start:
  mov     ebp, 0x41414141
  push    ebp
  mov     ebp, esp
  sub     esp, 16
  mov     dword [ebp - 4], 0
  mov     dword [ebp - 8], 16
  mov     dword [ebp - 12], 16
  mov     eax, dword [ebp - 8]
  add     eax, dword [ebp - 12]
  mov     dword [ebp - 16], eax
  mov     eax, dword [ebp - 16]
  mov     ebx, eax
  add     esp, 16
  pop     ebp
  mov     eax, 1
  int     0x80
