## Dependencies

- [NASM](https://www.nasm.us/);
- [QEMU](https://www.qemu.org/) for examples (change `QEMU` inside `Makefile`
  for an appropriate emulator; the default is `qemu-system-x86_64`).

## Quick Start

### Measure size of a procedure in bytes

```console
$ make measure PROC=vga/fill_screen
8
```

### Run an example

```console
$ make example NAME=amogus
```

It works on real machines, BTW! 😀

![Photo of real computer launching the bootloader.](img/amogus.jpg?raw=true)
