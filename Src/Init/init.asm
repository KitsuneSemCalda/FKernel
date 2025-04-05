section .text

global _start
extern kmain

_start:
  cli ; Disable Interrupts
  xor rbp, rbp ; Zeroing base pointer
  mov rsp, stack_top ; Define Initial Stack
  call kmain

.halt:
  hlt
  jmp .halt

section .bss 
align 16
stack_bottom:
    resb 16384              ; 16 KB
stack_top:
