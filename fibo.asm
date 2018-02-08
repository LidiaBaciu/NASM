; nasm -felf32 fibo.asm && gcc -m32 fibo.o && ./a.out


	global main
	extern scanf
	extern printf

section .data

	msg: db "enter n:", 0
	formatin: db "%d", 0
	formatout: db "the result is: %d", 10, 0

	integer: dd 0
	result: dd 0

section .text

function:
	;returns ecx

	push ebp
	mov ebp, esp

	;ebp + 0, ebp + 4 are system reserved
	mov eax, [ebp+8]
	
	
	cmp eax, 3	;eax ? 3
	jge recursion	;f(n), n>=3

	cmp eax, 2	;eax ? 2
	jl lesstwo	;eax < 2 => eax = 1 || eax = 0

			;f(2)
	mov ecx, 7	; eax = 7
	jmp end		;exit

	lesstwo:	;eax < 2
			;f(1) || f(0)
	mov ecx, 1	;eax = 1
	jmp end		;exit


	recursion:
	sub eax, 2	; n-2
	mov edx, eax
	push edx	;save n-2

	push eax
	call function	;will return in ecx

	pop eax

	sub eax, 1	; n-3

	push ecx	;save return value from f(n-2)

	push eax
	call function	;will return in eax

	pop eax

	add ecx, eax 	;f(n-3) = f(n-3) + f(n-2)


	end:		;exit
	mov esp, ebp
	pop ebp
	ret 4		;returns ecx, which is on 4 bytes	

main:

	push msg
	call printf
	add esp, 4    		; remove the parameter

	push integer
	push formatin
	call scanf
	add esp, 8    		; remove the parameters

	mov ecx, 0

	push dword[integer]	;parameter
	call function
	mov dword[result], ecx

	push dword[result]
	push formatout
	call printf
	add esp, 8    		; remove the parameters

	push 0
	mov eax, 1
	int 80h
