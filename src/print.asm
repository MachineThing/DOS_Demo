[bits 16]

section .text
global _puts

_puts:
  mov si,bx
  mov bx, 0007h ; DisplayPage 0, GraphicsColor 7 (white)
  jmp .fetch
  .print:
    mov ah, 0eh ; Write character to TTY
    int 10h
  .fetch:
    lodsb       ; Read a character from si and puts it into al
    test al, al ; Is al == 0?
    jnz .print  ; If not print al
    ret
