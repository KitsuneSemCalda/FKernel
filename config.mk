# Config.mk
# This file is used to define the common tools used to compile the FKernel 

INCLUDE_DIR ?= ./Include
CONFIG_DIR ?= ./Config

BUILD_DIR ?= ./Build
OBJ_DIR ?= $(BUILD_DIR)/Obj

# Include all subdirectories recursively
INCLUDE_FLAGS :=  $(shell find $(INCLUDE_DIR) -type d | sed 's/^/-I/')

# Compiler - Clang targeting ffreestanding 64-bit
CC = clang

CFLAGS = -ffreestanding \
				 -nostdlib -nostdinc \
				 -m64 \
				 -O2 -c \
				 -fno-stack-protector \
				 -fno-strict-aliasing \
				 -fno-omit-frame-pointer \
				 -fno-optimize-sibling-calls \
				 $(INCLUDE_FLAGS)

# Assembler - NASM for 64 ELF output
AS = nasm
ASFLAGS = -felf64 \
					-O2

# Linker - LLVM LLD for deterministic	flat elf linking
LD = ld.lld
LDFLAGS = -nostdlib \
					-static \
					-T $(CONFIG_DIR)/Linker.ld \
					--no-dynamic-linker \
					--no-undefined \
					--gc-sections
