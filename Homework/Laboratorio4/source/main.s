/**
* Programa para encender un LED en el GPIO 7 del Raspberry
* Por: Juana Rivera
* 24 junio 2013
*/

.section .init
.globl _start
_start:

b main

@ -----------------------------------------------
@ Macro para encender o apagar un led.
@ Utiliza la funcion SetGpio de gpio.s
@ Recibe:
@     puerto = cualquier puerto valido del GPIO
@     valor = 1 o 0 para setear en el puerto
@ -----------------------------------------------
.macro EncenderTodosLeds valor
    /* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#7
	mov r1,\valor
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#8
	mov r1,\valor
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#9
	mov r1,\valor
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#10
	mov r1,\valor
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#11
	mov r1,\valor
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#14
	mov r1,\valor
	bl SetGpio
	/* Delay */
	ldr r0,=500000
	bl Wait
.endm
.section .text

main:
	mov sp, #0x8000
	
	@Se manda funcion de escritura a todos los puertos que utilizaremos
	
	mov r0,#7
	mov r1,#1
	bl SetGpioFunction
	
	/* selecciona la funcion escribir en el puerto 8*/
	mov r0,#8
	mov r1,#1
	bl SetGpioFunction
	
	mov r0,#9
	mov r1,#1
	bl SetGpioFunction
	
	mov r0,#10
	mov r1,#1
	bl SetGpioFunction
	
	mov r0,#11
	mov r1,#1
	bl SetGpioFunction
	
	mov r0,#14
	mov r1,#1
	bl SetGpioFunction
infinito:
	@PRIMERA SECUENCIA 
	@ENCENDIDO
	/* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#9
	mov r1,#1
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#10
	mov r1,#1
	bl SetGpio
	
	/* Delay */
	ldr r0,=500000
	bl Wait
	@APAGADO
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#9
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#10
	mov r1,#0
	bl SetGpio

	
	@Segunda Secuencia
	
	/* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#8
	mov r1,#1
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#11
	mov r1,#1
	bl SetGpio
	
	/* Delay */
	ldr r0,=500000
	bl Wait
	@APAGADO
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#8
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#11
	mov r1,#0
	bl SetGpio
	
	
	@TERCERA SECUENCIA
	
	/* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#7
	mov r1,#1
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#14
	mov r1,#1
	bl SetGpio
	
	/* Delay */
	ldr r0,=500000
	bl Wait
	@APAGADO
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#7
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#14
	mov r1,#0
	bl SetGpio
	
	@CUARTA Secuencia
	bl EncenderImpares
		

	@QUINTA SECUENCIA
	bl EncenderPares
	
	@CUARTA Secuencia
	bl EncenderImpares
		

	@QUINTA SECUENCIA
	bl EncenderPares
	
	@SEXTA SECUENCIA
	EncenderTodosLeds    #0
	
	@SEPTIMA SECUENCIA
	EncenderTodosLeds    #1	
	
	@OCTAVA SECUENCIA
	EncenderTodosLeds    #0
	
	@NOVENA SECUENCIA
	EncenderTodosLeds    #1
	
	@DECIMA SECUENCIA
	@ENCENDIDO
	/* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#7
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#14
	mov r1,#0
	bl SetGpio
	
	/* Delay */
	ldr r0,=500000
	bl Wait
	
	
	
	@Final
	EncenderTodosLeds #0
	
	
	b infinito