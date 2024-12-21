# Introduction

FKernel is a multilayer hybrid kernel.

It is a combination of exokernel, a monolithic kernel, and a microkernel.

The kernel is divided in three layers:

1. **ExoKernel**: The lowest layer, directly communicates with the hardware.
2. **MicroKernel**: The middle layer, manages the communication between layers
3. **Monolithic Kernel**: The highest layer, manages userspace with POSIX API.

## Why I chose this architecture?

I wanted to use a hybrid structure but didn’t want to rely on multiple servers.

My kernel need to be functional with or without multiple servers.

Nor did I want to abstract hardware directly.

Instead, I believe it’s better not to abstract hardware at the lowest layer.

I plan to scale the abstraction from bottom to top.
