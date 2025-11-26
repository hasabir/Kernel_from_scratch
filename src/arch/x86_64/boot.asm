global start

section .text
bits 32
start:
    ; Print "Hello World" to screen
    mov dword [0xb8000], 0x2f48  ; 'H' in green on black
    mov dword [0xb8002], 0x2f65  ; 'e'
    mov dword [0xb8004], 0x2f6c  ; 'l'
    mov dword [0xb8006], 0x2f6c  ; 'l'
    mov dword [0xb8008], 0x2f6f  ; 'o'
    mov dword [0xb800A], 0x2f20  ; ' ' (space)
    mov dword [0xb800C], 0x2f57  ; 'W'
    mov dword [0xb800E], 0x2f6f  ; 'o'
    mov dword [0xb8010], 0x2f72  ; 'r'
    mov dword [0xb8012], 0x2f6c  ; 'l'
    mov dword [0xb8014], 0x2f64  ; 'd'
    
    hlt