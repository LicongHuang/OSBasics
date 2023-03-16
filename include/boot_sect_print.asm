print:
  pusha         ; push all register values to stack

; keep this in mind
; while (string[i] != 0) { print string[i] ; i++}

start:
  mov al, [bx]  ; 'bx' is the base address for the string
  cmp al, 0     ; compare the value of al with 0
  je done        ; if equal, jump to end

  ; the part where we print the BIOS help
  mov ah, 0x0e  
  int 0x10      ; 'al' already contains the char

  ; increment point and do the next loop
  add bx, 1
  jmp start

done:
  popa          ; pop all register values from stack
  ret           ; return to the caller

print_nl:
  pusha

  mov ah, 0x0e
  mov al, 0x0a  ; newline char
  int 0x10
  mov al, 0x0d  ; carriage return char
  int 0x10

  popa
  ret



