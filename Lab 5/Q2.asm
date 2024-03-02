; Muhammad Farhan Bukhari--------------BCS - 3F-------------21L-5247
; Q2
[org 0x0100]
jmp start

delay:      push cx
			mov cx, 0xFFFF
loop1:		loop loop1
			mov cx, 0xFFFF
loop2:		loop loop2
			pop cx
			ret	

start:
		mov ax, 0xb800 					
		mov es, ax 						
		mov di, 0 						
										

nextchar:
		mov word [es:di], 0x0720 		
		add di, 2 						
		cmp di, 4000 					
		jne nextchar 		
		
		mov ax, 0xb800 					
		mov es, ax 
		mov di,160
	
	
infiniteLoop :
		mov cl,79	
	row1: 
		mov word [es:di], 0x0720 		
		add di, 2 			
		mov word[es:di],0x072A
		dec cl
		call delay
		cmp cl,0
		jnz row1
		
		
		mov cl,23
	col1: 
		mov word [es:di], 0x0720 		
		add di, 160
		mov word[es:di],0x072A
		call delay
		dec cl
		cmp cl,0
		jnz col1
		
		mov cl,79
	row2: 
		mov word [es:di], 0x0720 		
		sub di, 2 			
		mov word[es:di],0x072A
		call delay
		dec cl
		cmp cl,0
		jnz row2
		
		mov cl,23
	col2: 
		mov word [es:di], 0x0720 		
		sub di, 160 			
		mov word[es:di],0x072A
		call delay
		dec cl
		cmp cl,0
		jnz col2
		jmp infiniteLoop

mov ax,0x4c00
int 0x21