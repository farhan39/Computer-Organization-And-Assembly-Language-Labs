; Muhammad Farhan Bukhari--------------BCS - 3F-----------21L-5247


; use 'a' key as an alternative of escape key (escape key is not working in my pc)
[org 0x0100]
 
jmp start

buffer: times 4000 db 0

;---------------------------------------------------------------------------

sleep:		push cx

		mov cx, 0xFFFF
delay:		loop delay

		pop cx
		ret
;--------------------------------------------------------------------
; subroutine to clear the screen
;--------------------------------------------------------------------

clrscr:		push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					
			mov di, 0					

nextloc:	mov word [es:di], 0x0720	
			add di, 2					
			cmp di, 4000				
			jne nextloc					

			pop di
			pop ax
			pop es
			ret

;--------------------------------------------------------------------

 ;-----------------------------------------------------------------
; subroutine to save the screen
;-----------------------------------------------------------------

saveScreen:	
			pusha	
			mov cx, 4000 

					

			mov ax, 0xb800
			mov ds, ax 

			push cs
			pop es
		
			mov si, 0
			mov di, buffer

			cld 
			rep movsb 

			
			

			popa
			ret

;-----------------------------------------------------------------
; subroutine to restore the screen
;-----------------------------------------------------------------
restoreScreen:		

			pusha	

			mov cx, 4000

			mov ax, 0xb800
			mov es, ax 

			push cs
			pop ds
		
			mov si, buffer
			mov di, 0

			cld 
			rep movsb 

			
			

			popa
			ret	
;-----------------------------------------------------------------
start: 

	call saveScreen
	
	mov ah, 0								
	int 0x16
	mov bx,0
	call clrscr
	
	mov cx,100
	
loop2:

		sti
		int 0x16
		
	loop1:
	
		call clrscr
		in al, 0x60	
	   
		cmp al,0x03
		jz terminate
		cmp al,0x1e
		jz terminate
		
		cli

		cmp al, 0x30				
		je loop1
		jne screenRestorer

		cmp al,0x69
		je loop1
		jne screenRestorer

		jmp loop1
		
		mov ah, 0								
		int 0x16

screenRestorer:

		call clrscr
		call restoreScreen
		dec cx
		mov ah, 0							
		jnz loop2

terminate:

mov ax, 0x4c00 
int 0x21 