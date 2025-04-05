.PHONY: all run clean

include config.mk

# Directories (used by Makefile to compile the Kernel)

SRC_DIR := Src
OBJ_DIR := Build/Obj
INC_DIR := Include
CONFIG_DIR := Config

# Recursive search to source code

C_SRCS := $(shell find $(SRC_DIR) -type f -name "*.c")
ASM_SRCS := $(shell find $(SRC_DIR) -type f -name "*.asm")

# Converting Source Path to Object Path

C_OBJS := $(patsubst $(SRC_DIR)%.c, $(OBJ_DIR)%.o, $(C_SRCS))
ASM_OBJS := $(patsubst $(SRC_DIR)%.asm, $(OBJ_DIR)%.o, $(ASM_SRCS))
OBJS := $(C_OBJS) $(ASM_OBJS)

# Main Target
all: kernel run

kernel: $(OBJS)
	@echo "Linking Objects..."
	@$(LD) $(LDFLAGS) -o Build/kernel.bin $(OBJS)
	@echo "Kernel compiled with sucess!"

# Rule to compile c files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@echo "CC: $<"
	@$(CC) $(CFLAGS) $< -o $@

# Rule to compile asm files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	@mkdir -p $(dir $@)
	@echo "AS: $<"
	@$(AS) $(ASFLAGS) $< -o $@

# Clean compiled files
clean: 
	@rm -rf Build/Obj Build/kernel.bin
	@echo "Cleaned"

run:
	@bash Tools/runKernel.sh

