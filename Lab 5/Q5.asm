; Muhammad Farhan Bukhari-----------BCS - 3F---------------21L-5247
; Q5

[org 0x0100]
		
			mov ax, 0xb800 					; load video base in ax
			mov es, ax 						; point es to video base
			mov di, 0 						; point di to top left column
											; es:di pointint to --> 0xB800:0000 (B8000)

start : 
		mov bx, 0x8F00
		mov cx, 0

nextchar:
			mov word [es:di], bx
			; clear next char on screen
			add bl, 1
			add di, 2
			cmp cx, 255
			jz start
			cmp di, 4000					; has the whole screen cleared
			jne nextchar 					; if no clear next position

			mov ax, 0x4c00 ; terminate program
			int 0x21 
