/*
 * Filename: main.h
 * Project: KitsuneBSD / FKernel
 * Author: KitsuneSemCalda <arthuramagalhaes1312@gmail.com>
 * Created On: 2025-04-05
 * License: SPDX-License-Identifier: BSD 3-Clause
 */
#pragma once

#include "../../Include/LibK/stdint.h"
#include "../../Include/MemoryManagement/imalloc.h"

void setup_stack(void);
void kmain(void);
