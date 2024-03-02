; Muhammad Farhan Bukhari-----------BCS - 3F---------------21L-5247
; Q3

[org 0x0100]
		
			mov ax, 0xb800 					; load video base in ax
			mov es, ax 						; point es to video base
			mov di, 0 						; point di to top left column
											; es:di pointint to --> 0xB800:0000 (B8000)

nextchar: 	mov word [es:di], 0x075F 		; clear next char on screen
			add di, 2 						; move to next screen location
			cmp di, 2078					; has the whole screen cleared
			jne nextchar 					; if no clear next position

nextchar1: 	mov word [es:di], 0x072E		; clear next char on screen
			add di, 2 						; move to next screen location
			cmp di, 4000 					; has the whole screen cleared
			jne nextchar1 					; if no clear next position

			mov ax, 0x4c00 ; terminate program
			int 0x21 