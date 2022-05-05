[bits 16]

section .text
global _file

_file:
  push bp
  mov bp, sp
  mov ah, 3Dh       ; Read File (DOS 2+)
  mov al, 0         ; Read Only
  mov dx, [bp + 4]
  int 21h

  ; Check if Carry Flag is set...
  .ohno:
    ; TODO: Make this spit out an error
    nop
  jc .ohno

  pop bp
  ret

section .bss
