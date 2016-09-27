.section .init
.globl _start
_start:

b main

.section .text

/*
	r0-r5 en uso para enviar datos
	r8: fbInfoAddr
	
	En subrutina
	r6: color
	r7: addrPixel 
	r9: countByte
	r10: para la operacion 
	r11: cargar valor 1024 para la operacion (anchoPantalla  - anchoImagen)*2
	r12: se carga el valor con ancho imagen
	
	

*/

main:
	mov sp,#0x8000
	mov r0,#1024
	mov r1,#768
	mov r2,#16
	bl InitialiseFrameBuffer

	teq r0,#0
	bne noError$
		
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

	mov r0,#16
	mov r1,#0
	bl SetGpio

	error$:
		b error$

	noError$:

	fbInfoAddr .req r8
	mov fbInfoAddr,r0
		

		x .req r0
		y .req r1
		alto .req r2
		ancho .req r3
		personaje .req r4
		fbAddr .req r5
	
	mov r6,#0
	mov r11,#0
	mov r12,#0
	
	
	mov x,#0
	mov y,#0
	cargarfondo$:

		ldr personaje,=fondo
		ldr alto,=fondoHeight
		ldr ancho,=fondoWidth
		ldr y,=fondoHeight
		ldr x,=fondoWidth
		
		ldr fbAddr,[fbInfoAddr,#32 ]	
		

		push {r4}
		push {r5}
		bl drawImage
		cmp y, #0
		moveq x,#0
		moveq y,#0
		beq cargarPersonaje$
		
	
	
	cargarPersonaje$:
		
		ldr personaje,=mechari
		ldr ancho,=mechariWidth
		ldr y,=mechariHeight
		ldr x,=mechariWidth
			
		ldr fbAddr,[fbInfoAddr,#32]	
		
		mov r7,#2
		mov r9,#1024
		mov r10,#0
		mul r10,r11,r9
		add r10,r12
		mul r10,r7
		add fbAddr, r10
		push {r4}
		
		push {r5}	
		
		bl drawImage
		
		
		
		cmp y, #0
		addeq r11,#5
		addeq r12,#7
		
		
		ldr r0,=100
		bl Wait
		cmp r11,#652
		movgt r11,#0
		movgt r12,#0
		b cargarfondo$
		
	b cargarPersonaje$	
		
	cargarPersonaje$:
		
		ldr personaje,=mechari
		ldr ancho,=mechariWidth
		ldr y,=mechariHeight
		ldr x,=mechariWidth
			
		ldr fbAddr,[fbInfoAddr,#32]	
		
		mov r7,#2
		mov r9,#1024
		mov r10,#0
		mul r10,r11,r9
		add r10,r12
		mul r10,r7
		add fbAddr, r10
		push {r4}
		
		push {r5}	
		
		bl drawImage
		
		
		
		cmp y, #0
		addeq r11,#5
		addeq r12,#7
		
		
		ldr r0,=100
		bl Wait
		cmp r11,#652
		movgt r11,#0
		movgt r12,#0
		b cargarfondo$
		
	b cargarPersonaje$	
		
		
	.unreq fbAddr
	.unreq y
	.unreq x
	.unreq alto
	.unreq ancho
	.unreq personaje
		