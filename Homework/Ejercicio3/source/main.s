@Juan Luis Garcia 1489
@Juan Carlos Tapia 14133
@Ejercicio #3
@Universidad del Valle de Guatemala
@Taller de Asembler
@
.section .init
.globl _start
_start:

b main


.section .text


main:


	mov sp,#0x8000
	mov r0,#1024			@tamano de pantalla
	mov r1,#768				@tamano de pantalla
	mov r2,#16				@resolucion
	bl InitialiseFrameBuffer@inicializa el frame buffer

/* NEW
* Check for a failed frame buffer.
*/
	teq r0,#0		@puntero es distinto de cero
	bne noError$	@podemos continuar
		
	mov r0,#16		@encendemos el puerto 16 (LED OK)
	mov r1,#1		@escritura
	bl SetGpioFunction@le decimos que va a ser escritura su funcion

	mov r0,#16		@mandamos a tierra el puerto 16
	mov r1,#0		@lectura
	bl SetGpio		@se enciende el LED OK para decir que hay un error

	error$:
		b error$

	noError$:		@ si no hay ningun error r0 es igual a 0

	fbInfoAddr .req r4		@nombramos a r4 con fbInfoAddr
	mov fbInfoAddr,r0		@almacenamos la inforcion en fbInfoAddr

/* NEW
* Set pixels forevermore. 
*/
render$:					@ciclo infinito donde dibujamos
	fbAddr .req r3
	ldr fbAddr,[fbInfoAddr,#32]@cargamos direccion del puntero osea la inforamcion de la tabl

	colour .req r0
	y .req r1
	mov y,#768 @ se guarda el alto de la pantalla.
	
	
	drawRow$:
		mov colour, #0b1111100000000000
		x .req r2
		mov x,#1024 @ se guarda el alto de la pantalla.
		drawPixel$:
			@ Cuando se alcanza un tercio de la fila, se cambia de color.
			ldr r11, =666
			cmp x, r11
			moveq colour, #0b0000011111100000
			
			@ Se hace 2 veces, para que haya 3 colores.
			ldr r11, =342
			cmp x, r11
			moveq colour, #0b0000000000011111
			
			strh colour,[fbAddr]
			add fbAddr,#2
			sub x,#1 @ Se reduce el contador en x 
			teq x,#0 @ Cuando se completa la fila, se pasa a la siguiente columna.
			bne drawPixel$

		sub y,#1 @ Se reduce el contador en x 
		
		cmp y,#384
		bne drawRow$
		
	@ El proceso se repite, pero esta ves los tercios de la fila. son de colores diferentes. De esta forma se tienen 2 filas de 3 columnas.
	drawRow2$:
		mov colour,  #0b0000000000011111 
		x .req r2
		mov x,#1024
		drawPixel2$:
			ldr r11, =666
			cmp x, r11
			moveq colour, #0b1111100000000000
			
			ldr r11, =342
			cmp x, r11
			moveq colour, #0b0000011111100000
			
			strh colour,[fbAddr]
			add fbAddr,#2
			sub x,#1
			teq x,#0
			bne drawPixel2$

		sub y,#1
		
		cmp y,#0
		bne drawRow2$


	b render$	
	
	
	.unreq fbAddr
	.unreq fbInfoAddr

	