;nasm -f elf something.asm -o something.o
;gcc -m32 something.o -o something.out
;./something.out

SECTION .data
	string: db "please Work!!",10, 0
	len: 	equ $-string


SECTION .text
	global main

main:
	mov ecx, string
	call print
	call toUpper
	call print
	mov eax, 1
	mov ebx, 0
	int 80h

print:
	mov ecx, string
	mov edx, len
	mov ebx, 1
	mov eax, 4
	int 80h
	ret


toUpper:
	mov al, [ecx]
	cmp al, 0x0
	je done
	cmp al, 'a'
	jb next_phase		;jump bigger
	cmp al, 'z'
	ja next_phase		;not assigned comp
	sub al, 0x20
	mov [ecx], al

next_phase:
	inc ecx
	jmp toUpper

done:
	ret
