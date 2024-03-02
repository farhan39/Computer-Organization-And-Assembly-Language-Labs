[org 0x0100]
jmp start

multiplicand: dd 0xABCDD4E1, 0
multiplier: dd 0xAB5C32
result: dd 0, 0

start: 
		mov cx, 32 ; initialize bit count to 16
		mov bx, [multiplicand]
	
checkbit: 
		shr word[multiplier + 2], 1
		rcr word[multiplier], 1
		jnc skip
 
		mov ax, [multiplicand]
		add [result], ax
		mov ax, [multiplicand+2]
		adc [result+2], ax
		mov ax, [multiplicand+4]
		adc [result+4], ax
		mov ax, [multiplicand+6]
		adc [result+6], ax

skip: 
	shl word [multiplicand], 1
	rcl word [multiplicand+2], 1
	rcl word [multiplicand+4], 1
	rcl word [multiplicand+6], 1
	dec cx
	jnz checkbit
	
mov ax,0x4c00
int 0x21
