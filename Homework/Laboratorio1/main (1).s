.data										@Sedeclaran las variables
.align 2


@VARIABLES DE INGRESO DE DATOS --------------------------------------------------------
nombre: .asciz "Samuel"							@Guarda el nombre del usuario
apellido: .asciz "Diaz"							@Guarda el apellido del usuario
carne: .asciz "14083"							@Guarda el carne del usuario
carrera: .asciz "Mecatronica"							@Guarda la carrera del usuario
nota1: .word 50								@Guardan la primer nota del usuario
nota2: .word 50								@Guardan la segunda nota del usuario
nota3: .word 50								@Guardan la tercer nota del usuario
nota4: .word 50							@Guardan la cuarta nota del usuario


@VARIABLES DE IMPRESION DE DATOS ------------------------------------------------------
usuario: .asciz "        "						@Variables que guardan los datos a imprimir
promedio: .word 0
estado: .word 0
a:	.word 0

@Otras variables ----------------------------------------------------------------------
a: .asciz "     "
b: .word
ImpresionPromedio:
	.asciz "Promedio de semestre anterior: %d\n"
ImpresionUsuario:
	.asciz "Usuario:  %s\n"
ImpresionCarrera:
	.asciz "Estudiante de:  %s\n"
ImpresionAprobo:
	.asciz "Aprobo el semestre"
ImpresionReprobo:
	.asciz "No aprobo el semestre"

mensaje_ingresoNombre:
	.asciz "Ingrese su Nombre: "
mensaje_ingresoApellido:
	.asciz "Ingrese su Apellido: "
mensaje_ingresoCarne:
	.asciz "Ingrese su Carne: "
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
entrada:
	.asciz " %d"


.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}
	
@------------------------------------------------------------

	@ ingreso de datos de Nombre
	ldr r0,=mensaje_ingresoNombre  		
	bl printf
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r4,r1
	
	@ ingreso de datos de Apellido
	ldr r0,=mensaje_ingresoApellido  		
	bl printf
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r5,r1
	
	@ ingreso de datos de Carne
	ldr r0,=mensaje_ingresoCarne  		
	bl printf
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	mov r6,r1
	
	
	
	ldr r6, =carne
	ldr r7, =carrera
	ldr r8, =nota1
	ldr r9, =nota2
	ldr r10, =nota3
	ldr r11, =nota4
	

@------------------------------------------------------------
	
	@Para la impresion de el usuario
	ldr r12, =usuario
	bl GenerarUsuario
	mov r1, r0
	ldr r0,=ImpresionUsuario
	bl printf
@------------------------------------------------------------
	
	@Para imprimir la carrera
	mov r1, r7
	ldr r0,=ImpresionCarrera
	bl printf
	
	
@------------------------------------------------------------
	@Para obtener el promedio
	bl PromedioSemestre
	ldr r12, =promedio
	str r0, [r12]
	mov r1, r0
	ldr r0, =ImpresionPromedio
	bl printf
	

@------------------------------------------------------------	
	
	@Para determinar si gano o perdio 
	mov r0, r12
	ldr r12, =estado
	bl EstadoSemestre
	str r0, [r12]
	cmp r12, #0
	bgt aprobo
	b reprobo
	
reprobo:
	ldr r0, =ImpresionReprobo
	bl printf
	b fin
	
aprobo:
	ldr r0, =ImpresionAprobo
	bl printf
	b fin
	
@------------------------------------------------------------

@FUNCION USUARIO!!!!!!!!	
	GenerarUsuario:
		mov r3, #0						@Se inicia el contador en 0
		b Apellido
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
		mov pc, lr	
				
@FUNCION PROMEDIO!!!!!!!!	
	PromedioSemestre:
		ldr r0, =nota1
		ldr r0, [r0]
		ldr r1, =nota2
		ldr r1, [r1]
		ldr r2, =nota3
		ldr r2, [r2]
		ldr r3, =nota4
		ldr r3, [r3]
		add	r2,r2,r0				@Hace la Suma de la primera y la segunda Nota1
		add r2,r2,r1				@Hace la suma de lo anterior y de la tercera nota
		add r2,r2,r3				@Hace la suma de lo anterio y la ultima nota
		cociente 	.req r0 		@cociente para el ciclo, cuya magnitud sera la del promedio
		divisor	 	.req r1 		
		dividendo	.req r2 		
		mov divisor, #4				@Se le da el valor a r1 de 4 para que pueda hacer la division
		mov cociente, #0			@inicializar contador
	ciclo:
		cmp dividendo, divisor		@compara el divisor y el dividendo
		blt terminarciclo			@si es mas grande se sale
		sub dividendo,divisor		@hace la resta
		add cociente,cociente,#1				@suma uno al contador
		b ciclo						@repite
	terminarciclo:
		.unreq cociente 			@se les quita el nombre
		.unreq dividendo			@se les quita el nombre
		.unreq divisor				@se les quita el nombre
		mov pc,lr					@regresa al sistema
		
@FUNCION ESTADO!!!!!!!!
	EstadoSemestre:	
		mov r2,#61					@asigna a r2 el valor de 65 para comparar
		cmp r0,r2					@compara r0 y r2
		movgt r0,#1					@asigna un 1 a r0 si es mayor
		movlt r0,#0					@asigna un 0 a r0 si es menor
		mov pc,lr	
				
fin: /*Salida del Programa*/
	mov r0, #0
	mov r3, #0
	ldmfd sp!,{lr}
	bx lr
	

