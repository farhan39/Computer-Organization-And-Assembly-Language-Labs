; Muhammad Farhan Bukhari---------21L-5247-----------BCS-3F1

[org 0x0100]

jmp start

returnedValues : dw 0, 0, 0, 0
duckValue :	dw 4

goose :	
		push bp
		mov bp, sp
		mov byte[bp + 4], -4
		pop bp
		ret
		
sky :
		push bp
		mov bp, sp
		push ax
		mov ax, [bp + 4]
		sub [bp + 6], ax
		pop ax
		pop bp
		ret 4

sheep :	
		push bp
		mov bp, sp
		cmp word[bp + 4], 0
		jl	ret1FromSheep
		mov word[bp + 4], 0
		pop bp
		ret 2
		
ret1FromSheep :
				mov word[bp + 4], 1
				pop bp
				ret

duck:
		push bp
		mov bp,sp

		push ax 
		push bx
		push cx
		push dx

		push di

		mov ax,[bp+4]
		push bx
		push ax
		call sheep
		pop ax

		cmp ax,0
		je ret1FromDuck
		jne ret0FromDuck

ret1FromDuck :

			mov ax,[bp+4]
			mov bx,ax
			shl bx,1
			sub ax,bx
			mov [bp+6],ax
			jmp exit2

ret0FromDuck :
				mov ax,[bp+4]
				mov word [bp+6],ax


exit2:
		pop di
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2

; duck :
		; push bp
		; mov bp, sp
		; push bx
		; push dx
		
		; sub sp, 2
		; push word [duckValue]
		; call sheep
		; pop dx
		
		; cmp dx, 0
		; je retPositiveVal
		
		; push bx
		; mov bx, [duckValue]
		; shl bx, 2
		; sub word[duckValue], bx
		; pop bx
		
		; push ax
		; mov ax, word[duckValue]
		; mov word[bp + 6], ax
		; pop ax
		; ret 2
		
; retPositiveVal :
			
			; push ax
			; mov ax, word[duckValue]
			; mov word[bp + 6], ax
			; pop ax
			; ret

start :
		sub sp, 2
		call goose
		pop word[returnedValues]

	; bp->sp
		; bp
		; 6
		; 10
		; space
		
		sub sp, 2
		
		push word 10
		push word 6
		
		call sky
		pop word[returnedValues + 2]
		
		sub sp, 2
		push word -1	; temporary value
		call sheep
		pop word[returnedValues + 4]
		
		push ax
		mov ax,1
		push ax
		call duck
		pop word[returnedValues + 6]
		
mov ax, 0x4c00
int 0x21