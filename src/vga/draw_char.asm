%ifndef VGA_DRAW_CHAR_ASM_
%define VGA_DRAW_CHAR_ASM_

%include "vga.inc"

vga_draw_char:
    ; occupies:
    ;   40 bytes;
    ; inputs:
    ; - si - character (mutable);
    ; - cx - x (mutable);
    ; - di - y (mutable);
    ; - bx - foreground_color;
    ; - dx - background_color (dh is mutable);
    ; expects:
    ; - bp - vga_font_offset;
    ; - ds - vga_font_segment;
    ; - es - VGA_PICTURE_SEGMENT;
    ; - df - 1;
    ; also mutates:
    ; - ax;

    ; reuse y:
    ; i = y * VGA_PICTURE_WIDTH + x;
    imul di, di, VGA_PICTURE_WIDTH
    add di, cx
    ; reuse character:
    ; j = character * (VGA_GLYPH_SIZE := 8) + vga_font_offset;
    shl si, 3
    add si, bp
    ; reuse x:
    ; n = VGA_FONT_HEIGHT;
    mov cx, VGA_FONT_HEIGHT
  .fill_glyph:
    ; reuse part of background_color:
    ; row = vga_font[j++];
    lodsb
    mov dh, al
    ; reuse n:
    ; m = VGA_FONT_WIDTH;
    push cx
    mov cx, VGA_FONT_WIDTH
  .fill_row:
    ; pop out the highest bit of row;
    shl dh, 1
    ; vga_picture[i++] = bit == 1 ? background_color : foreground_color;
    movzx ax, dl
    cmovc ax, bx
    stosb
    ; if (--m != 0) continue;
    loop .fill_row
    ; restore i;
    ; i += VGA_PICTURE_WIDTH;
    add di, VGA_PICTURE_WIDTH - VGA_FONT_WIDTH
    ; if (--n != 0) continue;
    pop cx
    loop .fill_glyph

    ret

%endif
