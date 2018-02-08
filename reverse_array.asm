

;nasm -f elf try_array.asm -o try_array.o
;gcc -m32 try_array.o -o try_array.out
;./try_array.out

section .data
	array: dd 1, 2, 3, 4, 5
	message: dd "%d ", 10, 0
	integer_i: times 4 db 0

section .text
	global main
	extern printf

reverse:

	;interchange the values array[0], array[4]
				;array[1], array[3]
				;stop at array[2]
				;cause [5/2] = 2


	mov eax,[esi + 4*ecx]              ;eax = value at start
	mov ebx,[esi+4*edx]                ;ebx = value at end
	mov [esi + 4*edx],eax              ;Store value from start at end
	mov [esi + 4*ecx],ebx              ;Store value from end at start

		
	push esi			;Save the current array
		
	call print_array
				;at the end of this call
				;array will be at the end
				;so it must be retrieved 

	pop esi				;Retrieve the array

	dec edx				;last index --
	inc ecx				;first index ++
	
	cmp ecx, edx                	;Have we reached the middle?
	
	jne reverse                    	;no, keep going

	ret


print_array:

	mov dword[integer_i], 0

	loop:
		
		;push dword[integer_i]
		push ecx
		push edx

		push DWORD [esi]	;current element
		push message
		call printf
		add esp, 8		;clear the stack
		
		pop edx
		pop ecx
		
		;pop dword[integer_i]
		
		inc dword[integer_i]
		add esi, 4
		cmp [integer_i], edi
		jne loop

	
	ret

main:
	mov esi, array
	mov edi, 5

	mov ecx, 0		; first index = 0
	mov edx, 4		; last index = 0

	;push esi

	;call print_array

	;pop esi
	
	push ecx
	push edx
				;reverse(first, last)
	call reverse

	pop edx
	pop ecx


	ret


