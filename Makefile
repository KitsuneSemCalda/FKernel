.PHONY: all run clean test test-clean

include config.mk

# Directories (used by Makefile to compile the Kernel)

SRC_DIR := Src
OBJ_DIR := Build/Obj
INC_DIR := Include
CONFIG_DIR := Config
TEST_DIR := Test
TEST_BUILD_DIR := Build/Test

# Recursive search to source code

C_SRCS := $(shell find $(SRC_DIR) -type f -name "*.c")
ASM_SRCS := $(shell find $(SRC_DIR) -type f -name "*.asm")
TEST_SRCS := $(shell find $(TEST_DIR) -type f -name "*.test.c")

# Converting Source Path to Object Path

C_OBJS := $(patsubst $(SRC_DIR)%.c, $(OBJ_DIR)%.o, $(C_SRCS))
ASM_OBJS := $(patsubst $(SRC_DIR)%.asm, $(OBJ_DIR)%.o, $(ASM_SRCS))
TEST_BINS := $(patsubst $(TEST_DIR)/%.test.c, $(TEST_BUILD_DIR)/%.test, $(TEST_SRCS))
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

# Rule to compile tests files
$(TEST_BUILD_DIR)/%.test: $(TEST_DIR)/%.test.c
	@mkdir -p $(dir $@)
	@echo "CC(Test): $<"
	@$(CC) $(CFLAGS) -IInclude $< -o $@

# Clean compiled files
clean: 
	@rm -rf Build/Obj Build/kernel.bin
	@echo "Cleaned"

run:
	@bash Tools/runKernel.sh

test: $(TEST_BINS)
	@echo "Running unit tests..."
	@FAILED=0; \
	for test_bin in $(TEST_BINS); do \
		echo "▶ Running: $$test_bin"; \
		if ! "$$test_bin"; then \
			echo "❌ FAIL: $$test_bin"; \
			FAILED=1; \
		else \
			echo "✅ PASS: $$test_bin"; \
		fi; \
	done; \
	if [ $$FAILED -eq 1 ]; then \
		echo "🚫 Some tests failed."; \
		exit 1; \
	else \
		echo "✔️ All tests passed."; \
	fi

test-clean:
	@rm -rf $(TEST_BUILD_DIR)
	@echo "Cleaned test binaries."
