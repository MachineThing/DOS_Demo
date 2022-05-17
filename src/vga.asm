[bits 16]

section .text
global _mode_set
global _plot_pixel
global _set_dac

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
  mov ax, [bp + 6]  ; Y coord
  mov bx, 320
  mul bx
  add ax, [bp + 4]  ; X coord

  mov si, 0A000h
  mov es, si
  mov si, ax
  mov ax, [bp + 8]  ; Color
  mov [es:si], ax

  pop bp
  ret

_set_dac:
  push bp
  mov bp, sp

  mov ax, 1010h
  mov bx, [bp + 4]  ; Register number
  mov dh, [bp + 6]  ; Red
  mov cl, [bp + 7]  ; Blue
  mov ch, [bp + 8]  ; Green
  int 10h

  pop bp
  ret
