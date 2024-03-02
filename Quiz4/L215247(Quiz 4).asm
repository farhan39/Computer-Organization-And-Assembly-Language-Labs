;Muhammad Farhan Bukhari-------BCS-3F-------21L-5247
;Quiz 4 COAL Lab

[org 0x0100]

jmp start
oldisr: dd 0

clrscr:
			pusha
			mov ax, 0xb800 					
			mov es, ax 						
			mov di, 0 						

nextchar: 	mov word [es:di], 0x0720 		
			add di, 2 						
			cmp di, 4000 					
			jne nextchar
			
			popa
			ret
			
kbisr:		
			push ax
			push es

			mov ax, 0xb800
			mov es, ax 

			in al, 0x60 

			cmp al, 0x2a 
			jne nextcmp
			
			mov byte [es:0], 'F'
			mov byte [es:2], 'A'
			mov byte [es:4], 'R'
			mov byte [es:6], 'H'
			mov byte [es:8], 'A'
			mov byte [es:10], 'N'
			mov byte [es:12], ' '
			mov byte [es:14], 'B'
			mov byte [es:16], 'U'
			mov byte [es:18], 'K'
			mov byte [es:20], 'H'
			mov byte [es:22], 'A'
			mov byte [es:24], 'R'
			mov byte [es:26], 'I'
			
			jmp exit
		
nextcmp:	cmp al, 0xaa
			jne nomatch
			call clrscr
			jmp exit

nomatch:	pop es
			pop ax
			jmp far [cs:oldisr]

exit:		mov al, 0x20
			out 0x20, al
			pop es
			pop ax
			iret
			
start:	
		xor ax, ax
		mov es, ax
		
		mov ax, [es:9*4]
		mov [oldisr], ax
		mov ax, [es:9*4+2]
		mov [oldisr+2], ax

		cli
		mov word [es:9*4], kbisr
		mov [es:9*4+2], cs
		sti

		mov dx, start ; end of resident portion
		add dx, 15 ; round up to next para
		mov cl, 4
		shr dx, cl ; number of paras..../2^4
		
		mov ax, 0x3100 ; terminate and stay resident
		int 0x21