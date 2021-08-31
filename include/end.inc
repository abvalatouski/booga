%ifndef BOOTLOADER_END_INC_
%define BOOTLOADER_END_INC_

%include "begin.inc"

%assign BOOTLOADER_ACTUAL_SIZE ($ - $$)
%warning bootloader size is BOOTLOADER_ACTUAL_SIZE/BOOTLOADER_SIZE bytes

%if BOOTLOADER_ACTUAL_SIZE <= BOOTLOADER_SIZE
    %assign BOOTLOADER_PADDING \
        BOOTLOADER_SIZE - BOOTLOADER_SIGNATURE_SIZE - BOOTLOADER_ACTUAL_SIZE
    times BOOTLOADER_PADDING db 0
    dw BOOTLOADER_SIGNATURE
%else
    %fatal bootloader size exceeded
%endif

%endif
