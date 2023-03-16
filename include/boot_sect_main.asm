[org 0x7c00]

mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

jmp $


HELLO: 
  db "Hello, world!", 0

GOODBYE: 
  db "Goodbye, world!", 0


%include "boot_sect_print.asm"

times 510-($-$$) db 0
dw 0xaa55

