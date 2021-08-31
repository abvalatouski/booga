%ifndef VGA_FILL_RECTANGLE_ASM_
%define VGA_FILL_RECTANGLE_ASM_

%include "vga.inc"

vga_fill_rectangle:
    ; occupies:
    ;   20 bytes;
    ; inputs:
    ; - si - x;
    ; - di - y (mutable);
    ; - dx - width;
    ; - bx - height (mutable);
    ; - al - color;
    ; expects:
    ; - es - VGA_PICTURE_SEGMENT;
    ; - df - 1;
    ; also mutates:
    ; - cx;

    ; reuse y:
    ; i = y * VGA_PICTURE_WIDTH + x;
    imul di, di, VGA_PICTURE_WIDTH
    add di, si
  .fill_row:
    ; vga_picture[i .. i + width] = color;
    mov cx, dx
    rep stosb
    ; restore i;
    sub di, dx
    ; i += VGA_PICTURE_WIDTH;
    add di, VGA_PICTURE_WIDTH
    ; if (--height != 0) continue;
    dec bx
    jnz .fill_row

    ret

%endif
