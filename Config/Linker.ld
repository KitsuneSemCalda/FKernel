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
  
  .eh_frame_hdr : ALIGN(4K) {
  *(.eh_frame_hdr)
  } :rodata

.eh_frame : ALIGN(4K) {
  KEEP(*(.eh_frame))
} :rodata


  .data : ALIGN(4K) {
    *(.data*)
  } :data
  
  .bss : ALIGN(4K) {
    stack_bottom = .;
    . += 16K;
    stack_top = .;
    *(.bss*)
    *(COMMON)
  } :data

  .ctors : {
    KEEP(*(.ctors*))
  } :data

  .init_array : {
    KEEP(*(.init_array*))
  } :data

}
