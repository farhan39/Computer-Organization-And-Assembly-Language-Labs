; Muhammad Farhan Bukhari-------21L-5247-------BCS-3F

[org 0x0100]

jmp calcGrade

num : dw 0x61
grade : db 0

calcGrade :
			push word[num]
			pusha
			cmp word[num], 0
			ja gradeValid
			popa 
			jmp terminate
			
gradeValid :
			cmp word[num], 0x3B		; if less than 59
			jl retFgrade			; if less
			jz retFgrade			; if equal
			jmp nextCompare
			
retFgrade :
			popa
			mov byte[grade], 'F'
			
nextCompare :
				cmp word[num], 0x45	;  comparing if less than 69
				jl retDgrade
				jz retDgrade
				jmp nextCompare1
				
retDgrade :
				popa
				mov byte[grade], 'D'
				jmp terminate
				
nextCompare1 :
				cmp word[num], 0x4F		; check if less than 79
				jl retCgrade
				jz retCgrade
				jmp nextCompare2
				
retCgrade :
			popa
			mov byte[grade], 'C'
			jmp terminate
			
nextCompare2 :
				cmp word[num], 0x59		; if less or equal to 89
				jl retBgrade
				jz retBgrade
				jmp nextCompare3
			
retBgrade :
			popa
			mov byte[grade], 'B'
			jmp terminate
			
nextCompare3 :
				cmp word[num], 0x64
				jl retAgrade	; if less than 100
				jz retAgrade	; if equal to 100
				popa 
				jmp terminate
				
retAgrade :
			popa
			mov byte[grade], 'A'
				
terminate :
			mov ax, 0x4c00
			int 0x21