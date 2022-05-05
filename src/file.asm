[bits 16]

section .text
global _file

_file:
  push bp
  mov bp, sp

  ; Get the file
  mov ah, 3Dh       ; Read File (DOS 2+)
  mov al, 0         ; Read Only
  mov dx, [bp + 4]  ; File name
  int 21h

  ; Check if Carry Flag is set...
  .ohno:
    ; TODO: Make this spit out an error
    nop
  jc .ohno

  ; Read file
  mov bx, ax        ; Put file handle into BX register
  mov ah, 3Fh
  mov cx, [bp + 6]  ; Bytes to read
  mov dx, [bp + 8]  ; Pointer
  int 21h

  ; Check if Carry Flag is set...
  jc .ohno

  pop bp
  ret
