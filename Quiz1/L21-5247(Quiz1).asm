; Farhan Bukhari-----21L-5247-----BCS-3F

jmp start

digits : dw 0, 0, 0, 0, 0	; will store digits of the hexa number in reverse order
decimal : dw 0

print1 :
	mov [es : 0], '/'
	jmp terminate

print2 : 
	mov [es : 1], '4'
	jmp terminate

ascii_convert :
		push bp
		mov bp, sp
		mov di, 0
loop :
		div word[bp + 4]
		mov ax, dx
		mov [digits + di], ax
		add di, 2
		cmp dx, 0
		
		jne loop
	
		mov ax, [digits + di]		; add last digit (7) as it is
		add [decimal], ax
		sub di, 2

		mov ax, [digits + di]
		sub di, 2
		mov bx, 0x10
		mul bx				; 5247 -> 4 * 16 raised to power 1
		add word[decimal], ax
		
		mov ax, [digits + di]
		sub di, 2
		mov bx, 0x100
		mul bx				; 5247 -> 2 * 16 raised to power 2
		add word[decimal], ax
		
		mov ax, [digits + di]
		sub di, 2
		mov bx, 0x1000
		mul bx				; 5247 -> 5 * 16 raised to power 3
		add word[decimal], ax

		mov ax, [decimal]
		mov bx, 0x64
		div bx				; divide by 100 to separate digits
		
		cmp ax, 0x2F	; compare left half of number
		je print1
		
		cmp dx, 0x34	; compare first half of number
		je print2

		pop bp
		ret 2

start :
	mov dx, 0x5247
	mov bx, 10
	mov ax, dx
	push bx
	call ascii_convert

terminate :
		mov ax, 0x4c00
		int 0x21