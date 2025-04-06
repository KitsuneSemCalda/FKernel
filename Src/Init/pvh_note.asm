section .note.Xen note align=4

    ; Namesz, Descsz, Type
    dd 4                      ; n_namesz
    dd 8                      ; n_descsz
    dd 0x12                   ; n_type = XEN_ELFNOTE_PHYS32_ENTRY

    ; Name: "Xen" + null terminator
    db 'X', 'e', 'n', 0

    ; Align to 4 bytes before desc
    align 4

    ; Desc: Entry point físico
    dd 0x00100000             ; 1 MiB


