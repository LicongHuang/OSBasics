[org 0x7c00]


mov bx, HELLO
call print
call print_nl

mov bx, GOODBYE
call print
call print_nl

mov dx, 0x1337  ; Value to print in hex
call print_hex
mov dx, 0xc0de
call print_hex
call print_nl
jmp $

HELLO:
  db "Hello, world!", 0

GOODBYE:
  db "Goodbye, world!", 0

HEX_OUT:
  db "0x0000", 0  ; Buffer for the hex string

%include "boot_sect_print.asm"

times 510-($-$$) db 0
dw 0xaa55
