[bits 16]

section .text
global _main

_main:
  mov si,_msg   ; Point the si register to our message
  call _print
  int 20h       ; Exit

_print:
  push bx       ; Preserve BX just in case
  mov bx, 0007h ; DisplayPage 0, GraphicsColor 7 (white)
  jmp .fetch
  .print:
    mov ah, 0eh ; Write character to TTY
    int 10h
  .fetch:
    lodsb       ; Read a character from si and puts it into al
    test al, al ; Is al == 0?
    jnz .print  ; If not print al
    pop bx      ; Restore bx
    ret

section .data
_msg db "Hello, world!",10,13,0
