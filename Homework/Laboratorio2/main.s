@********************************************************
@ lab2.s
@ Autor: Juan Luis Garcia 14189
@ 		 Juan Carlos Tapia 14133
@ Fecha: 07/08/2015
@*******************UTILIZACION DE REGISTROS*************
@ r0: Comprobacion maximo 10 puntos
@ r1: Corto maximo 20 puntos
@ r2: Actividad maximo 60 puntos
@ r3: Maximo 10 puntos
@***************** AREA DE CODIGO ***********************
@area del codigo
.global _start
_start:
@*************Ingreso de notas **********************
	@ IMPRESION DE BIENVENIDA
	mov r7, #4      			  @4=llamado a "write" swi
    mov r0, #1      			  @1=stdout (monitor)
    mov r2, #63      			  @longitud de la cadena: 20 caracteres mas uno de enter
    ldr r1, =Bienvenida  @apunta a la cadena
    swi 0
	
	
	@ NOTA DE COMPROBACION
	mov r7, #4      			  @4=llamado a "write" swi
    mov r0, #1      			  @1=stdout (monitor)
    mov r2, #21      			  @longitud de la cadena: 20 caracteres mas uno de enter
    ldr r1, =IngresoComprobacion  @apunta a la cadena
    swi 0
	
	mov r7,#3		  		@3=llamado a "read" swi
	mov r0,#0		  		@(teclado)
	mov r2,#3		  		@longitud de la cadena
	ldr r1,=resultadoComprobacion 		@aqui se guardan los valores
	swi 0 					@Software Interruption
	mov r3,r1				@r3 almacena temporalmente el dato
	
	@NOTA DE CORTO
	mov r7, #4      			  @4=llamado a "write" swi
    mov r0, #1      			  @1=stdout (monitor)
    mov r2, #14      			  @longitud de la cadena: 13 caracteres mas uno de enter
    ldr r1, =IngresoCorto  @apunta a la cadena
    swi 0
	
	mov r7,#3		  		@3=llamado a "read" swi
	mov r0,#0		  		@(teclado)
	mov r2,#3		  		@longitud de la cadena
	ldr r1,=resultadoCorto 		@aqui se guardan los valores
	swi 0 					@Software Interruption
	mov r4,r1				@r4 almacena temporalmente el dato
	
	@NOTA DE ACTIVIDAD
	mov r7, #4      			  @4=llamado a "write" swi
    mov r0, #1      			  @1=stdout (monitor)
    mov r2, #18      			  @longitud de la cadena: 17 caracteres mas uno de enter
    ldr r1, =IngresoActividad  @apunta a la cadena
    swi 0
	
	mov r7,#3		  		@3=llamado a "read" swi
	mov r0,#0		  		@(teclado)
	mov r2,#3		  		@longitud de la cadena
	ldr r1,=resultadoActividad 		@aqui se guardan los valores
	swi 0 					@Software Interruption
	mov r5,r1				@r5 almacena temporalmente el dato
	
	@NOTA DE REFLEXION
	mov r7, #4      			  @4=llamado a "write" swi
    mov r0, #1      			  @1=stdout (monitor)
    mov r2, #18      			  @longitud de la cadena: 17 caracteres mas uno de enter
    ldr r1, =IngresoReflexion  @apunta a la cadena
    swi 0
	
	mov r7,#3		  		@3=llamado a "read" swi
	mov r0,#0		  		@(teclado)
	mov r2,#3		  		@longitud de la cadena
	ldr r1,=resultadoReflexion 		@aqui se guardan los valores
	swi 0 					@Software Interruption
	mov r6,r1				@r6 almacena temporalmente el dato
	
	@hacemos movimiento de dato para cumplir con el formato
	mov r0,r3
	mov r1,r4
	mov r2,r5
	mov r3,r6
	
	bl rutinas			@Llamada a la subrutina
	
	
    @ ------------------------------
    @ salida al sistema operativo
    mov r7, #1
    swi 0


@********************************************************
@****************** AREA DE DATOS ***********************
@********************************************************
.data
dato:   .word 148       @ Numero a desplegar en pantalla
enter:  .asciz "\n"	    @ enter
letra:  .asciz " "	    @ almacenar el valor numerico




resultadoComprobacion: .asciz "   "  @ Espacio para almacenar caracteres
resultadoCorto: .asciz "   "  @ Espacio para almacenar caracteres
resultadoActividad: .asciz "   "  @ Espacio para almacenar caracteres
resultadoReflexion: .asciz "   "  @ Espacio para almacenar caracteres

Bienvenida: .asciz "Bienvenido. Ingrese todas las notas obtenidas en el laboratorio"
IngresoComprobacion: .asciz "Nota de Comprobacion"
IngresoCorto: .asciz "Nota de Corto"
IngresoActividad: .asciz "Nota de Actividad"
IngresoReflexion: .asciz "Nota de Reflexion"
