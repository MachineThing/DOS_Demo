[bits 16]

section .text
global _fopen
global _fread
global _fclose

_fopen:
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

  pop bp
  ret

_fread:
  push bp
  mov bp, sp

  ; Read file
  mov bx, [bp + 4]        ; Put file handle into BX register
  mov ah, 3Fh
  mov cx, [bp + 6]  ; Bytes to read
  mov dx, [bp + 8]  ; Pointer
  int 21h

  ; TODO: Error handling

  pop bp
  ret

_fclose:
  push bp
  mov bp, sp

  ; Close file
  mov bx, [bp + 4]        ; Put file handle into BX register
  mov ah, 3Eh
  int 21h

  ; TODO: Error handling

  pop bp
  ret
