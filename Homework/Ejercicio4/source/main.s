/******************************************************************************
*	main.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the input01 operating system, that 
*	displays keyboard inputs as text on screen.
*
*	main.s contains the main operating system, and IVT code.
******************************************************************************/

/*
* .globl is a directive to our assembler, that tells it to export this symbol
* to the elf file. Convention dictates that the symbol _start is used for the 
* entry point, so this all has the net effect of setting the entry point here.
* Ultimately, this is useless as the elf itself is not used in the final 
* result, and so the entry point really doesn't matter, but it aids clarity,
* allows simulators to run the elf, and also stops us getting a linker warning
* about having no entry point. 
*/
.section .init
.globl _start
_start:

/*
* Branch to the actual main code.
*/
b main

/*
* This command tells the assembler to put this code with the rest.
*/
.section .text

/*
* main is what we shall call our main operating system method. It never 
* returns, and takes no parameters.
* C++ Signature: void main(void)
*/
main:

/*
* Set the stack point to 0x8000.
*/
	mov sp,#0x8000

/* 
* Setup the screen.
*/

	mov r0,#1024
	mov r1,#768
	mov r2,#16
	bl InitialiseFrameBuffer

/* 
* Check for a failed frame buffer.
*/
	teq r0,#0
	bne noError$
		
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

	mov r0,#16
	mov r1,#0
	bl SetGpio

	error$:
		b error$

	noError$:

	fbInfoAddr .req r4
	mov fbInfoAddr,r0

/*
* Let our drawing method know where we are drawing to.
*/
	bl SetGraphicsAddress

	bl UsbInitialise

	mov r4,#0			/*x*/
	mov r5,#0			/*y*/
loopContinue$:
	/*27 ESC*/
	/*t TAB*/
	/*n ENTER*/
	/*242 F2*/
	/*241 F1*/
	bl KeyboardUpdate
	bl KeyboardGetChar
	
	teq r0,#0
	beq loopContinue$
	
	/*****************PROGRAMACION PARA ENTER************************/
	teq r0,#'\n'
	moveq r4,#0							@movemos cero para regresar x al inicio
	addeq r5,r5,#1						@le sumamos uno a y para que baje
	beq loopContinue$					@repetimos el ciclo
	/****************************************************************/
	/*****************PROGRAMACION PARA ESC************************/
	teq r0,#'\q'
	beq exit$
	/****************************************************************/
	/*****************PROGRAMACION PARA F2************************/
	teq r0,#'\e'
	addeq r4,r4,#10						@le sumamos 10 a x para que se mueva diez veces
	beq loopContinue$					@repetimos el ciclo
	/****************************************************************/
	/*****************PROGRAMACION PARA TAB************************/
	teq r0,#'\t'
	beq tab$
	/****************************************************************/
	/*****************PROGRAMACION PARA F1************************/
	teq r0,#'\w'
	beq charmander$
	/****************************************************************/
	
	
	mov r1,r4			/*x*/
	mov r2,r5			/**y/
	bl DrawCharacter
	add r4,r0
	
	/*********************Procesos para terminar*********************/
	teq r4,#1024
	addeq r5,r1
	moveq r4,#0
	teqeq r5,#768
	moveq r5,#0
	/****************************************************************/
	b loopContinue$
	
	 charmander$:
        ldr r0,=charmander1					@cargamos a charmander	
		ldr r1,=charmander1Length			@cargamos su length
		ldr r1,[r1]							@lo cargamos a memoria
		mov r2,#0							@posicion inicial en x
		mov r3,#0							@posicion inicial en y
		bl DrawString						@mandamos a dibujar
		ldr r0,=20000						@esperamos dos segundos
		bl Wait								@llamamos a subrutina para esperar
		b loopContinue$						@repetimos el ciclo
		
	tab$:
        mov r0, #0b0000000000000000 		@cero para negro
		add r0,r0, #0b0000000000011111 		@le sumamos cierto numero para que cambie de colores
		bl SetForeColour					@seteamos el color en negro
		b loopContinue$						@repetimos el ciclo
		
	exit$:
		mov  r0, #0b0000000000000000 		@cero para negro
		bl  SetForeColour					@seteamos el color en negro
		mov  r0,#0							@Esquina superior del cuadrado
		mov  r1,#768						@Esquina inferior del cuadrado
		mov  r2,#1024						@ancho del cuadrado
		mov  r3,#1							@para que este lleno el cuadrado
		bl  DrawCuadrado					@llamamos a subrutina para dibujar cuadrado
		bl  KeyboardUpdate					@llamamos a subrutina de teclado
		bl  KeyboardGetChar					@llamamos a subrutina de teclado
		mov  r4,#0							@mandamos a x un 0 para mandarlo al inicio
		mov  r5,#0							@mandamos a y un 0 para mandarlo al inicio
		b  loopContinue$					@repetimos el ciclo
		
		

