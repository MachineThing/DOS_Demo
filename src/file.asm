[bits 16]

section .text
global _fopen
global _fread
global _fclose

_fopen:
  push bp
  mov bp, sp

  ; Get the file
  mov ah, 3Dh       ; Open File (DOS 2+)
  mov al, 0         ; Read Only
  mov dx, [bp + 4]  ; File name
  int 21h

  ; Check if Carry Flag is set...
  .fopen_err:
    ; TODO: Make this spit out an error
    nop

  jc .fopen_err

  ; File handle is returned as it's stored in AX when interrupt was called
  pop bp
  ret

_fread:
  push bp
  mov bp, sp

  ; Read file
  mov bx, [bp + 4]  ; Put file handle into BX register
  mov ah, 3Fh       ; Read File (DOS 2+)
  mov cx, [bp + 6]  ; Bytes to read
  mov dx, [bp + 8]  ; Pointer
  int 21h

  ; Check if Carry Flag is set...
  .fread_err:
    ; TODO: Make this spit out an error
    nop

  jc .fread_err

  pop bp
  ret

_fclose:
  push bp
  mov bp, sp

  ; Close file
  mov bx, [bp + 4]  ; Put file handle into BX register
  mov ah, 3Eh       ; Close File (DOS 2+)
  int 21h

  ; Check if Carry Flag is set...
  .fclose_err:
    ; TODO: Make this spit out an error
    nop

  jc .fclose_err

  pop bp
  ret
