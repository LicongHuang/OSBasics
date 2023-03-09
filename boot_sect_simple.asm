[org 0x7c00]
mov ah, 0x0e; -> int 10/ah = 0eh -> scrolling teletype BIOS routine 

mov al, "1";
int 0x10;
mov al, the_secret
int 0x10; -> tries to print the mem address not its actual contents

; Tries to print the mem add of the descrete which is correct approach
; However, the BIOS places our bootsector bin at the address 0x7c00
; need to add that padding before hand
mov al, "2";
int 0x10;
mov al, [the_secret]
int 0x10


; add BIOS starting offset 0x7c00 to the mem address of the x
; and then dereference the contents of that pointer
; we need the help of a different register 'bx' because 'mov al, [ax]' is illegal
; a register cant be used as a source and destination for the same command
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10


; shortcut since we know that x is stored in 0x2d in out bin, 
; smart but ineffetive, dont want to be recounting label offsets
; every time we change the code
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10;



jmp $; jump to current address = infinite loop

the_secret:
  ; ASCII code 0x58 ('X') is stored just before the zero-padding
  ; On this code, that is at byte 0x2d (check it out using 'xxd file.bin')
  db "X"

; Fill with 510 zero minus the size of the previous code
times 510-($-$$) db 0
; Magic Number
dw 0xaa55
