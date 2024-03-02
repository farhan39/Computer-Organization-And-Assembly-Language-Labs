; Muhammad Farhan Bukhari---------21L-5247-----------BCS-3F1

[org 0x0100]

jmp start

array1 : db 9, 10, 15, 21, 78, 69
array2 : db 34, 56, 12, 67, 3, 8, 1, 45, 69, 22, 51

length1 : dw 6
length2 : dw 11


sum :
		push bp
		mov bp, sp
		push ax 
		push bx
		push cx
		push dx
		push di

		mov ax, 0
		mov cx, [bp+4]
		mov bx, [bp+6]
		mov di, 0
		mov dx, 0

sumLoop :
			mov al, [bx+di]
			add dl, al
			add di, 1
			loop sumLoop

			mov [bp+8], dx

			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop bp
			ret 4

start:
		push ax
		mov ax, array1
		push ax
		mov ax, [length1]
		push ax
		call sum
		pop ax


		push ax
		mov ax, array2
		push ax
		mov ax, [length2]
		push ax
		call sum
		pop ax

mov ax ,0x4c00
int 0x21