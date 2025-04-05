#!/usr/bin/env bash

KERNEL_BIN="Build/kernel.bin"

if [ ! -f "$KERNEL_BIN" ]; then
  printf " Can't find %s\n" "$KERNEL_BIN"
  exit 1
fi

qemu-system-x86_64 -kernel "$KERNEL_BIN" \
  -m 4G \
  -smp 2
