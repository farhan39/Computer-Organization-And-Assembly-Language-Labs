jmp start

seconds:    dw 0    ; number of seconds
ticks:      dw 0    ; count of ticks
isLeft:     db 0    ; left movement flag
isRight:    db 0    ; right movement flag
isTop:      db 0    ; up movement flag
isBottom:   db 0    ; down movement flag
col:        db 0    ; current row number
row:        db 0    ; current column number
buffer: 	dw 0

; to print asteric
; DI == position

printasterick:
push    ax
push    es

mov     ax, 0xb800
mov     es, ax          ; points to video memory

push ax
mov ax, [buffer]
mov word[es:di], ax
pop ax

cmp     byte [col], 0
JNE     nextCmp

cmp     byte [row], 0
JNE      checkUp
mov     byte [isLeft], 1
mov     byte [isRight], 0
mov     byte [isTop], 0
mov     byte [isBottom], 0
jmp     update

checkUp:
cmp     byte [row], 24
JNE     nextCmp
mov     byte [isLeft], 0
mov     byte [isRight], 0
mov     byte [isTop], 1
mov     byte [isBottom], 0
jmp     update

nextCmp:
cmp     byte [col], 158
JNE     update

cmp     byte [row], 0
JNE     checkRight
mov     byte [isLeft], 0
mov     byte [isRight], 0
mov     byte [isTop], 0
mov     byte [isBottom], 1
jmp     update

Right:

cmp     byte [row], 24
jne     update
mov     byte [isLeft], 0
mov     byte [isRight], 1
mov     byte [isTop], 0
mov     byte [isBottom], 0
jmp     update

update:
cmp     byte [isLeft], 1
jne     RightFlag
add     di, 2
add     byte [col], 2
jmp     printScreen

RightFlag:
cmp     byte [isRight], 1
jne     UpFlag
sub     di, 2
sub     byte [col], 2
jmp     printScreen

UpFlag:
cmp     byte [isTop], 1
jne     DownFlag
sub     di, 160
sub     byte [row], 1
jmp     printScreen

DownFlag:
cmp     byte [isBottom], 1
jne     printScreen
add     di, 160
add     byte [row], 1
jmp     printScreen


printScreen:

mov     ah, 0x07
mov     al, '*'

push dx
mov dx, [es:di]
mov [buffer], dx
pop dx

mov     word [es: di], ax

pop es
pop ax
ret



; timer routine
timer:
push    ax

inc     word [cs: ticks]
cmp     word [cs: ticks], 18
jne     TimerExit

inc     word [cs: seconds]
mov     word [cs: ticks], 0
CALL    printasterick

TimerExit:
mov     al, 0x20
out     0x20, al
pop     ax
iret
    

start:
mov     di, 0
xor     ax, ax
mov     es, ax

cli
mov     word [es: 8*4], timer
mov     [es: 8*4+2], cs
sti

mov     dx, start
add     dx, 15
mov     cl, 4
shr     dx, cl

mov     ax, 0x3100
int     0x21