@Universidad del valle de Guatemala
@Juan Luis Garcia 14189
@Pedro Castillo 14224
@Diego Morales 14012
@Taller de Assembler Seccion 11



.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!, {lr}	/* SP = R13 link register */
	
	menorNumero:	.word	0 @Almacena el promedio de los dos numeros
    formato:	.asciz	"El menor de los numeros es: %d  "
	
	
	mov r3,#1			@almacena valor 1 en r0
	mov r4,#4			@almacena valor 4 en r0
	bl menorInt			@ejecuta la subrutina
	
	ldr r0,=formato
	ldr r1,=menorNumero
	ldr r1,[r1]
	bl printf
	
	
	.data
	.align 2
	mov r3,#0
	mov r0,#0
	ldmfd sp!,{lr}
	bx lr