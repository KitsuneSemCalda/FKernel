# Config.mk
# This file is used to define the common tools used to compile the FKernel 

INCLUDE_DIR ?= Include
CONFIG_DIR ?= Config

INCLUDE_FLAGS := $(shell find $(INCLUDE_DIR) -type d | sed 's/^/-I/g')

# Linker (LLVM LLD)
LD = ld.lld

LDFLAGS = -nostdlib \
					 -T $(CONFIG_DIR)/Linker.ld

# Compiler (Clang)
CC = clang
CFLAGS = -ffreestanding \
					 -nostdlib \
					 -nostdinc \
					 -m64 \
					 -O0 \
					 -c \
					 -$(INCLUDE_FLAGS) \
					 -fno-stack-protector \
					 -fno-strict-aliasing \
					 -fno-omit-frame-pointer \
					 -fno-optimize-sibling-calls \

# Assembler (NASM)
AS = nasm
ASFLAGS = -felf64 \
					-O2
