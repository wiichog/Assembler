
.section .init
.globl _start
_start:

b main


.section .text
.macro ConfigurarLed Valorx,Valory,color 					@@Configura el numero de puerto
	colour .req r0				@r0 es el color
	y .req r1					@r1 tiene la posicion y FILAS
	mov y,\Valory					@se le carga la resolucion de height
	drawRow$:				
		x .req r2				@r2 COLUMNAS
		mov x,\Valorx			@se le carga la resolucion de width
		mov colour,\color
		drawPixel$:
			strh colour,[fbAddr]		@toma la direccion y almacena el color es storeh por que queremos almacenar 16 bits
			add fbAddr,#2				@aumenta el frame buffer SIEMPRE TIENE QUE IR DE 2 EN 2
			sub x,#1					@le resta uno para recorrer la matriz
			teq x,#0					@compara si es cero si no es cero continua
			bne drawPixel$				@si es cero se pasa a Y

		sub y,#1						@le resta uno para recorrer la matriz
		add colour,#1					
		teq y,#0						@compara si es cero si no es cero continua
		bne drawRow$					@si es cero se pasa a Y
.endm

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
	ldr fbAddr,[fbInfoAddr,#32]@cargamos direccion del puntero osea la inforamcion de la tabla
	
	ConfigurarLed #342,#384,#1111100000000000
	ConfigurarLed #666,#384,#0000011111100000
	ConfigurarLed #1024,#384,#0000000000011111
	ConfigurarLed #342,#768,#0000000000011111
	ConfigurarLed #666,#768,#1111100000000000
	ConfigurarLed #1024,#768,#0000011111100000
	
/* NEW
* We will use r0 to keep track of the current colour.
*/
	

	b render$							@repite ciclo infinito

	.unreq fbAddr
	.unreq fbInfoAddr
