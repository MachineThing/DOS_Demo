[bits 16]

section .text
global _clock_init
global _sleep

_timer_int:
  pushf
  dec word [cs:timer_tick]
  popf
  iret

_clock_init:
  mov ax, 351ch   ; AH=35h (Get interrupt vector)
                  ; AL=1Ch (User timer interrupt vector)
  int 21h

  mov [cs:int_ofs], bx
  mov ax, es
  mov [cs:int_seg], ax

  mov ax, 251ch   ; AH=25h (Set interrupt vector)
                  ; AL=1Ch (User timer interrupt vector)
  push cs
  pop ds
  mov dx, _timer_int
  int 21h

  ret

_sleep:
  push bp
  mov bp, sp

  mov ax, [bp + 4]
  mov [cs:timer_tick], ax

  .wait:
    mov ax, word [cs:timer_tick]

  test ax, ax ; Sleep time
  jnz .wait

  pop bp
  ret

int_ofs     dw 0
int_seg     dw 0
timer_tick  dw 0
