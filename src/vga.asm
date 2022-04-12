[bits 16]

section .text
global _mode_set
global _plot_pixel

_mode_set:
  push bp
  mov bp, sp
  mov ah, 0
  mov al, [bp + 4]
  int 10h
  pop bp
  ret

_plot_pixel:
  mov ah, 0ch
  mov al, 14
  mov cx, 5
  mov dx, 5
  int 10h
  ret
