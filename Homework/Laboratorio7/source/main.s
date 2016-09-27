/******************************************************************************
*	main.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the screen03 operating system, that 
*	renders text to the screen
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
	
	
x0 .req r4 					/*Nombramos x0 a r4 para manejar el movimiento de la figura*/
mov x0,#0					/*Movemos un 0 para inicializar el contador*/


loop$:
	colour .req r10
	/*Pintaremos a charmander1 de color blanco*/
	mov colour, #0b0000011111100000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=charmander1				/*Cargamos a charmander en r0*/
	ldr r1,=charmander1Length		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,x0						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=20000										@esperamos dos segundos
	bl Wait									@llamamos a subrutina para esperar
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000000000000000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=charmander1				/*Cargamos a charmander en r0*/
	ldr r1,=charmander1Length		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,x0						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=20000										@esperamos dos segundos
	bl Wait		
	add x0,x0,#20
	
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000011111100000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=charmander2				/*Cargamos a charmander en r0*/
	ldr r1,=charmander2Length		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,x0						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=20000										@esperamos dos segundos
	bl Wait		
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000000000000000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=charmander2				/*Cargamos a charmander en r0*/
	ldr r1,=charmander2Length		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,x0						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=20000										@esperamos dos segundos
	bl Wait		
	
	cmp x0,#1024	@compara si la posicion con el largo de la pantalla
	
	ble loop$		@si es menor lo repite el ciclo
	ldr r0,=1000000							@esperamos un segundo
	bl Wait									@llamamos a subrutina para esperar
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000011111100000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=JuanLuis				/*Cargamos a charmander en r0*/
	ldr r1,=JuanLuisLength		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,#219						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#251						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=2000000							@esperamos dos segundos
	bl Wait		
	
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000011111100000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=MiguelGodoy				/*Cargamos a charmander en r0*/
	ldr r1,=MiguelGodoyLength		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	ldr r2,=313						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	ldr r3,=413						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=2000000							@esperamos dos segundos
	bl Wait		
	
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000000000000000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=JuanLuis				/*Cargamos a charmander en r0*/
	ldr r1,=JuanLuisLength		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,#219						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#251						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=2000000							@esperamos dos segundos
	bl Wait		
	
	
	/*Pintaremos a charmander1 de color negro*/
	mov colour, #0b0000000000000000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	/*Dibujar Charmander1*/		
	ldr r0,=MiguelGodoy				/*Cargamos a charmander en r0*/
	ldr r1,=MiguelGodoyLength		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	ldr r2,=313						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	ldr r3,=413						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString

	ldr r0,=2000000							@esperamos dos segundos
	bl Wait		
	mov x0,#0
b loop$
	
	
	
