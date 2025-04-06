/*
 * Filename: imalloc.h
 * Project: KitsuneBSD / FKernel
 * Author: KitsuneSemCalda <arthuramagalhaes1312@gmail.com>
 * Created On: 2025-04-05
 * License: SPDX-License-Identifier: BSD 3-Clause
 */
#pragma once

#include "../../Include/LibK/stddef.h"
#include "../../Include/LibK/stdint.h"

void imalloc_init(uintptr_t start, size_t size);
void *imalloc(size_t size);
void *imalloc_aligned(size_t size, size_t align);
void ifree(void);
