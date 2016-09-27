@Universidad Del Valle de Guatemala 
@Taller de Assembler 
@Seccion 11
@Pedro Joaquin Castillo Coronado 14224
@Juan Luis García 				 14189
@Diego Morales 					 14012
@MainNombre
@Main que implementa la subrutina formaNombre

@NOTA: El nombre y Apellido son predeterminados. Si estos son modificados
@el programa no se ejecutara de forma correcta

/*AREA DE CODIGO FUENTE*/	
@Se inicializa el programa 
.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!, {lr}
	
	ldr r0,=nombre			/*Se almacena la direccion del nombre en r0*/
	ldr r1,=apellido		/*Se almacena la direccion del apellido en r1*/
	ldr r2,=cadena			/*Se almacena la direccion de la cadena vacia en r2*/
	bl formaNombre			/*Llamada a subrutina*/
	ldr r0,=cadena			/*Se carga la cadena ya completa*/
	bl printf				/*Impresion en pantalla*/
	
	/*Salida del Programa*/
	mov r0,#0
	mov r3,#0

	ldmfd sp!,{lr}
	bx lr
	
.data 
.align 2
nombre:								/*Almacena el nombre*/
	.asciz "Pedro"
apellido:							/*Almacena el apellido*/
	.asciz "Castillo"
cadena:
	.asciz "        ,      \n"		/*Cadena donde se ordenara el nombre con formato*/