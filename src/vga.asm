[bits 16]

section .text
global _mode_x
global _mode_text
global _plot_pixel

; VGA Memory
VGA_MEMORY    equ 0A000h
; VGA Sequence Controller
SC_INDEX      equ 0x03c4
SC_DATA       equ 0x03c5
; VGA CRT Controller
CRTC_INDEX    equ 0x03d4
CRTC_DATA     equ 0x03d5
; VGA Registers
MEMORY_MODE   equ 0x04
UNDERLINE_LOC equ 0x14
MODE_CONTROL  equ 0x17
MAP_MASK      equ 0x02

%macro outb 2
  ; This macro eats up the DX and AL registers
  mov dx, %1
  mov al, %2
  out dx, al
%endmacro

_mode_x:
  ; Before we can get to mode X we have to be in mode 13h first
  mov ah, 0
  mov al, 13h
  int 10h

  ; Turn off chain-4 mode
  outb SC_INDEX, MEMORY_MODE
  outb SC_DATA, 0x06

  ; TODO: Clear screen here
  ; Turn off long mode
  outb CRTC_INDEX, UNDERLINE_LOC
  outb CRTC_DATA, 0x00

  ; Turn on byte mode
  outb CRTC_INDEX, MODE_CONTROL
  outb CRTC_DATA, 0xe3

  ret

_mode_text:
  mov ah, 0
  mov al, 03h
  int 10h
  ret

_plot_pixel:
  ; [bp + 4]  - X coord
  ; [bp + 6]  - Y coord
  ; [bp + 8]  - Color
  push bp
  mov bp, sp

  mov ax, [bp + 6]  ; Y coord
  mov bx, 320
  mul bx
  add ax, [bp + 4]  ; X coord

  mov si, VGA_MEMORY
  mov es, si
  mov si, ax
  mov ax, [bp + 8]  ; Color
  mov [es:si], ax
  pop bp
  ret
