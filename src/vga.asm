[bits 16]

section .text
global _mode_x
global _mode_text
global _plot_pixel
global _set_dac

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

%macro outw 2
  ; This macro eats up the DX and AX registers
  mov dx, %1
  mov ax, %2
  out dx, ax
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

  ; Set page
  outb SC_INDEX, MAP_MASK
  mov cl, [bp + 4]  ; Set CL register to X coord
  and cl, 3         ; CL & 3
  mov al, 1
  shl al, cl        ; Shift 1 by CL
  mov dx, SC_DATA
  out dx, al        ; Set plane to AL

  ; Get coords
  mov ax, [bp + 6]  ; Y coord
  mov cl, 6
  shl ax, cl        ; Y << 6
  mov bx, ax

  mov ax, [bp + 6]  ; Y coord
  mov cl, 4
  shl ax, cl        ; Y << 4
  add bx, ax

  add ax, [bp + 4]  ; X coord
  mov cl, 2
  shr ax, cl        ; X << 2
  add bx, ax

  ; Plot the pixel
  mov si, VGA_MEMORY
  mov es, si
  mov si, bx
  mov ax, [bp + 8]  ; Color
  mov [es:si], ax

  pop bp
  ret

_set_dac:
  push bp
  mov bp, sp

  mov ax, 1010h     ; Set individual DAC
  mov bx, [bp + 4]  ; Register number
  mov dh, [bp + 6]  ; Red
  mov ch, [bp + 8]  ; Green
  mov cl, [bp + 10] ; Blue
  int 10h

  pop bp
  ret
