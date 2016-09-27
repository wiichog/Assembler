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

	//Ciclo principal, se repite infinitamente.
	render$:
		
		//fbAddr contiene la direccion del frame buffer
		//Se lee la direccion del frame buffer de la tabla Frame Buffer Info
		fbAddr .req r3
		ldr fbAddr,[fbInfoAddr,#32]
		
		colour .req r0
		y .req r1
		
		//Inicializamos el contador 'y' con el alto de la imagen de Mario
		ldr y,=marioHeight
		ldrh y,[y]
		
		addrPixel .req r5
		countByte .req r6
		mov countByte,#0 	//Contador que cuenta la cantidad de bytes del mario dibujados
		
		//Ciclo que dibuja filas
		drawRow$:
			x .req r2
			
			//Inicializamos el contador 'x' con el ancho de la imagen de Mario
			ldr x,=marioWidth
			ldrh x,[x]
			
			drawPixel$:
				ldr addrPixel,=mario				//Obtenemos la direccion de la matriz con los colores de Mario
				ldrh colour,[addrPixel,countByte]	//Leemos dato de matriz. Dato = direccionBaseFoto + bytesDibujados
				strh colour,[fbAddr]				//Almacenamos en el frameBuffer.
				add fbAddr,#2 						//Incrementamos el frame buffer para dibujar el siguiente pixel.
				add countByte,#2 					//Incrementamos los bytes dibujados en dos (ya dibujamos 2 bytes)
				sub x,#1 							//Decrementamos el contador del ancho de la imagen
			
				//Revisamos si ya dibujamos toda la fila
				teq x,#0
				bne drawPixel$
			
			//Calculamos la direccion del frameBuffer para dibujar la siguiente linea
			//Direccion siguiente linea = (Ancho de la pantalla - ancho de la imagen) * Bytes/pixel 
			ldr r7,=1848 	//(1024-100)*2=1848
			add fbAddr,r7	//Le sumamos al frameBuffer la cantidad calculada para bajar de linea
			
			//Decrementamos el contador del alto de la imagen
			sub y,#1 
			
			//Revisamos si ya dibujamos toda la imagen.
			teq y,#0
			bne drawRow$

	b render$

	.unreq fbAddr
	.unreq colour
	.unreq y
	.unreq addrPixel
	.unreq x
	.unreq countByte

