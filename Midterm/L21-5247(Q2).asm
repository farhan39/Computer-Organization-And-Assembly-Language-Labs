; Muhammad Farhan Bukhari-------21L-5247-------BCS-3F

[org 0x0100]

jmp start

buffer :	times 80 dw 0

delay :
		push cx
		mov cx, 0xFFFF
loop1 :
		loop loop1
		
		mov cx, 0xFFFF
loop2 :	loop loop2

		pop cx
		ret

scrollUp:
			call delay
			call delay
			push bp
			mov bp, sp
			push ax
			push cx
			push si
			push di
			push es
			push ds
			
			
			mov ax, 0xb800
			mov es, ax
			mov ds, ax
			xor di, di
			
			mov cx, 78
			
		tempLoop :	; store first row in buffer
					mov ax, [es : di]
					mov [buffer + si], ax
					add si, 1
					add di, 1
					loop tempLoop
			
			mov si, 80
			push si
			shl si, 1
			mov cx, 1840
			
			mov ax, 0xb800
			mov es, ax
			mov ds, ax
			xor di, di
			
			cld
			
			rep movsw
			mov ax, 0x0720
			pop cx
			
			mov si, 0
			
			mov cx, 78
		tempLoop1 :	; store back first row
					mov ax, [buffer + si]
					mov word[es:di], ax
					add si, 1
					add di, 1
					loop tempLoop1
			
			pop ds
			pop es
			pop di
			pop si
			pop cx
			pop ax
			pop bp
			jmp scrollUp
			
start :
		call scrollUp
					
mov ax, 0x4c00
int 0x21