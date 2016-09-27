@Universidad del valle de Guatemala
@Juan Luis Garcia 14189
@Patrick
@Taller de Assembler Seccion 11
@Ejercicio 2
.section .text 	
.globl delay1

@r0: Numero a Restar

delay1:
		cmp r0,#0					@compara si es igual a cero
		subgt	r0,r0,#11			@le resta 1 si es mayor a cero
		bgt apagar					@si es mayor lo envia a apagar donde se apaga el led
		bgt delay1					@si es mayor repite el ciclo
		mov pc,lr
			
apagar:
		mov sp,#0x8000
		ldr r0,=0x20200000		@carga la direccion fisica del puerto a r0
		mov r1,#1
		lsl r1,#18
		str r1,[r0,#4]			@se selecciona la opcion seleccion
		mov r1,#1
		lsl r1,#16				@se copia el bit a r1
		str r1,[r0,#28]			@apaga el led
		b delay1
		
apagarturon:
		mov sp,#0x8000
		ldr r0,=0x20200000		@carga la direccion fisica del puerto a r0
		mov r1,#1
		lsl r1,#18
		str r1,[r0,#4]			@se selecciona la opcion seleccion
		mov r1,#1
		lsl r1,#16				@se copia el bit a r1
		str r1,[r0,#28]			@apaga el led
		b turnon
		
encender:
		mov sp,#0x8000
		ldr r0,=0x20200000		@carga la direccion fisica del puerto a r0
		mov r1,#1
		lsl r1,#18
		str r1,[r0,#4]			@se selecciona la opcion seleccion
		mov r1,#1
		lsl r1,#16				@se copia el bit a r1
		str r1,[r0,#40]			@enciende el led
		b turnon

.globl	turnon
turnon:
	cmp r0,#1					@compara si r0 es un uno
	beq encender				@si es uno lo enciende
	bne	apagar					@si no es uno lo apaga
	b turnon					@se repite el ciclo
	mov pc,lr
	.globl	seg5
	
seg5:
	cmp r2,#0
	subgt r2,r2,#1
	bgt seg5
	mov r4,#4
	b veces5
	
veces5:
	mov r2,#0xff00000
	str r1,[r0,#40]
	b delay
	mov r2,#0xff00000
	str r1,[r0,#28]
	b delay
	cmp r4,#0
	bgt veces5
	mov pc,lr

delay:
	subgt r2,r2,#1
	cmp r2,#0
	bne delay
	beq veces5