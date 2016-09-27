@Universidad del valle de Guatemala
@Juan Luis Garcia 14189
@Pedro Castillo 14224
@Diego Morales 14012
@Taller de Assembler Seccion 11

.data
.align 2

.text
.align 2

.global menorInt

@r1: menor numero
@r3: numero 1
@r4: numero 2

menorInt:
		push {lr}			@Ingresa lr a la pila
		cmp r3,r4			@hace la comparacion
		cmplt r3,r4			@compara si r3 es menor que r4
		ldr r1, [r3]			@si r3 es menor que r4 guarda el valor en r1
		
		cmplt r4,r3			@compara si r4 es menor que r3
		ldr r1, [r4]		@si r4 es menor que r3 almacena el valor en r1
		pop {pc}			@saca el valor de pc de la pila
		
