
; nasm -f elf example.asm -o example.o
; gcc -m32 example.o -o example.out
; ./example.out

section .text
	global main
  	extern printf
  	extern scanf

section .data
  	message: db "The result is = %d", 10, 0
  	request: db "Enter the number:", 0
  	integer: times 4 db 0 ; 32-bits integer = 4 bytes
  	formatin: db "%d", 0


main:
				;  Ask for an integer
  	push request		;prints the message request
  	call printf
  	add esp, 4    		; remove the parameter

  	push integer 		; second parameter
  	push formatin 		; first  parameter
		      		;arguments are right to left
  	call scanf
  	add esp, 8    		; remove the parameters


	mov ebx, 1		;like index = 1
loop:

  		      		; Move the value under the address integer1 to EAX
  	mov eax, ebx
		      		;eax will contain the quantient and edx the remainder 

	mov edx, 0
	mov ecx, 11		;test if number is divisible with 11
	div ecx

	cmp edx, 0		; the remainder has to be 0 
	je .if_true	
				;code to run if comparison is false
				;do nothing if the number is not divisible with 11
	jmp short .end_if
	.if_true:
				;code to run if comparison is true
				; Print out the content of edx register
  		push ebx	
				; the remainder 
	  	push message
	  	call printf
	  	add esp, 8	;remove the parameters
	.end_if:
	inc ebx			;like index++
	cmp [integer], ebx	;integer ? ebx
jge loop			;if integer >= ebx jump

  				;  Linux terminate the app
  	MOV AL, 1
  	MOV EBX, 0 
  	INT 80h 		;call kernel
