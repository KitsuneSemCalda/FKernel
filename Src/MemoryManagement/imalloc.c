/*
 * Filename: imalloc.c
 * Project: KitsuneBSD / FKernel
 * Author: KitsuneSemCalda <arthuramagalhaes1312@gmail.com>
 * Created On: 2025-04-05
 * License: SPDX-License-Identifier: BSD 3-Clause
 */

#include "../../Include/MemoryManagement/imalloc.h"

static uintptr_t imalloc_base = 0;
static uintptr_t imalloc_current = 0;
static uintptr_t imalloc_end = 0;

static inline uintptr_t align_up(uintptr_t value, size_t align) {
  return (value + align - 1) & ~(align - 1);
}

void *imalloc_aligned(size_t size, size_t align) {
  if (align == 0)
    align = 16;

  uintptr_t alloc_start = align_up(imalloc_current, align);
  uintptr_t alloc_end = alloc_start + size;

  if (alloc_end > imalloc_end) {
    asm("cli; hlt");
    return NULL;
  }

  imalloc_current = alloc_end;
  return ((void *)alloc_start);
}

void imalloc_init(uintptr_t start, size_t size) {
  imalloc_base = align_up(start, 16);
  imalloc_current = imalloc_base;
  imalloc_end = imalloc_base + size;
}

void *imalloc(size_t size) { return imalloc_aligned(size, 16); }
