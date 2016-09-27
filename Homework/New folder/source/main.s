/******************************************************************************
*	main.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the input02 operating system, that 
*	demonstrates a command line interface.
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

	bl UsbInitialise
	
reset$:
	mov sp,#0x8000
	bl TerminalClear

	ldr r0,=welcome
	mov r1,#welcomeEnd-welcome
	bl Print

loop$:		
	ldr r0,=prompt
	mov r1,#promptEnd-prompt
	bl Print

	ldr r0,=command
	mov r1,#commandEnd-command
	bl ReadLine

	teq r0,#0
	beq loopContinue$

	mov r4,r0
	
	ldr r5,=command
	ldr r6,=commandTable
	
	ldr r7,[r6,#0]
	ldr r9,[r6,#4]
	commandLoop$:
		ldr r8,[r6,#8]
		sub r1,r8,r7

		cmp r1,r4
		bgt commandLoopContinue$

		mov r0,#0	
		commandName$:
			ldrb r2,[r5,r0]
			ldrb r3,[r7,r0]
			teq r2,r3			
			bne commandLoopContinue$
			add r0,#1
			teq r0,r1
			bne commandName$

		ldrb r2,[r5,r0]
		teq r2,#0
		teqne r2,#' '
		bne commandLoopContinue$

		mov r0,r5
		mov r1,r4
		mov lr,pc
		mov pc,r9
		b loopContinue$

	commandLoopContinue$:
		add r6,#8
		mov r7,r8
		ldr r9,[r6,#4]
		teq r9,#0
		bne commandLoop$	

	ldr r0,=commandUnknown
	mov r1,#commandUnknownEnd-commandUnknown
	ldr r2,=formatBuffer
	ldr r3,=command
	bl FormatString

	mov r1,r0
	ldr r0,=formatBuffer
	bl Print

loopContinue$:
	bl TerminalDisplay
	b loop$
/********** codigo para verificar que se ingreso comando color */
color:
	teq r1,#10	//long cadena ingr.:rojo
	beq rojo
	teq r1,#11	//verde
	beq verde
	teq r1,#6	//ninguno: negro
	beq negro
	teq r1,#13	//ninguno: celeste
	beq celeste
	mov pc,lr

verde:
	ldrb r2,[r0,#6]
	teq r2,#'v'
	ldreqb r2,[r0,#7]
	teqeq r2,#'e'
	ldreqb r2,[r0,#8]
	teqeq r2,#'r'
	ldreqb r2,[r0,#9]
	teqeq r2,#'d'
	ldreqb r2,[r0,#10]
	teqeq r2,#'e'
	bne error
	mov r11,#0x2 //verde
	ldr r10,=terminalColour
	strb r11,[r10]
	ldr r0,=colorcambiadoverde
	mov r1,#colorcambiadoverdeEnd-colorcambiadoverde
	b Print
	mov pc,lr
	
celeste:
	ldrb r2,[r0,#6]
	teq r2,#'c'
	ldreqb r2,[r0,#7]
	teqeq r2,#'e'
	ldreqb r2,[r0,#8]
	teqeq r2,#'l'
	ldreqb r2,[r0,#9]
	teqeq r2,#'e'
	ldreqb r2,[r0,#10]
	teqeq r2,#'s'
	ldreqb r2,[r0,#11]
	teqeq r2,#'t'
	ldreqb r2,[r0,#12]
	teqeq r2,#'e'
	bne error
	mov r11,#0x11 //celeste
	ldr r10,=terminalColour
	strb r11,[r10]
	ldr r0,=colorcambiadoceleste
	mov r1,#colorcambiadocelesteEnd-colorcambiadoceleste
	b Print
	mov pc,lr

rojo: 
	ldrb r2,[r0,#6]
	teq r2,#'r'
	ldreqb r2,[r0,#7]
	teqeq r2,#'o'
	ldreqb r2,[r0,#8]
	teqeq r2,#'j'
	ldreqb r2,[r0,#9]
	teqeq r2,#'o'
	bne error
	mov r11,#0x1 //rojo
	ldr r10,=terminalColour
	strb r11,[r10]
	ldr r0,=colorcambiadorojo
	mov r1,#colorcambiadorojoEnd-colorcambiadorojo
	b Print
	mov pc,lr

negro: 
	mov r11,#0xf //blanco
	ldr r10,=terminalColour
	strb r11,[r10]
	mov pc,lr
	
error: 
	ldr r0,=commandUnknown
	mov r1,#commandUnknownEnd-commandUnknown
	b 	Print
	mov pc,lr	
	
/******* fin del codigo agregado */
echo:
	cmp r1,#5
	movle pc,lr

	add r0,#5
	sub r1,#5 
	b Print

ok:
	teq r1,#5
	beq okOn$
	teq r1,#6
	beq okOff$
	mov pc,lr

	okOn$:
		ldrb r2,[r0,#3]
		teq r2,#'o'
		ldreqb r2,[r0,#4]
		teqeq r2,#'n'
		movne pc,lr
		mov r1,#0
		b okAct$

	okOff$:
		ldrb r2,[r0,#3]
		teq r2,#'o'
		ldreqb r2,[r0,#4]
		teqeq r2,#'f'
		ldreqb r2,[r0,#5]
		teqeq r2,#'f'
		movne pc,lr
		mov r1,#1

	okAct$:
		mov r0,#16
		b SetGpio
	
.section .data
.align 2
welcome:
	.ascii "Welcome to Alex's & Juan Luis Garcia's OS - Everyone's favourite OS"
welcomeEnd:
.align 2
colorcambiadorojo:
	.ascii "El color ha sido cambiado a rojo"
colorcambiadorojoEnd:
.align 2
colorcambiadoverde:
	.ascii "El color ha sido cambiado a verde"
colorcambiadoverdeEnd:
.align 2
colorcambiadoceleste:
	.ascii "El color ha sido cambiado a celeste"
colorcambiadocelesteEnd:
.align 2
prompt:
	.ascii "\n> "
promptEnd:
.align 2
command:
	.rept 128
		.byte 0
	.endr
commandEnd:
.byte 0
.align 2
commandUnknown:
	.ascii "Command `%s' was not recognised.\n"
commandUnknownEnd:
.align 2
formatBuffer:
	.rept 256
	.byte 0
	.endr
formatEnd:

.align 2
commandStringEcho: .ascii "echo"
commandStringReset: .ascii "reset"
commandStringOk: .ascii "ok"
commandStringCls: .ascii "cls"
commandColor: .ascii "color" //linea agregada
commandStringEnd:

.align 2
commandTable:
.int commandStringEcho, echo
.int commandStringReset, reset$
.int commandStringOk, ok
.int commandStringCls, TerminalClear
.int commandColor, color //linea agregada
.int commandStringEnd, 0
