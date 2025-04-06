section .text

global _start

extern imalloc_aligned
extern imalloc_init
extern kmain

_start:
  cli ; Disable Interrupts
  xor rbp, rbp ; Zeroing base pointer
  
  mov rdi, 0x100000
  mov rsi, 0x100000
  call imalloc_init
  
  mov rdi, 16384
  mov rsi, 16
  call imalloc_aligned

  mov rsp, rax
  call kmain

.halt:
  hlt
  jmp .halt
