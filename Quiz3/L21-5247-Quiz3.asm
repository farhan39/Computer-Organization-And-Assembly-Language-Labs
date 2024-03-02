;Example 8.3 - print string and keyboard wait using BIOS services 
[org 0x0100]
jmp start
recurse : db 0
msg1: db 'Hi, You pressed a', 0
msg2: db 'Hi, You pressed b', 0
msg3: db 'Hi, You entered the sswrong credentials', 0 
oldisr : dd 0
buffer : dw 0

;------------------------------------------------
strlen: push bp
		mov bp,sp
		push es
		push cx
		push di
		les di, [bp+4] ; point es:di to string
		mov cx, 0xffff ; load maximum number in cx
		xor al, al ; load a zero in al
		repne scasb ; find zero in the string
		mov ax, 0xffff ; load maximum number in ax
		sub ax, cx ; find change in cx
		dec ax ; exclude null from length
		pop di
		pop cx
		pop es
		pop bp
		ret 4 
;------------------------------------------------
clrscr: push es
		push ax
		push cx
		push di
		mov ax, 0xb800
		mov es, ax ; point es to video base
		xor di, di ; point di to top left column
		mov ax, 0x0720 ; space char in normal attribute
		mov cx, 2000 ; number of screen locations
		cld ; auto increment mode
		rep stosw ; clear the whole screen
		pop di 
		pop cx
		pop ax
		pop es
		ret 

;------------------------------------------------
printstr:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			push ds ; push segment of string
			mov ax, [bp+4]
			push ax ; push offset of string
			call strlen ; calculate string length 
			cmp ax, 0 ; is the string empty
			jz exit ; no printing if string is empty
			mov cx, ax ; save length in cx
			mov ax, 0xb800
			mov es, ax ; point es to video base
			mov al, 80 ; load al with columns per row
			mul byte [bp+8] ; multiply with y position
			add ax, [bp+10] ; add x position
			shl ax, 1 ; turn into byte offset
			mov di,ax ; point di to required location
			mov si, [bp+4] ; point si to string
			mov ah, [bp+6] ; load attribute in ah
			cld ; auto increment mode
			nextchar: lodsb ; load next char in al
			stosw ; print char/attribute pair
			loop nextchar ; repeat for the whole string
			exit: pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 8 
;------------------------------------------------------

hookkbisr :
			pusha
			xor ax, ax
			mov es, ax
			
			mov ax, word[es:9*4] 
			mov [oldisr], ax
			mov ax, word[es:9*4 + 2]
			mov [oldisr + 2], ax
			
			cli
			
			mov word[es:9*4], kbisr
			mov word[es:9*4 + 2], CS
			
			sti
			
			popa
			ret
			
unhookKBISR :
				pusha
				xor ax, ax
				mov es, ax
				
				mov ax, [oldisr]
				mov bx, [oldisr + 2]
				
				cli
				
				mov word[es:9*4], ax
				mov word[es:9*4 + 2], bx
				
				sti

				popa
				ret

kbisr :
		
		call clrscr ; clear the screen


		; mov ah, 0 ; service 0 – get keystroke
		; int 0x16 ; call BIOS keyboard service

		in al, 0x60
		
		cmp al, 0x30
		jne check2
		
		mov ax, 0
		push ax ; push x position
		mov ax, 0
		push ax ; push y position
		mov ax, 1 ; blue on black
		push ax ; push attribute
		mov ax, msg1
		push ax ; push offset of string
		call printstr ; print the string

		check2 :
		;mov ah, 0 ; service 0 – get keystroke
		;int 0x16 ; call BIOS keyboard service

		cmp al, 0x48
		jne printwrong
		
		mov ax, 0
		push ax ; push x position
		mov ax, 0
		push ax ; push y position
		mov ax, 0x71 ; blue on white
		push ax ; push attribute
		mov ax, msg2
		push ax ; push offset of string
		call printstr ; print the string

		printwrong:
		mov ax, 0
		push ax ; push x position
		mov ax, 0
		push ax ; push y position
		mov ax, 0x71 ; red on white blinking
		push ax ; push attribute
		mov ax, msg3
		push ax ; push offset of string
		call printstr ; print the string

		add byte[cs : recurse], 1
		
endIsr1 :

		mov al, 0x20
		out 0x20, al
		popa
		iret

start :
		mov ah, 0
		int 0x16
		call hookkbisr
		
l1:
		cmp byte[recurse], 2
		jne l1
		
		call unhookKBISR
		mov ax, 0x4c00 ; terminate program
		int 0x21 