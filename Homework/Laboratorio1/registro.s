@Universidad del valle de Guatemala
@Juan Luis Garcia 14189
@Samuel Diaz
@Taller de Assembler Seccion 11
@Laboratorio #1 
.data
.align 2

.text
.align 2

.global registro

@r0: Nota1
@r1: Nota2
@r2: Nota3
@r3: Nota4

Promedio:
		add	r0,r0,r1				@Hace la Suma de la primera y la segunda Nota1
		add r0,r0,r2				@Hace la suma de lo anterior y de la tercera nota
		add r0,r0,r3				@Hace la suma de lo anterio y la ultima nota
		contador 	.req r2 		@Contador para el ciclo
		divisor	 	.req r1 		@Numero de veces que se repetira el ciclo
		mov r1,#4					@Se le da el valor a r1 de 4 para que pueda hacer la division
		dividendo	.req r0 		@r0 lleva la nota 
		mov contador,#0				@inicializar contador
		b ciclo 					@se llama a la subrutina que hace la division
			
ciclo:
		cmp divisor, dividendo		@compara el divisor y el dividendo
		bgt fin						@si es mas grande se sale
		sub dividendo,divisor		@hace la resta
		add contador,#1				@suma uno al contador
		b ciclo						@repite
fin:
		.unreq contador 			@se les quita el nombre
		.unreq dividendo			@se les quita el nombre
		.unreq divisor				@se les quita el nombre
		mov r1,r0					@guarda el residuo
		mov pc,lr					@regresa al sistema
		
EstadoSemestre:
		mov r6,#65					@asigna a r6 el valor de 65 para comparar
		cmp r0,r6					@compara r0 y r6 para 
		movgt r0,#1					@asigna un 1 a r0 si es mayor
		movlt r0,#0					@asigna un 0 a r0 si es menor
		mov pc,lr					@regresa al sistema

		
formaNombre:
	push {lr}						@Se almacena el valor del lr
	mov r3, #0						@Se inicia el contador en 0
Apellido:
	ldrb r4,[r1],#1					@Se obtienen las letras del Apellido	
	strb r4,[r2],#1					@y se almacena en la cadena vacia 
	add r3,#1 						@Se aumenta el contador 
	cmp r3, #3						@Se compara con el numero de letras del Apellido 
	bne Apellido					@Si no ha llegado al final se repite el ciclo 
	
Carne:
	ldr r4,[r0],#4					@Se obtienen los numeros del carne
	str r4,[r2],#4					@y se almacenan en la cadena vacia
	add r3,#1 						@Se aumenta el contador 
	cmp r3, #8						@Se compara con el numero de letras del Apellido
	bne Carne						@Si no ha llegado al final se repite el ciclo 
	ldr r0,=cadena
	pop {pc}						@retorno al programa 	

		

		
		
		
		
		
		
		
		
		
		
		
