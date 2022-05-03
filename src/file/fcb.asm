[bits 16]

section .text
global _fcb

_fcb:
  push bp
  mov bp, sp
  mov cx, 8
  mov bx, [bp + 4]
  .loopa:
    mov al, [bx]
    mov ah, 0eh
    int 10h
    dec cx
    inc bx
  test cx, cx
  jnz .loopa

  mov cx, 3
  mov bx, [bp + 6]
  .loopb:
    mov al, [bx]
    mov ah, 0eh
    int 10h
    dec cx
    inc bx
  test cx, cx
  jnz .loopb

  pop bp
  ret
