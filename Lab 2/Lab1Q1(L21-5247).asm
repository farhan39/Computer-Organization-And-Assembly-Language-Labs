;--------------Q1--------------
; Muhammad Farhan Bukhari------------21L-5247-----------BCS-3F
[org 0x0100]

mov cx, [N]
mov ax, 0
l1 :
	add ax, cx
	sub cx, 1
	jnz l1

mov [sum], ax

mov ax, 0x4c00
int 0x21

N : dw 6
sum: dw 0