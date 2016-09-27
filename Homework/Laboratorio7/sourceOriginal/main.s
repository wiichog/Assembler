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


	/*Vamos a pintar de negro-azulado una parte del fondo*/
	mov colour, #0b0000000000000001
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
	bl DrawRectangulo 				/*LLamamos a la subrutina para dibujar el rectangulo.*/
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
	bl DrawRectangulo 				/*LLamamos a la subrutina para dibujar el rectangulo.*/
	pop {lr}


	/*Vamos a pintar de blanco el circulo que simula la luna*/
	mov colour, #0b0000011111100000
	add colour, #0b0000000000011111
	add colour, #0b1111100000000000
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion del centro de este circulo es en la esquina sup-derecha del a pantalla.*/
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

	/*La posicion de la esquina sup-izq. este rectangulo (el tronco del arbol) es en la posicion (425,475).*/
	ldr r0, =425
	ldr r1, =475
	ldr r2, =75 					/*Establecemos un ancho de 75*/
	ldr r3, =200 					/*Establecemos una altura de 200*/
	push {lr}
	mov r4, #1
	push {r4}
	bl DrawRectangulo 				/*LLamamos a la subrutina para dibujar el tronco.*/
	pop {lr}

	/******************************REGALOS******************************/
	
	/*Regalo 1*/
	mov colour, #0b0000000000000000 		/*"Vaciamos" lo que hay en colour para luego volver a pintar*/
	add colour, #0b0000000000000111 		/*Pintamos de azul*/			
	mov r0, colour 				
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion de la esquina sup-izq. este cuadrado (regalo 1) es en la posicion (380,625).*/
	ldr r0, =380
	ldr r1, =625
	ldr r2, =75 					/*Establecemos un ancho de 75*/
	ldr r3, =1 	 					/*Es un cuadrado relleno*/
	bl DrawCuadrado				/*LLamamos a la subrutina para dibujar el cuadrado.*/


	/*Regalo 2*/
	mov colour, #0b0000000000000000 		/*"Vaciamos" lo que hay en colour para luego volver a pintar*/
	add colour, #0b0111100000000000 		/*Pintamos de rojo*/			
	mov r0, colour 				
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion de la esquina sup-izq. este cuadrado (regalo 2) es en la posicion (465,625).*/
	ldr r0, =465
	ldr r1, =625
	ldr r2, =75 					/*Establecemos un ancho de 75*/
	ldr r3, =1 	 					/*Es un cuadrado relleno*/
	bl DrawCuadrado				/*LLamamos a la subrutina para dibujar el cuadrado.*/
	
	/*DIBUJAMOS LOS DOS TRIANGULOS*/
	
	
	mov colour, #0b0000000000000000 		/*"Vaciamos" lo que hay en colour para luego volver a pintar*/
	add colour, #0b0000011111000000 			
	mov r0, colour 				
	/*Seteamos el color*/
	bl SetForeColour

	/*La posicion del triangulo inferior sera de  (317,371). Con un ancho de 314 pixeles y un alto de 282*/
	/*TRIANGULO DE ABAJO*/
	ldr r0, =307					/*posicion inicial en x*/
	ldr r1, =507					/*posicion inicial en y*/
	ldr r2, =918 					/*Para saber el ancho total sumamos la posicion inicial mas la posicion final*/
	ldr r3, =253 					/*Establecemos una altura de 252*/
	push {lr}
	mov r4, #1						/*condicional para relleno*/
	push {r4}
	bl DrawTriangulo				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}
	
	/*La posicion del triangulo superior sera de  (317,371). Con un ancho de 314 pixeles y un alto de 282*/
	/*TRIANGULO DE ARRIBA*/
	ldr r0, =317					/*posicion inicial en x*/
	ldr r1, =371					/*posicion inicial en y*/
	ldr r2, =914 					/*Establecemos un ancho de 914*/
	ldr r3, =115 					/*Establecemos una altura de 258*/
	push {lr}
	mov r4, #1						/*condicional para relleno*/
	push {r4}
	bl DrawTriangulo				/*LLamamos a la subrutina para dibujar el circulo.*/
	pop {lr}


	/******************************ROMBOS******************************/

	mov colour, #0b0000000000000000 		/*"Vaciamos" lo que hay en colour para luego volver a pintar*/
	add colour, #0b0000011111000000 		/*Pintamos de blanco*/
	add colour, #0b0000000000011111
	add colour, #0b1111100000000000
	mov r0, colour 				
	/*Seteamos el color*/
	bl SetForeColour

	/*Rombo 1*/
	ldr r0, =200
	ldr r1, =150
	ldr r2, =25
	ldr r3, =1
	bl DrawRombo

	/*Rombo 2*/
	ldr r0, =787
	ldr r1, =233
	ldr r2, =25
	ldr r3, =1
	bl DrawRombo

	/*Rombo 3*/
	ldr r0, =57
	ldr r1, =375
	ldr r2, =25
	ldr r3, =1
	bl DrawRombo


	
	.unreq colour
	
	
