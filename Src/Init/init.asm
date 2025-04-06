section .text

global _start

extern imalloc_aligned
extern imalloc_init
extern kmain

_start:
  cli ; Disable Interrupts
  xor rbp, rbp ; Zeroing base pointer
  
  mov rdi, 0x100000 ; Set the early allocator to start in 1MiB
  mov rsi, 0x100000 ; Set the limit of allocator to 1MiB
  call imalloc_init
  
  mov rdi, 16384 ; Align the allocator in 16 KiB
  mov rsi, 16 ; Align to initial 16 Bits
  call imalloc_aligned

  mov rsp, rax
  call kmain

.halt:
  hlt
  jmp .halt
