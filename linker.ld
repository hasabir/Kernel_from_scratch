ENTRY(start)

SECTIONS
{
    . = 1M;

    /* Read-only code section */
    .text BLOCK(4K) : ALIGN(4K)
    {
        *(.multiboot_header)
        *(.multiboot)
        *(.text)
    }

    /* Read-only data section */
    .rodata BLOCK(4K) : ALIGN(4K)
    {
        *(.rodata)
    }

    /* Read-write data section */
    .data BLOCK(4K) : ALIGN(4K)
    {
        *(.data)
    }

    /* Read-write uninitialized data */
    .bss BLOCK(4K) : ALIGN(4K)
    {
        *(COMMON)
        *(.bss)
    }
}