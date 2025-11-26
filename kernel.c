#include "vga.h"

void kernel_main(void) {
    // Initialize terminal
    terminal_initialize();
    
    // Print welcome message
    terminal_writestring("Hello, Kernel World!\n");
    
    // Change colors and print more
    terminal_setcolor(vga_entry_color(VGA_COLOR_LIGHT_GREEN, VGA_COLOR_BLUE));
    terminal_writestring("Hello, Kernel World!\n");
    
    // Reset to default color
    terminal_setcolor(vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK));
    terminal_writestring("Hello, Kernel World!\n");
    
    // Print some colored text
    terminal_setcolor(vga_entry_color(VGA_COLOR_LIGHT_RED, VGA_COLOR_BLACK));
    terminal_writestring("Hello, Kernel World!\n");
    
    terminal_setcolor(vga_entry_color(VGA_COLOR_LIGHT_CYAN, VGA_COLOR_BLACK));
    terminal_writestring("Hello, Kernel World!\n");
    
    terminal_setcolor(vga_entry_color(VGA_COLOR_LIGHT_GREEN, VGA_COLOR_BLACK));
    terminal_writestring("Hello, Kernel World!\n");
    
    // Loop forever
    while (1) {
        // Kernel is running!
    }
}