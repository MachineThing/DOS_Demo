[bits 16]

section .text
global _mode_set

_mode_set:
  push bp
  mov bp, sp
  mov ah, 0
  mov al, [bp + 4]
  int 10h
  pop bp
  ret
