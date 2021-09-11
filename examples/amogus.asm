%include "begin.inc"
%include "vga.inc"

; https://www.fountainware.com/EXPL/vga_color_palettes.htm
%define COLOR_BLACK 0x0
%define COLOR_GRAY 0x7
%define COLOR_BLUE 0x20
%define COLOR_LIME 0x2F

%define CHARACTER_OFFSET_X 99
%define CHARACTER_OFFSET_Y 13

%define MESSAGE_LENGTH (message_end - message)
%define MESSAGE_OFFSET_X \
    ((VGA_PICTURE_WIDTH - MESSAGE_LENGTH * VGA_FONT_WIDTH) / 2)
%define MESSAGE_OFFSET_Y 183

; enable VGA
mov ax, 0x13
int 0x10

; get font info
mov ax, 0x1130
mov bh, 0x03
int 0x10
mov ax, es
mov ds, ax

mov ax, VGA_PICTURE_SEGMENT
mov es, ax

; body
mov al, COLOR_GRAY
mov bx, 90
mov dx, 100
mov di, CHARACTER_OFFSET_Y
mov si, CHARACTER_OFFSET_X + 20
call vga_fill_rectangle
; eye
mov al, COLOR_BLUE
mov bx, 30
mov dx, 40
mov di, CHARACTER_OFFSET_Y + 30
mov si, CHARACTER_OFFSET_X + 50
call vga_fill_rectangle
; left leg
mov al, COLOR_GRAY
mov bx, 70
mov dx, 30
mov di, CHARACTER_OFFSET_Y + 90
mov si, CHARACTER_OFFSET_X + 20
call vga_fill_rectangle
mov al, COLOR_GRAY
mov bx, 30
mov dx, 20
mov di, CHARACTER_OFFSET_Y + 130
mov si, CHARACTER_OFFSET_X
call vga_fill_rectangle
; right leg
mov al, COLOR_GRAY
mov bx, 70
mov dx, 30
mov di, CHARACTER_OFFSET_Y + 90
mov si, CHARACTER_OFFSET_X + 90
call vga_fill_rectangle
mov al, COLOR_GRAY
mov bx, 30
mov dx, 20
mov di, CHARACTER_OFFSET_Y + 130
mov si, CHARACTER_OFFSET_X + 70
call vga_fill_rectangle

mov dx, COLOR_BLACK
mov bx, COLOR_LIME
mov di, MESSAGE_OFFSET_Y
mov cx, MESSAGE_OFFSET_X
mov si, message
call vga_draw_string

cli
hlt

%include "vga/draw_string.asm"
%include "vga/fill_rectangle.asm"

; The string must be null terminated.
message:
    db "236 byte amogus"
message_end:
    db 0

%include "end.inc"
