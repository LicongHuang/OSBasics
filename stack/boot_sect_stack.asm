;
; A simple boot sector program that demonstrates the stack
;

mov ah, 0x0e        ; int 10/ah = 0eh -> scrolling teletype BIOS routine
mov bp, 0x8000      ; Set the base of the stack in a little above where BIOS
mov sp, bp          ; loads our boot sector - so it won't overwrite us

push 'A'            ; Push some characters on the stack for layer
push 'B'            ; retreival. Note, these are pushed on as 
push 'C'            ; 16-bit values, so the most significant byte
                    ; will be added by our assembler as 0x00

mov al, [0x7ffc]    ; 0x8000 - 2
int 0x10            ; To show how stack grows downwards

; Can't access 0x800 since can only access stack top
mov al, [0x800]
int 0x10

; recover our char using the standard procedure: 'pop'
; can only pop full words so need an auxiliary register to manipulate
; lower byte
pop bx          ; pops top item
mov al, bl      ; move the popped item to bl register
int 0x10        ; prints C


pop bx          ; pops top item
mov al, bl      ; move the popped item to bl register
int 0x10        ; prints B

pop bx          ; pops top item
mov al, bl      ; move the popped item to bl register
int 0x10        ; prints A

; data pop'd from stack is garbage
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55



