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
  push bp
  mov bp, sp
  mov ah, 0ch
  mov al, [bp + 8]  ; Color
  mov dx, [bp + 6]  ; Y coord
  mov cx, [bp + 4]  ; X coord
  int 10h
  pop bp
  ret
