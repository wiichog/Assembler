
@Subrutina que no recibe parametros, enciende los leds 7,9,11
.globl EncenderImpares
EncenderImpares:
	@CUARTA SECUENCIA
	@ENCENDIDO
	/* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#8
	mov r1,#1
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#10
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
	mov r0,#8
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#14
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#10
	mov r1,#0
	bl SetGpio
	
	mov pc,lr
	
@Subrutina que no recibe parametros, enciende los leds 8,10,14
.globl EncenderPares
EncenderPares:

@ENCENDIDO
	/* r0 = numero de puerto. r1 = 1 enciende el puerto, enciende el led */
	mov r0,#7
	mov r1,#1
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#11
	mov r1,#1
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#9
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
	mov r0,#11
	mov r1,#0
	bl SetGpio
	
	/* r0 = numero de puerto. r1 = 0 apaga el puerto, apaga el led */
	mov r0,#9
	mov r1,#0
	bl SetGpio
	
	mov pc,lr
