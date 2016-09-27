.data										@Sedeclaran las variables
.align 2


@VARIABLES DE INGRESO DE DATOS --------------------------------------------------------
nombre: .asciz "Samuel"							@Guarda el nombre del usuario
apellido: .asciz "Diaz"							@Guarda el apellido del usuario
carne: .asciz "14083"							@Guarda el carne del usuario
carrera: .asciz "Mecatronica"							@Guarda la carrera del usuario
nota1: .word 70								@Guardan la primer nota del usuario
nota2: .word 70								@Guardan la segunda nota del usuario
nota3: .word 60								@Guardan la tercer nota del usuario
nota4: .word 68							@Guardan la cuarta nota del usuario

@VARIABLES DE IMPRESION DE DATOS ------------------------------------------------------
usuario: .asciz "Usuario: %s\n"						@Variables que guardan los datos a imprimir



.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}
	
	
	@ ingreso de datos de Nombre
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r4,[r1]
	
	@ ingreso de datos de Apellido
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r5,[r1]
	
	@ ingreso de datos de Carne
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r6,[r1]
	
	@ ingreso de datos de Carrera
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r7,[r1]
	
	@ ingreso de datos de Nota1
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r8,[r1]
	
	@ ingreso de datos de Nota2
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r9,[r1]
	
	@ ingreso de datos de Nota3
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r10,[r1]
	
	@ ingreso de datos de Nota4
	ldr r0,=mensaje_ingreso  		
	bl puts
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r11,[r1]

	
	@Para la impresion de el usuario
	ldr r12, =usuario
	bl GenerarUsuario
	bl puts
	b fin
	
GenerarUsuario:
	push {lr}
	mov r3, #0						@Se inicia el contador en 0
Apellido:
	ldrb r0,[r5], #1				@Se obtienen las letras del Apellido	
	strb r0,[r12], #1				@y se almacena en la cadena vacia 
	add r3, #1 						@Se aumenta el contador 
	cmp r3, #3						@Se compara con el numero de letras del Apellido 
	bne Apellido					@Si no ha llegado al final se repite el ciclo 
	beq Carne
Carne:
	ldrb r1,[r6], #1	@Se obtienen los numeros del carne
	strb r1,[r12], #1				@y se almacenan en la cadena vacia
	add r3, #1 						@Se aumenta el contador 
	cmp r3, #8						@Se compara con el numero de letras de la cadena
	bne Carne						@Si no ha llegado al final se repite el ciclo 
	ldr r0, =usuario
	pop {lr}                    @retorno al programa 
	mov pc, lr	
				

				
				
				

fin: /*Salida del Programa*/
	mov r0, #0
	mov r3, #0
	ldmfd sp!,{lr}
	bx lr
	

formato:
	.asciz " %d\n"
entrada:
	.asciz " %d"
mensaje_ingresoNombre:
	.asciz "Ingrese su Nombre: "
mensaje_ingresoApellido:
	.asciz "Ingrese su Apellido: "
mensaje_ingresoCarne:
	.asciz "Ingrese su Carne: 
mensaje_ingresoCarrera:
	.asciz "Ingrese su Carrera: "
mensaje_ingresoNota1:
	.asciz "Ingrese Nota1: "
mensaje_ingresoNota2:
	.asciz "Ingrese Nota2: "
mensaje_ingresoNota3:
	.asciz "Ingrese Nota3: "
mensaje_ingresoNota4:
	.asciz "Ingrese Nota4: "
mal:
	.asciz "Ingreso incorrecto\n"

