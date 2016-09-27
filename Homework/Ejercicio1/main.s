/* Main calculo de Notas
	
	AUTORES: JUAN LUIS GARCIA 14189
				
	FECHA: 31 JULIO 2015
	*/
/******** USO DE REGISTROS ********/
@r0:Nota1
@r1:Nota2
@r2:Nota3
@r3:Nota4
@r4:


/******** INICIO DE AREA DE DATOS ********/
.data
.align 2
ffnum:		.asciz "\nLa nota necesaria es de: %f \n"
/******** INICIO PROGRAMA PRINCIPAL ********/

.text
.align 2
.global main
.type main,%function
			
main:
stmfd sp!, {fp,lr}				@aqui tiene fp para trabajar punto flotante
push {r1} @guardo r1, donde esta la direccion para pasar a pto flotante
/******** Ingreso de Notas ********/
	@ ingreso de Notas1
	ldr r0, =mensaje_ingreso
	bl puts
	ldr r0, =entrada
	ldr r1, =nota1
	bl scanf
	
	@ ingreso de Notas2
	ldr r0, =mensaje_ingreso
	bl puts
	ldr r0, =entrada
	ldr r1, =nota2
	bl scanf
	
	@ ingreso de Notas3
	ldr r0, =mensaje_ingreso
	bl puts
	ldr r0, =entrada
	ldr r1, =nota3
	bl scanf
	
	@ ingreso de Notas4
	ldr r0, =mensaje_ingreso
	bl puts
	ldr r0, =entrada
	ldr r1, =nota4
	bl scanf
	
	@Se hacen estos movimientos para cumplir con las instrucciones
	ldr r0,=nota1 	@apunto a la variable tipo .word
	ldr r0,[r0] 	@cargo el dato de la variable
	
	ldr r0,=nota2 	@apunto a la variable tipo .word
	ldr r1,[r0] 	@cargo el dato de la variable
	
	ldr r0,=nota3 	@apunto a la variable tipo .word
	ldr r2,[r0] 	@cargo el dato de la variable
	
	ldr r0,=nota3 	@apunto a la variable tipo .word
	ldr r3,[r0] 	@cargo el dato de la variable
	
	bl CalculoNotaProyecto
	ldr r0,=ffnum	@Se imprime la nota 
	bl printf 
	
	bl PosibleMencion
	pop{r0} 		@se regresa la bandera que se guardo en la subrutina
	cmp r0,#1
	ldreq r0,=mencionok		@se merece la mencion
	ldrne r0,=mencionnotok	@no se merece la mencion
	bl printf
	

/******* SALIDA AL SISTEMA OPERATIVO *********/
mov r0,#0
mov r3,#0
ldmfd sp!,{fp,pc}				@aqui tiene fp para trabajar punto flotante
bx lr
.data
.align 2
/******* ALGUNOS MENSAJES *********/
nota1:	.word	0
nota2:	.word	0
nota3:	.word	0
nota4:	.word	0
entrada:			.asciz " %f"
formatoError: 		.asciz " %s"
mensaje_ingreso:	.asciz "Ingrese Nota: "
mencionok:	.asciz "Usted merece una mencion honorifica %d\n"
mencionnotok:	.asciz "Usted no merece una mencion honorifica %d\n"










