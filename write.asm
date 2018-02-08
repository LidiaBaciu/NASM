
;nasm -felf64 second.asm && gcc second.o && ./a.out

SECTION .data
	message1: db "Enter the number: ",0
	message1Len: equ $-message1
	formatin: db "%d",0
	formatout: db "%d",10,0 ; newline, nul
	integer: times 4 db 0 ; 32-bits integer = 4 bytes

SECTION .text
	global main
	extern scanf
	extern printf

main:
	push rbx			;save the caller's value

	mov eax, 4			;'write' system call = 4
	mov ebx, 1			;file description 1 = STDOUT
	mov ecx, message1		;string to write
	mov edx, message1Len		;lenght of the string to write
	int 80h				;call the kernel

	mov rdi, formatin		;the format of the scanf
	mov rsi, integer		;the integer
	call scanf
	
	mov ebx, 1			;like index = 1
	loop:
		mov rdi, formatout	;the format of the printf
		mov esi, ebx		;save the ebs
		xor eax, eax		; printf is a varargs function so eax needs to be set 0 before the call
		call printf
		inc ebx			;like index++
		cmp [integer], ebx	; integer == ebx? 
	jge loop			;if (>=) jump

	pop rbx				;restore caller's value
	mov rax, 0
	 
ret					;return
