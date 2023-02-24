section .text
global _start

; Expanded, very roughly, from:
;
; int main(void) {
;     uint8_t buf1[1024];
;
;     __builtin_memset(buf1, 0x41, 1024);
;     return 1;
; }

_start:
push    ebp
mov     ebp, esp
push    edi
push    ebx
sub     esp, 1024
lea     eax, [ebp-1032]
mov     ebx, eax
mov     eax, 1094795585 ; 0x41414141
mov     edx, 256
mov     edi, ebx
mov     ecx, edx
rep stosd
movzx   eax, BYTE [ebp-1000]
movzx   eax, al
add     esp, 1024
pop     ebx
pop     edi
pop     ebp
mov     ebx, eax
mov     eax, 1
int     0x80
