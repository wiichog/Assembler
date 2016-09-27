/******************************************************************************
*	maths.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the screen04 operating system.
*	See main.s for details.
*
*	maths.s contains the rountines for mathematics.
******************************************************************************/

/* NEW
* DivideU32 Divides one unsigned 32 bit number in r0 by another in r1 and 
* returns the result in r0 and the remainder in r1.
* C++ Signature: u32x2 DivideU32(u32 dividend, u32 divisor);
* This is implemented as binary long division.
*/
.globl DivideU32
DivideU32:
	result .req r0
	remainder .req r1
	shift .req r2
	current .req r3

	clz shift,r1
	clz r3,r0
	subs shift,r3
	lsl current,r1,shift
	mov remainder,r0
	mov result,#0
	blt divideU32Return$
	
	divideU32Loop$:
		cmp remainder,current
		blt divideU32LoopContinue$

		add result,result,#1
		subs remainder,current
		lsleq result,shift 
		beq divideU32Return$

	divideU32LoopContinue$:
		subs shift,#1
		lsrge current,#1
		lslge result,#1
		bge divideU32Loop$
	
divideU32Return$:
	.unreq current
	mov pc,lr
	
	.unreq result
	.unreq remainder
	.unreq shift
	
	
/****************************
* NegativoPositivo
* Autor: Freddie Batlle
* Autor: Juan Luis Garcia
*
*Compara con 0 para clasificar negativos y positivos
*
* Parametros de entrada:
* 	R0: Numero
* Parametros de salida:
* 	R7: un 1 si es positivo 
*	R8: un 1 si es positivo 
****************************/

	.globl NegativoPositivo
		NegativoPositivo:
		Numero .req r5 				@nombramos a r5 
	mov Numero,r0					@movemos lo que viene en r0 para no afectar su valor
	mov r7,#0						@inicializamos el valor de r7
	mov r8,#0						@inicializamos el valor de r8
	cmp Numero,#0					@comparamos
	movgt r7,#1						@si es mayor a 0 lo clasificamos como positivo
	movlt r8,#1						@si es menor a 0 lo clasificamos como negativo
	mov pc,lr
	.unreq Numero
	