@********************************************************
@ main.s
@ Autor: Juan Luis Garcia 14189
@ 	 Juan Carlos Tapia 14133
@ Fecha: 21/08/2015
@********************************************************

.section .init
.globl _start
_start:

b main

.section .text

main:
mov sp,#0x8000

pinNum .req r0
pinFunc .req r1						@se nombran los registros
mov pinNum,#47						@47 por ser raspberry pi b+
mov pinFunc,#1						@se llama a funcion de escribir
bl SetGpioFunction					@se llama a subrutina
.unreq pinNum						@se le quita el nombre a los registros
.unreq pinFunc

estadoBajo .req r4					@se nombran las variables
estadoAlto .req r5
periodo .req r6

mov estadoBajo,#50					@se ingresan los valores
mov estadoAlto,#50					@se ingresan los valores
ldr periodo,=10000000

add r7,estadoAlto,estadoBajo		@suma los dos porcentajes

mul r0,estadoAlto,periodo			@se hace regla de 3
mov r1,#100
bl division							
mov estadoAlto,r0

mul r0,estadoBajo,periodo			@se hace regla de 3
mov r1,#100
bl division							@se llama a subrutina de division
mov estadoBajo,r0

cmp r7,#100							@compara para ver si la suma es 100
beq loop$							@si esto es correcto se va al loop

contador .req r7
mov contador, 0

alerta:
	ldr periodo,=500000 @ Se fija el el tiempo de 0.5s 
	mov r0,periodo @ Se carga a los registros y se llama a la subrutina que enciende y apaga el led
	mov r1,periodo
	bl astable	
	add contador, #1 @ Se aumenta el contador
	cmp contador, #3 @ El proceso se repite 3 veces
	bne alerta
	
	@ Se llama a la funcion que apaga el LED
	pinNum .req r0		
	pinVal .req r1
	mov pinNum,#47
	mov pinVal,#0
	bl SetGpio
	
apagado$:@ Ciclo infinito para acabar el pprograma
	b apagado$

loop$:
mov r0,estadoBajo @ Se guarda los tiempos en los registros que sirven de parametros.
mov r1,estadoAlto
bl astable							@se llama a la subrutina
b loop$