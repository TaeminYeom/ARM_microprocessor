
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

RCGC2				.equ	0x108
GPIODR8R			.equ	0x508

GPIODATA			.equ	0x000
EN3					.equ	0x10C
GPIOIM				.equ	0x410
GPIOICR				.equ	0x41C

SW_UP				.equ	0x1E
SW_DOWN				.equ	0x1D
SW_LEFT				.equ	0x1B
SW_RIGHT			.equ	0x17
SW_SEL				.equ	0x0F
SW_NONE				.equ	0x1F


RCGCUART			.equ	0x618

;--------------------------------------------------
	.global __stack
__stack:


             .text                           ; Program Start
             .global RESET                   ; Define entry point
             .align	4
			 .sect ".text"

			 .retain
			 .retainrefs

;------------------------------------------------
;			switch initializition
;------------------------------------------------

Switch_Init:
		mov r0, #GPIO_BASE	;RCGC UART
		mov r1, #0xFE000
		add r0, r0, r1

		mov r1, #RCGCUART
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, #1
		str r0, [r1]
		nop
		nop


		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x800
		orr r0, r0, #1
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;RCGC2
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGC2
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x41
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

		mov r0, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #4	;PG2 output으로 설정
		str r0, [r1]



		mov r0, #GPIO_BASE	;HBCTL : High-Performance Bus Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #GPIOHBCTL
		add r1, r1, r0

		mov r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #4
		str r0, [r1]

		mov r0, #GPIO_BASE	;AFSEL Port A
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, #3
		str r0, [r1]

		mov r0, #GPIO_BASE	;DR8R
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODR8R
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #4
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x4
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN port A
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #3
		str r0, [r1]



		mov r0, #GPIO_BASE	;PUR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPUR
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

		mov r0, #GPIO_BASE	;AMSEL port A
		mov r1, #0x4000
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

		mov r0, #GPIO_BASE	;PCTL  port A
		mov r1, #0x4000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #3;	;??????????????????????????????????????????
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


		mov r0, #GPIO_BASE
		mov r6, #0x26000
		add r6, r6, r0
		mov r0, #0x10
		add r6, r6, r0	;r6에 GP2 주소 저장

		mov r4, #0

UART_Init:
		mov r0, #GPIO_BASE	;UART Disable
		mov r1, #0xC000
		add r0, r0, r1

		mov r1, #0x030
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, #1
		str r0, [r1]

		mov r0, #GPIO_BASE	;UARTIBRD
		mov r1, #0xC000
		add r0, r0, r1

		mov r1, #0x024
		add r1, r1, r0

		mov r0, #8
		str r0, [r1]

		mov r0, #GPIO_BASE	;UARTFBRD
		mov r1, #0xC000
		add r0, r0, r1

		mov r1, #0x028
		add r1, r1, r0

		mov r0, #44
		str r0, [r1]

		mov r0, #GPIO_BASE	;UARTLCRH
		mov r1, #0xC000
		add r0, r0, r1

		mov r1, #0x02C
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, #0x60
		bic r0, #0x0A
		str r0, [r1]

		mov r0, #GPIO_BASE	;UART Enable
		mov r1, #0xC000
		add r0, r0, r1

		mov r1, #0x030
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, #1
		str r0, [r1]


		mov r3, #76	;'L'
		BL Print_Char_call

		mov r3, #69	;'E'
		BL Print_Char_call

		mov r3, #68	;'D'
		BL Print_Char_call

		mov r3, #32	;' '
		BL Print_Char_call

		mov r3, #77	;'M'
		BL Print_Char_call

		mov r3, #79	;'O'
		BL Print_Char_call

		mov r3, #68	;'D'
		BL Print_Char_call

		mov r3, #69	;'E'
		BL Print_Char_call

		mov r3, #13 ;'\n'
		BL Print_Char_call

		mov r3, #10 ;'\n'
		BL Print_Char_call

		mov r7, #0


Switch_Input:
		mov r5, #GPIO_BASE
		mov r1, #0x63000
		add r1, r1, r5
		mov r5, #0x7c
		add r1, r1, r5

		ldr r5, [r1]


		cmp r5, #SW_NONE
		ITEET EQ
		movEQ r7, #0
		cmpNE r7, #1
		MOVNE r7, #1
		BEQ Switch_Input


DELAY:	MOVW r3,#0xffff

_DELAY_LOOP:
		CBZ r3,JUDGE		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP


JUDGE:
		mov r0, #0

		mov r2, #0x1F
		and r2, r2, r5

		cmp r2, #SW_UP
		BEQ ON

		cmp r2, #SW_DOWN
		BEQ OFF

		cmp r2, #SW_LEFT
		ITT EQ
		MOVEQ r2, #0x04
		BEQ SLOW

		cmp r2, #SW_RIGHT
		ITT EQ
		MOVEQ r2, #0x04
		BEQ FAST

		B Switch_Input


ON:
		mov r3, #45 ;'-'
		BL Print_Char_call

		mov r3, #83 ;'S'
		BL Print_Char_call

		mov r3, #87 ;'W'
		BL Print_Char_call

		mov r3, #32 ;' '
		BL Print_Char_call

		mov r3, #65 ;'A'
		BL Print_Char_call

		mov r3, #13 ;'\n'
		BL Print_Char_call

		mov r3, #10 ;'\n'
		BL Print_Char_call

		mov r2, #0x04
		str r2, [r6]

		B Switch_Input

OFF:

		mov r3, #45 ;'-'
		BL Print_Char_call

		mov r3, #83 ;'S'
		BL Print_Char_call

		mov r3, #87 ;'W'
		BL Print_Char_call

		mov r3, #32 ;' '
		BL Print_Char_call

		mov r3, #66 ;'B'
		BL Print_Char_call

		mov r3, #13 ;'\n'
		BL Print_Char_call

		mov r3, #10 ;'\n'
		BL Print_Char_call

		mov r2, #0x00
		str r2, [r6]

		B Switch_Input



SLOW:
		mov r3, #45 ;'-'
		BL Print_Char_call

		mov r3, #83 ;'S'
		BL Print_Char_call

		mov r3, #87 ;'W'
		BL Print_Char_call

		mov r3, #32 ;' '
		BL Print_Char_call

		mov r3, #67 ;'C'
		BL Print_Char_call

		mov r3, #13 ;'\n'
		BL Print_Char_call

		mov r3, #10 ;'\n'
		BL Print_Char_call

SLOW2:
		str r2, [r6]
		MOV r3, #0xffff

		ADD r3, r3, r3
		ADD r3, r3, r3
		ADD r3, r3, r3

		cmp r4, #10
		ITT EQ
		MOVEQ r4, #0
		BEQ Switch_Input

		ADD r4, #1
		EOR r2, #0xFF


SLOW_DELAY_LOOP:
		cmp r3, #0
		BEQ SLOW2
		sub r3,r3,#1
		B SLOW_DELAY_LOOP


FAST:

		mov r3, #45 ;'-'
		BL Print_Char_call

		mov r3, #83 ;'S'
		BL Print_Char_call

		mov r3, #87 ;'W'
		BL Print_Char_call

		mov r3, #32 ;' '
		BL Print_Char_call

		mov r3, #68 ;'D'
		BL Print_Char_call

		mov r3, #13 ;'\n'
		BL Print_Char_call

		mov r3, #10 ;'\n'
		BL Print_Char_call

FAST2:

		str r2, [r6]
		MOV r3, #0xffff


		ADD r3, r3, r3
		ADD r3, r3, r3

		cmp r4, #10
		ITT EQ
		MOVEQ r4, #0
		BEQ Switch_Input

		ADD r4, #1
		EOR r2, #0xFF


FAST_DELAY_LOOP:
		cmp r3, #0
		BEQ FAST2
		sub r3,r3,#1
		B FAST_DELAY_LOOP

Print_Char_call:
		STMFD sp!, {lr}

Print_Char:		;입력할 문자 r3에 있음

		mov r0, #GPIO_BASE
		mov r1, #0xC000
		add r0, r0, r1
		mov r2, r0
		add r0, r0, #0x018

		ldr r1, [r0]	;UARFDR 불러오기
		and r1, r1, #0x20
		cmp r1, #0x20

		IT EQ
		BEQ Print_Char

		str r3, [r2]	;UARTDR에 보낼 문자 저장

		LDMFD sp!, {pc}
;		B Switch_Input



