/******************************************************************************
*	main.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the screen02 operating system, that 
*	renders pseudo random lines to the screen.
*
*	main.s contains the main operating system, and IVT code.
******************************************************************************/

/*
* .globl is a directive to our assembler, that tells it to export this symbol
* to the elf file. Convention dictates that the symbol _start is used for the 
* entry point, so this all has the net effect of setting the entry point here.
* Ultimately, this is useless as the elf itself is not used in the final 
* result, and so the entry point really doesnt matter, but it aids clarity,
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

/* NEW
* Let our drawing method know where we are drawing to.
*/
	bl SetGraphicsAddress
	
	render:

	colour .req r10


	/*Vamos a pintar de negro una parte del fondo*/
	mov colour, #0b0000000000000000
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion de la esquina superior izquierda de este rectangulo es la (0,0)*/
	ldr r0, =0
	ldr r1, =0
	ldr r2, =1024 				/*Establecemos un ancho de 1024*/
	ldr r3, =650 					/*Establecemos una altura de 650*/
	push {lr}
	mov r4, #1
	push {r4}
	bl DrawRectangulo 				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}


	/*Vamos a pintar de verde la otra parte del fondo*/
	mov colour, #0b0000000000000000
	add colour, #0b0000011111100000
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion de la esquina superior izquierda de este rectangulo es la (0,451)*/
	ldr r0, =0
	ldr r1, =651
	ldr r2, =1024 				/*Establecemos un ancho de 1024*/
	ldr r3, =119 					/*Establecemos una altura de 319*/
	push {lr}
	mov r4, #1
	push {r4}
	bl DrawRectangulo 				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}


	/*Vamos a pintar de blanco el circulo que simula la luna*/
	mov colour, #0b0000011111100000
	add colour, #0b0000000000011111
	add colour, #0b1111100000000000
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion del centro de este circulo es en el centro de la pantalla.*/
	ldr r0, =900
	ldr r1, =100
	mov r2, #50 				/*Establecemos un radio de 200 pixeles*/
	mov r3, #1 					/*Mandamos 0 a R3 porque queremos que sea relleno*/
	bl DrawCircle 				/*LLamamos a la subrutina para dibujar el circulo.*/

	
	mov colour, #0b0000000000000000 		/*"Vaciamos" lo que hay en colour para luego volver a pintar*/
	add colour, #0b0000000000000111 		
	add colour, #0b1111000000000000 		
	add colour, #0b0000111110000000 		
	mov r0, colour 				
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion de la esquina sup-izq. este rectangulo es en la posicion (200,475).*/
	ldr r0, =200
	ldr r1, =475
	ldr r2, =75 					/*Establecemos un ancho de 75*/
	ldr r3, =200 					/*Establecemos una altura de 200*/
	push {lr}
	mov r4, #1
	push {r4}
	bl DrawRectangulo 				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}
	
	
	/*DIBUJAMOS LOS DOS TRIANGULOS*/
	
	
	mov colour, #0b0000000000000000 		/*"Vaciamos" lo que hay en colour para luego volver a pintar*/
	add colour, #0b0000000000000111 		
	add colour, #0b1111000000000000 		
	add colour, #0b0000111110000000 		
	mov r0, colour 				
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion del triangulo inferior sera de  (317,371). Con un ancho de 314 pixeles y un alto de 282*/
	ldr r0, =297					/*posicion inicial en x*/
	ldr r1, =503					/*posicion inicial en y*/
	ldr r2, =352 					/*Establecemos un ancho de 352*/
	ldr r3, =256 					/*Establecemos una altura de 256*/
	push {lr}
	mov r4, #1						/*condicional para relleno*/
	push {r4}
	bl DrawTriangulo				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}
	
	/*La posicion del triangulo superior sera de  (317,371). Con un ancho de 314 pixeles y un alto de 282*/
	ldr r0, =317					/*posicion inicial en x*/
	ldr r1, =371					/*posicion inicial en y*/
	ldr r2, =314 					/*Establecemos un ancho de 314*/
	ldr r3, =282 					/*Establecemos una altura de 282*/
	push {lr}
	mov r4, #1						/*condicional para relleno*/
	push {r4}
	bl DrawTriangulo				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}

	/*Generamos un pseudo numero aleatorio para la posicion en x y para la posicion en y para pintar las estrellas que son rombos*/
	
	lastRandom .req r7
	x .req r5
	y .req r6
	mov lastRandom,#0			@inicializamos el numero
	mov r0,lastRandom
	bl Random					@llamamos a la subturina para que genere un numero ramdon en x
	mov x,r0					@almacenamos ese valor
	bl Random					@llamamos a la subturina para que genere un numero ramdon en y
	mov y,r0					@almacenamos ese valor
	mov lastRandom,r0
	/*CODIGO PARA GENERACION DE ROMBOS*/
	.unreq x
	.unreq y
	.unreq lastRandom  	
	
	
	.unreq colour
	
	
