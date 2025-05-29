use16
org 7C00h
jmp set_delay

x_delay dw 300
y_delay dw 15000

;start
set_delay:
    mov ah, 00h
    mov al, 03h
    int 10h

    mov ah, 0eh
    mov al, 'T'
    int 10h

    mov al, '-'
    int 10h

    mov al, 'm'
    int 10h

    mov al, 'o'
    int 10h

    mov al, 'd'
    int 10h

    mov al, 'e'
    int 10h

    mov al, ' '
    int 10h

    mov al, 'A'
    int 10h

    mov al, 'B'
    int 10h

    mov al, 'C'
    int 10h

    mov al, 'D'
    int 10h

    mov al, 'F'
    int 10h

keyboard_loop:
    mov ah, 00h
    int 16h
    cmp al, 'a'
    jz ifA

    cmp al, 'b'
    jz ifB

    cmp al, 'c'
    jz ifC

    cmp al, 'd'
    jz ifD

    cmp al, 'f'
    jz ifF

    jmp keyboard_loop

ifA:
    mov [x_delay], 100
    mov [y_delay], 10000
    jmp start

ifB:
    mov [x_delay], 150
    mov [y_delay], 15000
    jmp start

ifC:
    mov [x_delay], 200
    mov [y_delay], 20000
    jmp start

ifD:
    mov [x_delay], 250
    mov [y_delay], 25000
    jmp start

ifF:
    mov [x_delay], 350
    mov [y_delay], 35000
    jmp start

start:
    mov ah, 00h
    mov al, 03h
    int 10h

    mov dl, 40
    mov dh, 12

    mov cl, 1
    mov ch, 1

;main
main:
    mov ah, 02h
    int 10h

    mov ah, 0eh
    mov al, ' '
    int 10h

    add dl, cl
    add dh, ch

    mov ah, 02h
    int 10h

    mov ah, 0eh
    mov al, 0feh
    int 10h

    cmp dl, 79
    jae if80x

    cmp dl, 1
    jle if0x

    cmp dh, 24
    jae if25y

    cmp dh, 1
    jle if0y

    push cx

    mov cx, [x_delay]

;delay
x_for:
    mov ax, [y_delay]
y_for:
    nop
    dec ax
    jnz y_for
    loop x_for

    pop cx
    jmp main

;ifs
if80x:
    mov cl, -1
    jmp main

if0x:
    mov cl, 1
    jmp main

if25y:
    mov ch, -1
    jmp main

if0y:
    mov ch, 1
    jmp main

jmp $

times(512-2-($-07C00h)) db 0
db 055h, 0AAh