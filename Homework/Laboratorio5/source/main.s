/*
* Universidad del Valle de Guatemala
* Juan Luis Garcia
* Betti Rodas
* Lab 5
* 04/09/2015
**/

.section .init
.globl _start
_start:

b main
.section .text
/**************************************MACROS A UTILIZAR ****************************************/
.macro ConfigurarLed numeroPuerto 					@@Configura el numero de puerto
	mov r0,\numeroPuerto
	mov r1,#1
	bl SetGpioFunction
.endm
.macro EncenderLed numeroPuerto						@@Enciende el led indicado
	mov r0,\numeroPuerto
	mov r1,#0
	bl SetGpio
.endm
.macro ApagarLed numeroPuerto 						@@Apaga el led indicado
	mov r0,\numeroPuerto
	mov r1,#1
	bl SetGpio
.endm
.macro AumentarVelocidad Tiempo 						@@Apaga el led indicado
	ldr r0,\numeroPuerto
	bl Wait
.endm

/**************************************MACROS A UTILIZAR ****************************************/


main:
	@@Por la forma en la que codificamos aveces utilizamos los registros en los que tenemos los pines de los botones por lo que se aclara aqui
	@@pin 14 -->  Boton para cambiar secuencias
	@@pin 15 -->  Boton de reinicio
	@@pin 16 -->  Aumentar la Velocidad

	mov sp, #0x8000
	mov r0,#14										@@Se configuran los botones como entrada
	mov r1,#0
	bl SetGpioFunction
	mov r0,#15										
	mov r1,#0
	bl SetGpioFunction
	mov r0,#16										
	mov r1,#0
	bl SetGpioFunction


	ConfigurarLed    #7 							@@Se configuran los leds como salidas
	ConfigurarLed    #8
	ConfigurarLed    #11

													@@Direccion GPIO
	mov r0, #14
	bl GetGpioAddress
	mov r4,r0	

	mov r0, #15
	bl GetGpioAddress
	mov r10,r0	
	
	mov r0, #16
	bl GetGpioAddress
	mov r8,r0	

	mov r6,#2										@@Contador que lleva control de el cambio de secuencia a secuencia
	mov r9,#1 										@@Contador que lleva control de si es la primera vez que se apacha el boton
									
revisarBoton:										@@Se revisa si el boton ha sido presionado. Como es logica inversa se busca un 0 logico
	bl Reinicio
	ldr r5,[r4,#0x34]
	mov r0,#1
	lsl r0,#14
	and r5,r0 
	teq r5, #0 										
	moveq r9, #3 									@De haber sido presionado se cambia el contador para que no vuelva a comportarse de esa manera (Apaga todo primero)
	beq cambiarSecuencia							@@Cambia el contador que lleva control de la secuencia en la que se esta
	cmp r9, #1 										@@De no haber sido apachado
	beq apagarTodos 								@@Mantiene los leds apagados
	@Configuracion 2do Boton Acelerar
	ldr r5,[r8,#0x34]
	mov r0,#1
	lsl r0,#14
	and r5,r0 
	teq r5, #0 										
	beq MasRapido
	b Secuencias									@@Salta a secuencias
	
MasRapido:
	cmp r6, #1 										@@Compara con 1 
	movne r6, #1 									@@Si no es uno lo cambia a uno
	ldrne r7,=50000									@@Tiempo de la rutina
	moveq r6, #2 									@@Si es uno lo cambia a dos
	ldreq r7,=50000									@@Tiempo de la rutina
	b Secuencias 									@@Salta a secuencias
	

cambiarSecuencia: 									@@Si se apacha el boton cambia de una secuencia a la otra
	cmp r6, #1 										@@Compara con 1 
	movne r6, #1 									@@Si no es uno lo cambia a uno
	ldrne r7,=500000								@@Tiempo de la rutina
	moveq r6, #2 									@@Si es uno lo cambia a dos
	ldreq r7,=500000								@@Tiempo de la rutina
	b Secuencias 									@@Salta a secuencias


Secuencias:
		cmp r6,#1
		beq Secuencia1
		b Secuencia2
		
Secuencia1:
		EncenderLed   #7
		ApagarLed   #8
		ApagarLed   #11
		ldr r0,[r7]
		bl Wait
		EncenderLed   #7
		EncenderLed   #8
		ApagarLed   #11
		ldr r0,[r7]
		bl Wait
		EncenderLed   #7
		EncenderLed   #8
		EncenderLed   #11
		ldr r0,[r7]
		bl Wait
		b revisarBoton
	
Secuencia2:
		EncenderLed   #7
		ApagarLed   #8
		ApagarLed   #11
		ldr r0,[r7]
		bl Wait
		ApagarLed   #7
		EncenderLed   #8
		ApagarLed   #11
		ldr r0,[r7]
		bl Wait
		ApagarLed   #7
		ApagarLed   #8
		EncenderLed   #11
		ldr r0,[r7]
		bl Wait
		b revisarBoton
		@@teq r5,#0
		@@moveq r6,#1
		@@b Secuencias
	
apagarTodos:
	ApagarLed   #7
	ApagarLed   #8
	ApagarLed   #11
	ldr r0,[r7]
	bl Wait

	b revisarBoton	
	
Reinicio:
	ldr r5,[r4,#0x34]
	mov r0,#1
	lsl r0,#15
	and r5,r0 
	teq r5, #0
	moveq r9,#1
	mov pc, lr 
	
	
	