; Print string pointed by BX
print:
        mov bx, bx
        pusha

start:
  mov al, [bx]
  cmp al, 0
  je done

  mov ah, 0x0e
  int 0x10

  add bx, 1
  jmp start

done:
  popa
  ret

; Print new line

print_nl:
  pusha
  mov ah, 0x0e
  mov al, 0x0a
  int 0x10
  mov al, 0x0d
  int 0x10
  popa
  ret

; Function to convert DX to hex string and store in HEX_OUT

print_hex:
  pusha
  mov bx, HEX_OUT

  ; Write "0x"
  mov byte [bx], '0'
  inc bx
  mov byte [bx], 'x'
  inc bx

  ; Convert and write each nibble (4 bits)
  mov cx, 12  ; Start with the highest nibble (4th)

next_nibble:
  mov ax, dx
  shr ax, cl  ; Shift the current nibble to the lowest 4 bits
  and al, 0x0F  ; Mask to keep the last 4 bits

  ; Convert to ASCII
  cmp al, 9
  jbe hex_digit_to_char
  add al, 'A' - 10
  jmp write_char

hex_digit_to_char:
  add al, '0'

write_char:
  mov [bx], al
  inc bx

  sub cl, 4
  jns next_nibble  ; Repeat until all nibbles are processed

  ; Null-terminate the string
  mov byte [bx], 0

  ; Print the resulting string
  mov bx, HEX_OUT
  call print

  popa
  ret
