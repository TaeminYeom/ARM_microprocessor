
	.cdecls C, LIST, "Compiler.h"
;------------------------------------------------
;		.data
;------------------------------------------------
GPIO_BASE			.equ	0x40000000
NVIC_BASE			.equ	0xe0000000
RCGCGPIO			.equ	0x608
GPIOHBCTL			.equ	0x06C
GPIODIR				.equ	0x400
GPIOAFSEL			.equ	0x420
GPIOPUR				.equ	0x510
GPIODEN				.equ	0x51C
GPIOAMSEL			.equ	0x528
GPIOPCTL			.equ	0x52C
GPIOLOCK			.equ	0x520
GPIOCR				.equ	0x524

GPIODATA			.equ	0x000
EN3					.equ	0x10C
GPIOIM				.equ	0x410
GPIOICR				.equ	0x41C

SW_UP				.equ	0x1E
SW_DOWN				.equ	0x1D
SW_LEFT				.equ	0x1B
SW_RIGHT			.equ	0x17
SW_SEL				.equ	0x0F
;--------------------------------------------------
             .text                           ; Program Start
             .global RESET                   ; Define entry point
             .align	4
			 .sect ".text"

             .global Switch_Init
             .global Switch_Input
             .global cursor
             .global init
			 .global num_1
			 .global num_3

;------------------------------------------------
;			switch initializition
;------------------------------------------------

Switch_Init:
		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;HBCTL : High-Performance Bus Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #GPIOHBCTL
		add r1, r1, r0

		mov r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;DIR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;PUR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPUR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AMSEL : Analog Mode Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0

		mov r0, #0
		str r0, [r1]

		mov r0, #GPIO_BASE	;PCTL : Port Control
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f;#0x000f000f
		str r0, [r1]

		mov r0, #GPIO_BASE	;LOCK
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOLOCK
		add r1, r1, r0

		mov r0, #GPIO_BASE
		mov r2, #0xc400000
		add r2, r2, r0
		mov r0, #0xf4000
		add r2, r2, r0
		mov r0, #0x34b
		add r2, r2, r0

		ldr r0, [r1]
		orr r0, r0, r2
		str r0, [r1]

		mov r0, #GPIO_BASE	;CR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOCR
		add r1, r1, r0

		ldr r0, [r1]
		mov r2, #0x00000000
		bic r0, r0, r2
		str r0, [r1]

Switch_Input:

		mov r5, #GPIO_BASE
		mov r1, #0x63000
		add r1, r1, r5
		mov r5, #0x7c
		add r1, r1, r5

		ldr r5, [r1]




DELAY:	MOVW r3,#0xffff

_DELAY_LOOP:
		CBZ r3,JUDGE		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP

JUDGE:
		mov r0, #0

		mov r2, #0x1F
		and r2, r2, r5

		cmp r2, #0x1F
		BEQ _EXIT

		mov r2, #0x1C
		and r2, r2, r5

		cmp r2, #0x1C
		BEQ _NUMBER

		mov r2, #0x13
		and r2, r2, r5

		cmp r2, #0x13
		BEQ _CURSOR

		mov r2, #0x0F
		and r2, r2, r5

		cmp r2, #0x0F
		BEQ SEL


_NUMBER:
		mov r0, #1
		mov r8, #0

		cmp r5, #SW_UP
		BEQ _up

		cmp r5, #SW_DOWN
		BEQ _down

		mov r1, #0
		b _EXIT

_CURSOR:
		mov r0, #1
		mov r1, #0


		cmp r5, #SW_RIGHT
		BEQ _right

		cmp r5, #SW_LEFT
		BEQ _left

		mov r0, #0
		B _EXIT

SEL:
		mov r0, #1
		cmp r5, #SW_SEL
		BEQ _sel

_up:
		mov r9, #1
		b _EXIT

_down:
		mov r9, #-1
		b _EXIT

_left:
		mov r8, #-1
		b _EXIT

_right:
		mov r8, #1
		b _EXIT

_sel:
		mov r9, #1
		mov r8, #1
		b _EXIT

_EXIT:
		bx lr

cursor:
		mov r0, r8
		bx lr

init:
		and r0, r8, r9
		mov r8, #0
		mov r9, #0
		bx lr


num_1:
		mov r0, r9
		bx lr

num_3:
		mov r0, #'D'
		bx lr

			.retain
			.retainrefs
