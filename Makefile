
# Architecture must be i386 per subject requirements
arch ?= i386
kernel := build/kernel-$(arch).bin
iso := build/os-$(arch).iso

# Source files
asm_sources := boot.asm multiboot_header.asm
asm_objects := $(patsubst %.asm, build/%.o, $(asm_sources))

c_sources := kernel.c vga.c
c_objects := $(patsubst %.c, build/%.o, $(c_sources))

all_objects := $(asm_objects) $(c_objects)

# Compiler flags as per subject
CFLAGS := -m32 -nostdlib -nodefaultlibs -fno-builtin -fno-exceptions \
          -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra

# Linker flags
LDFLAGS := -m elf_i386 -n -T linker.ld --nmagic
LDFLAGS := -m elf_i386 -n -T linker.ld -z noexecstack
.PHONY: all clean run iso

all: $(kernel)

clean:
	@rm -rf build

run: $(iso)
	@qemu-system-i386 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) grub.cfg
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/kernel.bin
	@cp grub.cfg build/isofiles/boot/grub
	@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
	@rm -rf build/isofiles
	@echo "ISO created: $(iso)"

$(kernel): $(all_objects) linker.ld
	@mkdir -p $(shell dirname $@)
	@ld $(LDFLAGS) -o $(kernel) $(all_objects)
	@echo "Kernel linked: $(kernel)"

# Compile assembly files
build/%.o: %.asm
	@mkdir -p $(shell dirname $@)
	@nasm -f elf32 $< -o $@
	@echo "Assembled: $<"

# Compile C files
build/%.o: %.c
	@mkdir -p $(shell dirname $@)
	@gcc $(CFLAGS) -c $< -o $@
	@echo "Compiled: $<"

re: clean all run
	




















# # Architecture must be i386 per subject requirements
# arch ?= i386
# kernel := build/kernel-$(arch).bin
# iso := build/os-$(arch).iso

# # Source files
# asm_sources := boot.asm multiboot_header.asm
# asm_objects := $(patsubst %.asm, build/%.o, $(asm_sources))

# c_sources := kernel.c vga.c
# c_objects := $(patsubst %.c, build/%.o, $(c_sources))

# all_objects := $(asm_objects) $(c_objects)

# # Compiler flags as per subject
# CFLAGS := -m32 -nostdlib -nodefaultlibs -fno-builtin -fno-exceptions \
#           -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra

# # Linker flags
# LDFLAGS := -m elf_i386 -n -T linker.ld

# .PHONY: all clean run iso

# all: $(kernel)

# clean:
# 	@rm -rf build

# run: $(iso)
# 	@qemu-system-i386 -cdrom $(iso)

# iso: $(iso)

# $(iso): $(kernel) grub.cfg
# 	@mkdir -p build/isofiles/boot/grub
# 	@cp $(kernel) build/isofiles/boot/kernel.bin
# 	@cp grub.cfg build/isofiles/boot/grub
# 	@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
# 	@rm -rf build/isofiles
# 	@echo "ISO created: $(iso)"

# $(kernel): $(all_objects) linker.ld
# 	@mkdir -p $(shell dirname $@)
# 	@ld $(LDFLAGS) -o $(kernel) $(all_objects)
# 	@echo "Kernel linked: $(kernel)"

# # Compile assembly files
# build/%.o: %.asm
# 	@mkdir -p $(shell dirname $@)
# 	@nasm -f elf32 $< -o $@
# 	@echo "Assembled: $<"

# # Compile C files
# build/%.o: %.c
# 	@mkdir -p $(shell dirname $@)
# 	@gcc $(CFLAGS) -c $< -o $@
# 	@echo "Compiled: $<"