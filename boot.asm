global start
extern kernel_main

section .text
bits 32
start:
    ; Set up stack
    mov esp, stack_top
    
    ; Call kernel main function
    call kernel_main
    
    ; Halt if kernel_main returns
    cli
.hang:
    hlt
    jmp .hang

section .bss
align 4096
stack_bottom:
    resb 16384  ; 16KB stack
stack_top:

section .note.GNU-stack noalloc noexec nowrite progbits