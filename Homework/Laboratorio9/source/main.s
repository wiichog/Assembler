/******************************************************************************
*	main.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the screen04 operating system, that 
*	renders formatted text to the screen.
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
/* Calculos*/
	ldr r3,=vec1					@Cargamos en r0 al vector
	ldr r5,=n						@apunta a dir que contiene tamaño de vector
	ldr r5,[r5] 					@m: tamanio de los vectores
	mov r6,#0 						@Indice del vector
		recorre:
			ldr r4,[r0],#4 			@en r3 estamos guardando el contenido de esa posicion del vector
			mov r0,r4				@movemos a r0 lo que encontramos en r4 para cumplir formato ABI
			bl NegativoPositivo		@llamamos a subrutina
			add r9,r9,r7			@en r9 guardaremos el contador de los positivos
			add r10,r10,r8			@en r10 guardaremos el contador de los negativos
			add r6,r6,#1			@actualiza contador
			cmp r6,r5				@contador<N?
		blt recorre					@si.. vaya a sumar
	/*
	*R9 TIENE EL CONTADOR DE LOS POSITIVOS
	*R10 TIENE EL CONTADOR DE LOS NEGATIVOS
	*
	*/
	ldr r7,=Positivo		
	str r6,[r7]	/*guardo resultado en suma*/	
	ldr r8,=Negativo					
	str r6,[r7]	/*guardo resultado en suma*/
	
	

/*Inicio de impresion de datos*/	

	ldr r0,=format
	mov r1,#formatEnd-format
	ldr r2,=formatEnd
	/*ldr r3,=dato1
	ldr r3,[r3]
	ldr r4,=dato2
	ldr r4,[r4]
	ldr r5,=dato3
	ldr r5,[r5]*/
	ldr r6,=suma
	ldr r6,[r6]
	
	push {r6}
	push {r5}
	push {r4}
	
	
	bl FormatString
	add sp,#12
	
	/*r0:inicio cadena, r1:long, r2:x, r3:y*/
	mov r1,r0 			/*En r0 viene long cadena*/
	ldr r0,=formatEnd	/*cadena a imprimir*/
	mov r2,#500 		/*x*/
	ldr r3,=350			/*y*/
	bl DrawString

loop$:
	b loop$

.section .data
vec1:		.word 1,2,3,-4,5,6,-7,8,-9,10
n:			.word 10
suma:		.word 0
Positivo:	.word 0
Negativo:	.word 0
format: 	.ascii "Dato1: %d\tDato2: %d\tDato3: %d\tSuma: %d"
formatEnd:
