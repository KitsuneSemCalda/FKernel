/*
 * Filename: main.c
 * Project: KitsuneBSD / FKernel
 * Author: KitsuneSemCalda <arthuramagalhaes1312@gmail.com>
 * Created On: 2025-04-05
 * License: SPDX-License-Identifier: BSD 3-Clause
 */

#include "../../Include/Init/main.h"

void setup_stack(void) { void *stack = imalloc_aligned(16384, 16); }

void kmain(void) {
  setup_stack();

  while (1) {
    asm("hlt");
  }
}
