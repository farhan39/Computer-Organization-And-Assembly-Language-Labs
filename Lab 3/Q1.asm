[org 0x0100]

mov ax, 0xABA5
mov bx, 0xB189
mov dx, 0x0000 ; for inverting bits column wise
mov cx, 16
mov si, 0

jmp l1

incDXBy1 :
			mov dx, 1
			jmp bitInvert

l1 :
	dec cx
	cmp cx, 0
	jz move1
	shl bx, 1		; to calculate number of one bits
	jnc l1
	add si, 1
	cmp cx, 0
	jz move1
	jmp l1

move1 :
		cmp si, 0
		jnz incDXBy1

bitInvert :			
			xor ax, dx
			dec si
			shl dx, 1
			cmp si, 0
			jnz bitInvert
	
mov ax, 0x4c00
int 0x21