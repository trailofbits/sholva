section .text
global _start

_start:
  ; FIXME(jl): this `nop` occupies the second requisite step needed to generate a proof.
  ; should we allow single-instruction proofs that make no assertions?
  nop

  ; exit
  mov     eax, 1
  xor     ebx, ebx
  int     0x80
