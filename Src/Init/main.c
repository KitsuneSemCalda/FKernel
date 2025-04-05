/*
 * Filename: main.c
 * Project: KitsuneBSD / FKernel
 * Author: KitsuneSemCalda <arthuramagalhaes1312@gmail.com>
 * Created On: 2025-04-05
 * License: SPDX-License-Identifier: BSD 3-Clause
 */

#include "../../Include/Init/main.h"

void setup_stack(void){
  asm("mov %0, %%rsp" : : "r"(stack_top));
}

void kmain(void) {
  setup_stack();
  while (1) {
    asm ("hlt");
  }
}
