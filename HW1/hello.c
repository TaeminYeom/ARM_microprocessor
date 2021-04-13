//*****************************************************************************
//
// hello.c - Simple hello world example.
//
// Copyright (c) 2011-2013 Texas Instruments Incorporated.  All rights reserved.
// Software License Agreement
//
// Texas Instruments (TI) is supplying this software for use solely and
// exclusively on TI's microcontroller products. The software is owned by
// TI and/or its suppliers, and is protected under applicable copyright
// laws. You may not combine this software with "viral" open-source
// software in order to form a larger program.
//
// THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
// NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
// NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. TI SHALL NOT, UNDER ANY
// CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
// DAMAGES, FOR ANY REASON WHATSOEVER.
//
// This is part of revision 1.1 of the DK-TM4C123G Firmware Package.
//
//*****************************************************************************

#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_memmap.h"
#include "driverlib/fpu.h"
#include "driverlib/sysctl.h"
#include "driverlib/rom.h"
#include "driverlib/pin_map.h"
#include "driverlib/uart.h"
#include "grlib/grlib.h"
#include "drivers/cfal96x64x16.h"
#include "utils/uartstdio.h"
#include "driverlib/gpio.h"



extern unsigned int num_1();
extern unsigned int num_3();
extern unsigned int Switch_Input();
extern unsigned int Switch_Init();
extern int cursor();
extern int init();
//extern void ConfigureUART(void);
//*****************************************************************************
//
//! \addtogroup example_list
//! <h1>Hello World (hello)</h1>
//!
//! A very simple ``hello world'' example.  It simply displays ``Hello World!''
//! on the display and is a starting point for more complicated applications.
//! This example uses calls to the TivaWare Graphics Library graphics
//! primitives functions to update the display.  For a similar example using
//! widgets, please see ``hello_widget''.
//
//*****************************************************************************

//*****************************************************************************
//
// The error routine that is called if the driver library encounters an error.
//
//*****************************************************************************
#ifdef DEBUG
void
__error__(char *pcFilename, uint32_t ui32Line)
{
}
#endif

//*****************************************************************************
//
// Configure the UART and its pins.  This must be called before UARTprintf().
//
//*****************************************************************************
void
ConfigureUART(void)
{
    //
    // Enable the GPIO Peripheral used by the UART.
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);

    //
    // Enable UART0
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);

    //
    // Configure GPIO Pins for UART mode.
    //
    ROM_GPIOPinConfigure(GPIO_PA0_U0RX);
    ROM_GPIOPinConfigure(GPIO_PA1_U0TX);
    ROM_GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 | GPIO_PIN_1);

    //
    // Use the internal 16MHz oscillator as the UART clock source.
    //
    UARTClockSourceSet(UART0_BASE, UART_CLOCK_PIOSC);

    //
    // Initialize the UART for console I/O.
    //
    UARTStdioConfig(0, 115200, 16000000);
}



//*****************************************************************************
//
// Print "Hello World!" to the display.
//
//*****************************************************************************

void fill(const tContext *sContext, int i, int n)
{
	int y1, y2;
	int x;
	int j, k;

	n-='0';
	if(!n)
		x=6;
	else
		x=6+n*9;

	switch(i)
	{
		case 0:
			y1=6;
			y2=13;
			break;
		case 1:
			y1=17;
			y2=24;
			break;
		case 2:
			y1=28;
			y2=35;
			break;
		case 3:
			y1=39;
			y2=46;
			break;
	}
	for(j=y1; j<=y2; j++)
		GrLineDrawH(sContext, 6, x, j);
}

int
main(void)
{
	//led();
    tContext sContext;
    ROM_FPULazyStackingEnable();
    ROM_SysCtlClockSet(SYSCTL_SYSDIV_4 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ |
                       SYSCTL_OSC_MAIN);
    ConfigureUART();

    UARTprintf("Hello, world!\n");

    CFAL96x64x16Init();

    GrContextInit(&sContext, &g_sCFAL96x64x16);

    GrContextForegroundSet(&sContext, ClrWhite);

    GrContextFontSet(&sContext, g_psFontCm12);

//*****************************************************************************************
//*****************************************************************************************

    	char n[4] = {'0', '0', '0', '0'};
    	int num[2] = {'0', '0'};

        tRectangle tRect1;
        tRect1.i16XMin = 0;
        tRect1.i16XMax = 95;
        tRect1.i16YMin = 0;
        tRect1.i16YMax = 61;


        tRectangle Rect[4];
        Rect[0].i16XMin = 5;
        Rect[0].i16XMax = 90;
        Rect[0].i16YMin = 5;
        Rect[0].i16YMax = 14;

        Rect[1].i16XMin = 5;
        Rect[1].i16XMax = 90;
        Rect[1].i16YMin = 16;
        Rect[1].i16YMax = 25;

        Rect[2].i16XMin = 5;
        Rect[2].i16XMax = 90;
        Rect[2].i16YMin = 27;
        Rect[2].i16YMax = 36;


        Rect[3].i16XMin = 5;
        Rect[3].i16XMax = 90;
        Rect[3].i16YMin = 38;
        Rect[3].i16YMax = 47;


        Switch_Init();
        int i=0;

while(1){


	  while(!Switch_Input());

	  while(Switch_Input());

//	  Switch_Input();
	  i += cursor();

	  if(i<0)
		  i=0;
	  else if(i>3)
		  i=3;
	  n[i] += num_1();
//	  num[0] = num_1();
//	  n[i] += num[0];
	  if(n[i]<'0')
		  n[i]+=10;
	  else if(n[i]>'9')
		  n[i]-=10;
	  if(init())
	  {
		  n[0]='0';
		  n[1]='0';
		  n[2]='0';
		  n[3]='0';
		  i=0;
	  }


      CFAL96x64x16Init();
	  GrRectDraw(&sContext, &tRect1);
	  GrRectDraw(&sContext, &Rect[0]);
	  GrRectDraw(&sContext, &Rect[1]);
	  GrRectDraw(&sContext, &Rect[2]);
	  GrRectDraw(&sContext, &Rect[3]);
      GrStringDrawCentered(&sContext, n, 4, GrContextDpyWidthGet(&sContext) / 2, 52, 0);

      fill(&sContext, 0, n[0]);
      fill(&sContext, 1, n[1]);
      fill(&sContext, 2, n[2]);
      fill(&sContext, 3, n[3]);




}	//end while
//*****************************************************************************************
//*****************************************************************************************
//    GrFlush(&sContext);


}		//end main

