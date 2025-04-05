ENTRY(_start)

PHDRS {
  text PT_LOAD FLAGS(5);   /* R + X */
  rodata PT_LOAD FLAGS(4); /* R */
  data PT_LOAD FLAGS(6);   /* R + W */
  note PT_NOTE FLAGS(4);   /* R */
}

SECTIONS {
  . = 0x00100000;

  .note.Xen : ALIGN(4) {
    KEEP(*(.note.Xen))
  } :note

  .text : ALIGN(4K) {
    *(.text*)
  } :text

  .rodata : ALIGN(4K) {
    *(.rodata*)
  } :rodata

  .data : ALIGN(4K) {
    *(.data*)
  } :data

  .bss : ALIGN(4K) {
    *(.bss*)
    *(COMMON)
  } :data
}
