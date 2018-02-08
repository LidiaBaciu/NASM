
; nasm -felf64 max.asm && gcc max.o && ./a.out

section .data
	message1: db "enter a:", 0
	message1Len: equ $-message1
	message2: db "enter b:", 0
	message2Len: equ $-message2
	message3: db "enter c:", 0
	message3Len: equ $-message3
	
	
	msg: db "the maximum is:", 0
	msgLen: equ $-msg
	
	integer1: times 4 db 0;
	integer2: times 4 db 0;
	integer3: times 4 db 0;
	largest: times 4 db 0;


section .text
	global main


function: 			;returns largest in eax
	;ebx = a; ecx = b; edx = c
	
	cmp ebx, ecx		;a ? b
	jle smaller		; a <= b
	
	bigger:			; a > b
		mov eax, ebx
	jmp end

	smaller:		; a <= b
		mov eax, ecx
	
	end:	

	cmp edx, eax		;c ? max(a,b)

	jle smaller1		; c <= max(a,b)
	
	bigger1:		; c > max(a,b)
		mov eax, edx	; max = c
	jmp end2

	smaller1:		; c <= max(a,b)
		jmp end2	;not interested 

	end2:
	ret

main:
			;read first
	mov eax, 4
	mov ebx, 1
	mov ecx, message1
	mov edx, message1Len
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, integer1
	mov edx, 4
	int 80h

			;read second
	mov eax, 4
	mov ebx, 1
	mov ecx, message2
	mov edx, message2Len
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, integer2
	mov edx, 4
	int 80h

			;read third
	mov eax, 4
	mov ebx, 1
	mov ecx, message3
	mov edx, message3Len
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, integer3
	mov edx, 4
	int 80h
	
	mov ebx, [integer1]		;param1
	mov ecx, [integer2]		;param2
	mov edx, [integer3]		;param3
	call function
					;returns eax
	mov [largest], eax		;save the maximum
	
	mov ecx, msg
	mov edx, msgLen
	mov ebx, 1
	mov eax, 4
	int 80h

	mov ecx, largest		;print it
	mov edx, 2
	mov ebx, 1
	mov eax, 4
	int 80h

	mov eax, 1
	int 80h



