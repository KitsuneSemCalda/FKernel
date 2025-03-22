.PHONY: all clean

include ./config.mk

BUILD_DIR=Build
OBJ_DIR=$(BUILD_DIR)/Obj

KERNEL_BIN=$(BUILD_DIR)/kernel.bin
OBJS=$(shell find $(OBJ_DIR) -type f -name "*.o")

all: build run

build: $(KERNEL_BIN)

$(KERNEL_BIN): compile
	@echo "Linking kernel..."
	@$(LD) $(LDFLAGS) $(OBJS) -o $@

compile:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@find Src/* -type f -name Makefile -execdir $(MAKE) -s -C $(dir {}) \;

clean:
	@echo "Clean build..."
	@find Src/* -type f -name Makefile -execdir $(MAKE) -s -C $(dir {}) clean \;
	@rm -rf $(BUILD_DIR)
