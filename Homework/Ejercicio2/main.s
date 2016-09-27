/*Universidad Del Valle de Guatemala

@Patrick Ordoñez 131062
@Ejercicio #2*/

.section .init

.globl _start
_start:
	b main
.section .text /*inicio 0x8000*/
main:
mov sp,#0x8000
	ldr r0,=0x20200000
	
	mov r1,#1 
	lsl r1,#18
	str r1,[r0,#4]
	mov r1,#1
	lsl r1,#16
	str r1,[r0,#40]
	mov r2,#0xff000000
	bl seg5					@llamado a subrutina
	mov r0,#20				@se envia a r0 un veinte
	bl delay1				@llamado a subrutina
	bl turnon				@llamdo a subrutina
	loop$: 					@se repite para siempre
	mov r0,#1
	bl turnon				@llamado a subrutina
	mov r0,#0
	bl turnon				@llamado a subrutina
	b loop$
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
	/*beq "siguiente loop aqui"*/
	mov pc,lr

delay:
	subgt r2,r2,#1
	cmp r2,#0
	bne delay
	beq veces5
	