section .text
global _start

; Read the contents from a file. 
; Uses Linux syscalls
; TODO: compare the read contents

_start:
  ; file open
  mov eax, 2
  mov ebx, filename
  int 0x80

  ; got fd, set to register
  mov ebx, eax

  ; file read, fd in ebx
  mov eax, 1
  mov ecx, 10
  int 0x80

  ; file close, fd in ebx
  mov eax, 3
  int 0x80

  ; exit
  mov     eax, 60
  int     0x80

section .data
filename: db "/home/user/file.txt\n", 0
