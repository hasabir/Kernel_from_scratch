#include "vga.h"

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;
uint16_t* terminal_buffer;

void terminal_initialize(void) {
    terminal_row = 0;
    terminal_column = 0;
    terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
    terminal_buffer = (uint16_t*) 0xB8000;
    
    for (size_t y = 0; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            const size_t index = y * VGA_WIDTH + x;
            terminal_buffer[index] = vga_entry(' ', terminal_color);
        }
    }
}

void terminal_setcolor(uint8_t color) {
    terminal_color = color;
}

void terminal_putentryat(char c, uint8_t color, size_t x, size_t y) {
    const size_t index = y * VGA_WIDTH + x;
    terminal_buffer[index] = vga_entry(c, color);
}

void terminal_putchar(char c) {
    if (c == '\n') {
        terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT)
            terminal_row = 0;
        return;
    }
    
    terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
    if (++terminal_column == VGA_WIDTH) {
        terminal_column = 0;
        if (++terminal_row == VGA_HEIGHT)
            terminal_row = 0;
    }
}

void terminal_write(const char* data, size_t size) {
    for (size_t i = 0; i < size; i++)
        terminal_putchar(data[i]);
}

size_t strlen(const char* str) {
    size_t len = 0;
    while (str[len])
        len++;
    return len;
}

void terminal_writestring(const char* data) {
    terminal_write(data, strlen(data));
}

















// #include "vga.h"

// // VGA text buffer
// volatile uint16_t* vga_buffer = (uint16_t*) VGA_BUFFER;

// // Current cursor position
// size_t terminal_row;
// size_t terminal_column;
// uint8_t terminal_color;

// // Initialize VGA terminal
// void terminal_initialize(void) {
//     terminal_row = 0;
//     terminal_column = 0;
//     terminal_color = vga_entry_color(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    
//     // Clear screen
//     for (size_t y = 0; y < VGA_HEIGHT; y++) {
//         for (size_t x = 0; x < VGA_WIDTH; x++) {
//             const size_t index = y * VGA_WIDTH + x;
//             vga_buffer[index] = vga_entry(' ', terminal_color);
//         }
//     }
// }

// // Set terminal color
// void terminal_setcolor(uint8_t color) {
//     terminal_color = color;
// }

// // Put character at specific position
// void terminal_putentryat(char c, uint8_t color, size_t x, size_t y) {
//     const size_t index = y * VGA_WIDTH + x;
//     vga_buffer[index] = vga_entry(c, color);
// }

// // Put character (handles newline and carriage return)
// void terminal_putchar(char c) {
//     if (c == '\n') {
//         terminal_column = 0;
//         if (++terminal_row == VGA_HEIGHT) {
//             terminal_row = 0; // Simple wrap-around
//         }
//         return;
//     }
    
//     if (c == '\r') {
//         terminal_column = 0;
//         return;
//     }
    
//     terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
    
//     if (++terminal_column == VGA_WIDTH) {
//         terminal_column = 0;
//         if (++terminal_row == VGA_HEIGHT) {
//             terminal_row = 0; // Simple wrap-around
//         }
//     }
// }

// // Write string to terminal
// void terminal_write(const char* data, size_t size) {
//     for (size_t i = 0; i < size; i++) {
//         terminal_putchar(data[i]);
//     }
// }

// // Write null-terminated string
// void terminal_writestring(const char* data) {
//     while (*data != '\0') {
//         terminal_putchar(*data++);
//     }
// }