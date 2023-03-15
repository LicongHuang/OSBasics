;[org 0x7c00]
; 3.4.5 Control Structure


mov bx, 30      ; move 30 to bx

cmp bx, 4       ; compare bx to 4
; special flags register is used to capture the outcome of the cmp instruction
jle move_A      ; if result is <= 4, goto move_A
cmp bx, 40      ; compare bx to 40
jl move_B       ; if result < 40, goto move_B
jmp move_C      ; else jmp to move_C



move_A:         ; action signature
  mov al, 'A'   ; put to a lower 'A'
  jmp the_end   ; end

move_B:         ; action signature
  mov al, 'B'   ; put to a lower 'B' 
  jmp the_end   ; end

move_C:         ; action signature
  mov al, 'C'
  jmp the_end   ; end

the_end:        ; end

mov ah, 0x0e;   ; tty things
int 0x10;

jmp $

times 510-($-$$) db 0
dw 0xaa55



