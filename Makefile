QEMU=qemu-system-x86_64

.PHONY: clean
clean:
	@ rm -rf .nasm

.nasm/procs/%.bin: src/%.asm
	@ mkdir -p $(@D)
	@ nasm -i include -i src $< -o $@

.nasm/examples/%.bin: examples/%.asm
	@ mkdir -p $(@D)
	@ nasm -i include -i src $< -o $@

.PHONY: measure
measure: .nasm/procs/$(PROC).bin
	@ stat --printf="%s" $<

.PHONY: example
example: .nasm/examples/$(NAME).bin
	@ $(QEMU) -drive format=raw,file=.nasm/examples/$(NAME).bin
