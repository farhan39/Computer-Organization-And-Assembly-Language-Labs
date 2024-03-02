; ----------------Q3---------------
; Muhammad Farhan Bukhari------------21L-5247-----------BCS-3F

[org 0x0100]

mov si, array2 - array1
mov di, 0

l1 :
	mov al, [array1 + si - 1]
	mov [array2 + di], al
	add di, 1
	sub si, 1
	jnz l1

mov ax, 0x4c00
int 0x21

array1 : db 1, 2, 3, 4, 5, 6
array2 : db 0, 0, 0, 0, 0, 0