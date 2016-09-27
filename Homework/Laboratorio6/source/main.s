/*****************************************************************************
*	main.s
*	Dibuja a Mario Bros. en la esquina superior izquierda
*
*	Por: Juana Rivera
*   Creado: 12/9/2013
*   Ultima modificacion: 09/09/2014
******************************************************************************/



.section .init
.globl _start
_start:

b main

.section .text
main:
	mov sp,#0x8000


	//Inicializacion de la pantalla con resolucion 1024x768.
	mov r0,#1024
	mov r1,#768
	mov r2,#16
	bl InitialiseFrameBuffer

	//Manejo del error al no poder reservar el frame buffer
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

	//Pantalla Inicializada correctamente
	noError$:
	
	//fbInfoAddr es la direccion a la tabla con la informacion de la pantalla.
	fbInfoAddr .req r4
	mov fbInfoAddr,r0

	//Inicializacion de Registro
	ldr r0,#0
	ldr r1,#0
	ldr r2,=mecoboyHeight
	ldr r3,=mecoboyWidth
	ldr r4,=mecoboy
	ldr r5,[fbInfoAddr,#32]
	push {r4}
	push {r5}

	//Ciclo principal, se repite infinitamente.
	render$:
		bl drawimage
	b render$

	.unreq fbAddr
	.unreq colour
	.unreq y
	.unreq addrPixel
	.unreq x
	.unreq countByte

