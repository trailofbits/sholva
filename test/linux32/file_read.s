section .text
global _start

; Read the contents from a file using Linux syscalls

_start:
  ; file open
  mov     eax, 2
  mov     ebx, filename
  int     0x80

  ; got fd, set to register
  mov     ebx, eax

  ; file read, fd in ebx
  mov     eax, 0
  mov     ecx, contents
  mov     edx, length
  int     0x80

  ; push the file descriptor 
  push ebx

  ; compare contents 
  mov     eax, expected_contents
  mov     ebx, contents 
  mov     ecx, length
compare:
  mov     edx, [eax]
  mov     edi, [ebx]
  cmp     edx, edi
  jne     fail

  ; increment the pointers
  inc     eax
  inc     ebx
  ; decrement the counter
  dec     ecx
  cmp     ecx, 0
  jne     compare

success:
  ; success
  mov     edi, 0
  jmp     done

fail:
  mov     edi, 1

done:
  ; get back file descriptor 
  pop     ebx

  ; file close, fd in ebx
  mov     eax, 3
  int     0x80

  ; exit
  mov     eax, 60
  int     0x80

section .data
; Use this if we want the full path
; Filepath limit is 255, imposed by OS
;filename:          db "/home/user/file.txt", 0

filename:           db "file.txt", 0
expected_contents:  db "Hola Mundo", 0xa, 0
length:             equ $ - expected_contents

section .bss
contents:           resb 12
