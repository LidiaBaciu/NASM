
;nasm -f elf hello.asm
;ld -m elf_i386 -s -o hello hello.o
;./hello


;the main.s file contains the assembly code, but on a higher level

;32-bit data registers: eax, ebx, ecx, edx
;as my laptop is for 64-bit, i need to specify the elf_i386


; Define variables in the data section
SECTION .DATA
	hello:     db 'Lidia Baciu',10,0
	helloLen:  equ $-hello
	hello2:    db 'lidia.baciu97@gmail.com',10,0
	hello2Len: equ $-hello2

; Code goes in the text section
SECTION .TEXT
	GLOBAL _start 

_start:
	mov eax,4            ; 'write' system call = 4
	mov ebx,1            ; file descriptor 1 = STDOUT
	mov ecx,hello        ; string to write
	mov edx,helloLen     ; length of string to write
	int 80h              ; call the kernel

	mov eax,4            ; 'write' system call = 4
	mov ebx,1            ; file descriptor 1 = STDOUT
	mov ecx,hello2       ; string to write
	mov edx,hello2Len    ; length of string to write
	int 80h              ; call the kernel

	; Terminate program
	mov eax,1            ; 'exit' system call
	mov ebx,0            ; exit with error code 0
	int 80h              ; call the kernel



