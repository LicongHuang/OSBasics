[org 0x7c00]
mov ah, 0x0e; -> int 10/ah = 0eh -> scrolling teletype BIOS routine 



; Tries to load the imm offset into the al as the char to print
; but we want to print the char at the offset rather than the offset iteself
mov al, the_secret
int 0x10; -> tries to print the mem address not its actual contents

; Tries to print the mem add of the descrete which is correct approach
; However, the BIOS places our bootsector bin at the address 0x7c00
; need to add that padding before hand
mov al, [the_secret]; -> square braket is CPU instruction to store content of an address
int 0x10;
; Problem: CPU treats the offset as though it was from the start of mem
; rather than the start addr of our loaded code, which lands around the interrupt vector
; 

; add BIOS starting offset 0x7c00 to the mem address of the x
; and then dereference the contents of that pointer
; we need the help of a different register 'bx' because 'mov al, [ax]' is illegal
; a register cant be used as a source and destination for the same command
mov bx, the_secret;i -> copy the_secret into bx
add bx, 0x7c00; -> add off set 
mov al, [bx]; -> now correct address, ready for BIOS print function
int 0x10;


; shortcut since we know that x is stored in 0x2d in out bin, 
; smart but ineffetive, dont want to be recounting label offsets
; every time we change the code
mov al, [0x7c1e]; -> just offset by 0x1e same thing as labels
int 0x10;



jmp $; jump to current address = infinite loop

the_secret:
  ; ASCII code 0x58 ('X') is stored just before the zero-padding
  ; On this code, that is at byte 0x2d (check it out using 'xxd file.bin')
  db "X",0 ; db stands for declare bytes of data, 0 at the end as null-terminating

; Fill with 510 zero minus the size of the previous code
times 510-($-$$) db 0;
; Magic Number
dw 0xaa55;
