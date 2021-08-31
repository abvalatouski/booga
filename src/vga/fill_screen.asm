%ifndef VGA_FILL_SCREEN_ASM_
%define VGA_FILL_SCREEN_ASM_

%include "vga.inc"

vga_fill_screen:
    ; occupies:
    ;   8 bytes;
    ; inputs:
    ; - al - color;
    ; expects:
    ; - es - VGA_PICTURE_SEGMENT;
    ; - df - 1;
    ; also mutates:
    ; - cx;
    ; - di;

    ; vga_picture[0 .. VGA_PICTURE_WIDTH * VGA_PICTURE_HEIGHT] = color;
    xor di, di
    mov cx, VGA_PICTURE_WIDTH * VGA_PICTURE_HEIGHT
    rep stosb

    ret

%endif
