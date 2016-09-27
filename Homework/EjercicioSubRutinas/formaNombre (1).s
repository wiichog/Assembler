@Universidad Del Valle de Guatemala 
@Taller de Assembler 
@Seccion 11
@Samuel Diaz 		 14083
@Juan Luis García 	 14189
@Subrutina formaNombre

@Arma la cadena del nomrbre de una persona con el 
@formato "ApellidoCarne" 

@Registros
@Entrada:
@R0: Direccion de memoria de carne
@R1: Direccion de memoria de Apellido
@R2: Direccion de cadena a llenar

@Salida:
@R0: Nombre con el formato

@Uso dentro de Subrutina
@R3: Contador
@R4: Almacenamiento temporal

.global formaNombre
formaNombre:
	push {lr}				@Se almacena el valor del lr
	mov r3, #0				@Se inicia el contador en 0
Apellido:
	ldrb r4,[r1],#1			@Se obtienen las letras del Apellido	
	strb r4,[r2],#1			@y se almacena en la cadena vacia 
	add r3,#1 				@Se aumenta el contador 
	cmp r3, #3				@Se compara con el numero de letras del Apellido 
	bne Apellido			@Si no ha llegado al final se repite el ciclo 
	
Carne:
	ldr r4,[r0],#4			@Se obtienen los numeros del carne
	str r4,[r2],#4			@y se almacenan en la cadena vacia
	add r3,#1 				@Se aumenta el contador 
	cmp r3, #8				@Se compara con el numero de letras del Apellido
	bne Carne				@Si no ha llegado al final se repite el ciclo 
	ldr r0,=cadena
	pop {pc}				@retorno al programa 	
