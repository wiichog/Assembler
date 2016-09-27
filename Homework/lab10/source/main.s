.section .data
.align 2
Xs: .word 512
Ys: .word 384
punteo: .word 0
par1: .word 0 /*33.33.33.3..*/
par2: .word 0 /*x diana1*/
par3: .word 0 /*y diana1*/
par4: .word 0 /*x diana2*/
par5: .word 0 /*y diana2*/
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

.macro Random numero 	@Llama al reloj interno de la raspberry, luego se le hace un and para obtener solo numero de 0 a 3 y se le suma uno para obtener numero de 1 a 4
	@@ Obtuvimos el macro de auxiliar
	bl GetTimeStamp				
	and r0,\numero
	add r0,#1
	@Devuelve el numero "random" en r0
.endm

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

	
	bl SetGraphicsAddress	
 
	colour .req r10
/*
* Let our drawing method know where we are drawing to.
*/
	bl SetGraphicsAddress

	bl UsbInitialise

	// Setup del LED OK
	mov r0, #16
	mov r1, #1
	bl SetGpioFunction

	// Setup del boton
	mov r0,#7
	mov r1,#0
	bl SetGpioFunction

	// Codigo de Chadwick para lectura del teclado
	mov r4,#0
	mov r5,#0

/*********************************CONFIGURACIONES PARA BOTON*********************************************************/
	mov r0,#14										@@Se configuran los botones como entrada
	mov r1,#0
	bl SetGpioFunction
	/*Aqui guardamos la direccion en donde se encuentra el boton*/
	mov r0, #14
	bl GetGpioAddress
	mov r4,r0										
revisarBoton:	
	ldr r5,[r4,#0x34]								/*guardamos en r5 la direccion del boton*/
	mov r0,#1										/*no se para que funciona esto*/
	lsl r0,#14										/*no se para que funciona esto*/
	and r5,r0 										/*no se para que funciona esto*/
	teq r5, #0 										/*si r5 si es igual a r5 entonces ponemos todas las acciones del boton con eq*/		
	beq boton$									/*Mandamos a dibujar un monton de bombas esta que la haga freddie*/
	
/*************************SUBRUTINA DE BOTONES****************************/

	
	
aqui:	
	ldr r0, =inicioHeight
	mov r1,#0
    mov r2, #0
    bl drawImageWithTransparency

	
	loopContinue$:
	
	ldr r1,=punteo
	ldr r0,[r1]
	cmp r0,#5
	bgt gameOverW$
		
	bl KeyboardUpdate
	bl KeyboardGetChar

	teq r0,#0
	beq loopContinue$

	cmp r0,#'\a' 
	beq izq$
	
	cmp r0,#'\q'
	beq inicio$
	
	cmp r0,#'\s'
	beq abajo$
	
	cmp r0,#'\w'
	beq arriba$
	
	cmp r0,#'\n'
	beq shoot$
	
	
	teq r0,#'\d'
	beq der$
	
	b loopContinue$

inicio$:

	ldr r0, =fondoHeight
	mov r1,#0
    mov r2, #0
    bl drawImageWithTransparency

	
	
	ldr r0,=pistolab1Height
	mov r1,#512
	mov r2,#668
	bl drawImageWithTransparency
	
	
	x .req r9 				
	y .req r11 					
	
	mov r0,#0
	Random #468
	mov x,r0
	Random #468
	mov y,r0
	
	ldr r0,=par2
	str x,[r0]
	ldr r1,=par3
	str y,[r1]
	mov r0,x
	mov r1,y
	mov r2,#90			/*radio gigante*/
	
	bl DrawDiana
	mov r12,r0
	ldr r1,= par1
	str r12,[r1]
	
	
	mov r0,#0
	Random #768
	mov x,r0
	Random #768
	mov y,r0
	
	ldr r0,=par4
	str x,[r0]
	ldr r1,=par5
	str y,[r1]
	mov r0,x
	mov r1,y
	mov r2,#90			/*radio gigante*/
	
	bl DrawDiana
	mov r12,r0
	ldr r1,= par1
	str r12,[r1]
	b loopContinue$
shoot$:
	bl Animacion
	ldr r0,=par1
	ldr r0,[r0]
	ldr r1,=par4
	ldr r1,[r1]
	ldr r2,=par5
	ldr r2,[r2]
	ldr r3,=par2
	ldr r3,[r3]
	ldr r4,=par3
	ldr r4,[r4]
	mov r4,#500
	mov r9,r0
	mov r10,r1
	mov r11,r2
	mov r12,r3
	push {r4,r9,r10,r11,r12}
	bl Punteo2
	mov r4,r0
	cmp r4,#0
	/*beq Diana2$*/
	movne r3,r4
	ldrne r1,=punteo
	ldrne r0,[r1]
	addne r3,r0
	strne r3,[r1]
	b loopContinue$
Diana2$:
	
	ldr r0,=par1
	ldr r0,[r0]
	ldr r1,=Xs
	ldr r1,[r1]
	ldr r2,=Ys
	ldr r2,[r2]
	ldr r3,=par4
	ldr r3,[r3]
	ldr r4,=par5
	ldr r4,[r4]
	push {r4}
	bl punteo
	mov r4,r0
	cmp r4,#0
	beq loopContinue$
	movne r3,r4
	ldrne r1,=punteo
	ldrne r0,[r1]
	addne r3,r0
	strne r3,[r1]
	b loopContinue$
	
abajo$:
		
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]
	
	
	
	sub r0,#10
	sub r1,#10
	mov r2,#30
	mov r3,#30
	ldr r4,=fondo
	push {r4}
	bl transpa
	
	
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]
	
	mov r2,r0
	mov r3,r1
	add r3,#10
	
	ldr r9,=par4
	str r0,[r9]
	ldr r10,=par5
	str r3,[r10]
	str r3,[r7]
	
	mov r1,r3
	mov r0,r2
	bl moveCircle
	b loopContinue$
	
izq$:

	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]

	sub r0,#10
	sub r1,#10
	mov r2,#30
	mov r3,#30
	ldr r4,=fondo
	push {r4}
	bl transpa

	
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]
	
	mov r2,r0
	mov r3,r1
	sub r2,#10
	ldr r9,=par4
	str r0,[r9]
	ldr r10,=par5
	str r3,[r10]
	str r2,[r8]
	mov r1,r3
	mov r0,r2
	bl moveCircle
	b loopContinue$
der$:
	
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]

	sub r0,#10
	sub r1,#10
	mov r2,#30
	mov r3,#30
	ldr r4,=fondo
	push {r4}
	bl transpa

	
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]
	
	mov r2,r0
	mov r3,r1
	add r2,#10
	str r2,[r8]
	ldr r9,=par4
	str r0,[r9]
	ldr r10,=par5
	str r3,[r10]
	mov r1,r3
	mov r0,r2
	bl moveCircle
	b loopContinue$

arriba$:

	
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]
	
	
	sub r0,#10
	sub r1,#10
	mov r2,#30
	mov r3,#30
	ldr r4,=fondo
	push {r4}
	bl transpa
	
	ldr r8,=Xs
	ldr r0,[r8]
	ldr r7,=Ys
	ldr r1,[r7]
	
	mov r2,r0
	mov r3,r1
	sub r3,#10
	ldr r9,=par4
	str r0,[r9]
	ldr r10,=par5
	str r3,[r10]
	str r3,[r7]
	mov r1,r3
	mov r0,r2
	
	bl moveCircle
	b loopContinue$
gameOverW$:
	ldr r0, =ganoHeight
	mov r1,#0
    mov r2, #0
    bl drawImageWithTransparency

	ldr r0,=1000000
	bl Wait
	
	ldr r1,=punteo
	mov r3,#0
	str r3,[r1]
	b aqui

gameOverL$:
	ldr r0, =perdioHeight
	mov r1,#0
    mov r2, #0
    bl drawImageWithTransparency

	ldr r0,=1000000
	bl Wait
	
	ldr r1,=punteo
	mov r3,#0
	str r3,[r1]
	
	b aqui
boton$:
	cmp r8,#20
	beq gameOverL$
	mov r0,#0
	Random #768
	mov r2,r0
	Random #768
	mov r3,r0
	
	ldrne r0,=destructionHeight
	mov r1,x
	mov r2,y
	bl drawImageWithTransparency
	add r8,#1
	ldr r0,=1000000
	bl Wait
	b boton$