
.section .text



// ******************************************
// Subrutina para iniciar la animacion del personaje.
//     Anima un personaje hasta que se presione la tecla "Q" o "q"
// * No recibe parametros
// * No tiene salidas
// ******************************************
.globl Animacion
Animacion:
    push {r4-r11,lr}
	mov r11,#512
    paso_actual .req r4

    loopContinue$:


        // *******************************
        // 4 - actualizar al personaje
        // *******************************
		
		
		ldr r0, =abajo1Height
		mov r1,#1
		mov r2, #624
		bl drawImageWithTransparency

        ldr r0,=pistolab2Height
		mov r1,r11
		mov r2, #668
		bl drawImageWithTransparency
	
		ldr r0,=200000
		bl Wait
		
		ldr r0, =abajo1Height
		mov r1,#1
		mov r2, #624
		bl drawImageWithTransparency

		ldr r0,=pistolab3Height
		mov r1,r11
		mov r2, #668
		bl drawImageWithTransparency
		
		ldr r0, =abajo1Height
		mov r1,#1
		mov r2, #624
		bl drawImageWithTransparency

		ldr r0,=pistolab4Height
		mov r1,r11
		mov r2, #668
		bl drawImageWithTransparency

        // *******************************
		
    finAnimacion:

    // *******************************
    // 1 - borrar al personaje
    // *******************************
    
	ldr r0, =abajo1Height
	mov r1,#1
    mov r2, #624
    bl drawImageWithTransparency

	ldr r0,=pistolab1Height
	mov r1,r11
	mov r2, #668
	bl drawImageWithTransparency

	
    pop {r4-r11,pc}
    .unreq paso_actual




// ******************************************
// Subrutina para dibujar una imagen.
//    Utiliza DrawPixel y SetForeColour
//    Asume color transparente como 1
// * r0 direccion del personaje
//     * [r0+0] alto del personaje
//     * [r0+2] ancho del personaje
//     * [r0+4] primer pixel del personaje
// * r1 posicion x
// * r2 posicion y
// * salida ancho y alto r0,r1
// ******************************************
.globl drawImageWithTransparency
drawImageWithTransparency:

    addr        .req r4
    x           .req r5
    y           .req r6
    height      .req r7
    width       .req r8
    conth       .req r9
    contw       .req r10

    push {r4,r5,r6,r7,r8,r9,r10,lr}

    mov addr, r0
    mov x, r1
    mov y, r2
    mov conth, #0
    mov contw, #0

    ldrh height, [addr]
    add addr,#2
    ldrh width, [addr]
    add addr,#2

characterLoop$:
    ldrh r0, [addr]
    ldr r1,=0xFFFF     // validar transparencia
    cmp r0,r1
    beq noDraw$
    bl SetForeColour

    add r0, x, contw
    add r1, y, conth
    bl DrawPixel
noDraw$:
    add contw, #1
    cmp contw, width
    moveq contw, #0
    addeq conth, #1
    cmp conth, height
    moveq r0, width
    moveq r1, height
    popeq {r4,r5,r6,r7,r8,r9,r10,pc}
    add addr, #2
    b characterLoop$

    .unreq addr
    .unreq x
    .unreq y
    .unreq height
    .unreq width
    .unreq conth
    .unreq contw




// ******************************************
// Subrutina para dibujar una imagen.
//    Utiliza DrawPixel y SetForeColour
//    Asume color transparente como 1
// * r0 direccion del personaje
//     * [r0+0] alto del personaje
//     * [r0+2] ancho del personaje
//     * [r0+4] primer pixel del personaje
// * r1 posicion x
// * r2 posicion y
// * salida ancho y alto r0,r1
// ******************************************
.globl removeImageWithBrown
removeImageWithBrown:

    addr        .req r4
    x           .req r5
    y           .req r6
    height      .req r7
    width       .req r8
    conth       .req r9
    contw       .req r10

    push {r4,r5,r6,r7,r8,r9,r10,lr}

    mov addr, r0
    mov x, r1
    mov y, r2
    mov conth, #0
    mov contw, #0

    ldrh height, [addr]
    add addr,#2
    ldrh width, [addr]
    add addr,#2

characterLoopBrown$:
    ldrh r0, [addr]
    ldr r1,=0xFFFF    // validar transparencia
    ldr r0,=0xFE21    // color de fondo
    cmp r0,r1
    beq noDrawBrown$
    bl SetForeColour

    add r0, x, contw
    add r1, y, conth
    bl DrawPixel
noDrawBrown$:
    add contw, #1
    cmp contw, width
    moveq contw, #0
    addeq conth, #1
    cmp conth, height
    moveq r0, width
    moveq r1, height
    popeq {r4,r5,r6,r7,r8,r9,r10,pc}
    add addr, #2
    b characterLoopBrown$

    .unreq addr
    .unreq x
    .unreq y
    .unreq height
    .unreq width
    .unreq conth
    .unreq contw

.globl moveCircle
moveCircle:
	push {r4-r11,lr}
	mov r11,r0 /*x*/
	mov r5,r1	/*y*/

	
	ldr r0,=0xFE21
	bl SetForeColour
	
	mov r0,r11
	mov r1,r5
	mov r2,#10
	mov r3,#1
	bl DrawCircle

	pop {r4,r5,r6,r7,r8,r9,r10,r11,pc}
/****************************
* DrawCircle
* Autor: Juan Diego Benitez
* Autor : Juan Luis Garcia
*
* Esta subrutina dibuja un circulo ya sea relleno o vacio
*
* Parametros de entrada:
* 	R0: posicion en X del centro del circulo
*	R1: posicion en Y del centro del circulo
*	R2: radio del circulo
*	R3: 1 si es un circulo relleno, 0 si no
*
****************************/

.globl DrawCircle
DrawCircle:
	push {r4, r5, r6, r7, r8, r9, r10}
	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	x0 .req r4 					/*La coordenada en X del centro del circulo*/
	y0 .req r5 					/*La coordenada en Y del centro del circulo*/
	x .req r6 					
	y .req r7
	radio .req r8 				/*El radio del circulo*/
	relleno .req r9				/*El "condicional" de que si esta relleno o no el circulo*/
	radiusError .req r10 		

	mov y, #0 			/*Inicializamos y con el valor 0*/

	/*Movemos los datos recibidos a los registros correspondientes para su futuro manejo*/
	mov x0, r0 					/*Movemos a la variable x0 la coordenada en x del centro del circulo*/
	mov y0, r1 					/*Movemos a la variable y0 la coordenada en y del centro del circulo*/
	mov radio, r2 				/*Movemos a la variable radio el radio enviado por el usuario*/
	mov x, r2 					/*Movemos a la variable x el radio del circulo*/
	mov relleno, r3 			/*Movemos a relleno el 1 o 0 enviado por el usuario*/

	push {r0} 					/*Guardamos R0 en el stack*/
	mov r0, #1 					/*Movemos a 1 a R0*/
	sub radiusError, r0, x 		/*1 - x*/
	pop {r0} 					/*Regresamos R0 del stack*/

	cmp r3, #1 		/*Comparamos R3 con 1 para ver si se desea que sea un circulo relleno.*/
	bne noFill 		/*Si no se desea rellenarlo, nos vamos a noFill*/
	/*Si si se desea rellenar, se hace Fill*/
	Fill:

		/*Linea 1 del codigo en C*/

		mov r0, x0
		add r1, y, y0
		add r2, x, x0
		add r3, y, y0
		push {lr}
		bl DrawLine
		pop {lr}

		/*Linea 2 del codigo en C*/
		mov r0, x0
		add r1, x, y0
		add r2, y, x0
		add r3, x, y0
		push {lr}
		bl DrawLine
		pop {lr}

		/*Linea 3 del codigo en C*/
		mov r0, x0
		add r1, y, y0
		sub r2, x0, x 			/*Tal vez es radio en vez de x*/
		add r3, y, y0
		push {lr}
		bl DrawLine
		pop {lr}


		/*Linea 4 del codigo en C*/
		mov r0, x0
		add r1, x, y0
		sub r2, x0, y
		add r3, x, y0
		push {lr}
		bl DrawLine
		pop {lr}

		/*Linea 5 del codigo en C*/
		mov r0, x0
		sub r1, y0, y
		sub r2, x0, x
		sub r3, y0, y
		push {lr}
		bl DrawLine
		pop {lr}

		/*Linea 6 del codigo en C*/
		mov r0, x0
		sub r1, y0, x
		sub r2, x0, y
		sub r3, y0, x
		push {lr}
		bl DrawLine
		pop {lr}

		/*Linea 7 del codigo en C*/
		mov r0, x0
		sub r1, y0, y
		add r2, x, x0
		sub r3, y0, y
		push {lr}
		bl DrawLine
		pop {lr}

		/*Linea 8 del codigo en C*/
		mov r0, x0
		sub r1, y0, x
		add r2, x0, y
		sub r3, y0, x
		push {lr}
		bl DrawLine
		pop {lr}

		add y, #1

		/*if (radiusError<=0*/
		cmp radiusError, #0

		push {r0}
		push {r2}
		mov r0, #2
		mul r2, r0, y
		add r2, #1
		addeq radiusError, r2
		addlt radiusError, r2
		pop {r2}
		pop {r1}



		/* else */
		subgt x, #1
		push {r0}
		mov r0, #2
		push {r2}
		sub r2, y, x
		mul r2, r0
		add r2, #1
		addgt radiusError, r2  			/*Solo este se ve afectado por el cmp*/
		pop {r2}
		pop {r0}

		/* while y<= x */
		cmp y, x
		blt Fill
		beq Fill

		/*Si ya se termino el While, regresamos a donde fue llamada la subrutina*/
		pop {r4, r5, r6, r7, r8, r9, r10}
		mov pc,lr


	/*Si no se quiere que el circulo se rellene*/
	noFill:

		/*Linea 1 del codigo en C*/
		add r0, x, x0
		add r1, y, y0
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 2 del codigo en C*/
		add r0, y, x0
		add r1, x, y0
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 3 del codigo en C*/
		sub r0, x0, x
		add r1, y, y0
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 4 del codigo en C*/
		sub r0, x0, y
		add r1, x, y0
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 5 del codigo en C*/
		sub r0, x0, x
		sub r1, y0, y
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 6 del codigo en C*/
		sub r0, x0, y
		sub r1, y0, x
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 7 del codigo en C*/
		add r0, x, x0
		sub r1, y0, y
		push {lr}
		bl DrawPixel
		pop {lr}

		/*Linea 8 del codigo en C*/
		add r0, y, x0
		sub r1, y0, x
		push {lr}
		bl DrawPixel
		pop {lr}

		add y, #1 				/*y++;*/

		/*if (radiusError<=0*/
		cmp radiusError, #0
		push {r0}
		push {r2}
		mov r0, #2
		mul r2, r0, y
		add r2, #1
		addeq radiusError, r2
		addlt radiusError, r2
		pop {r2}
		pop {r1}

		/*Verificar si las banderas no han sido modificadas hasta aqui*/
		/* else */
		subgt x, #1
		push {r0}
		mov r0, #2
		push {r2}
		sub r2, y, x
		mul r2, r0
		add r2, #1
		addgt radiusError, r2  			/*Solo este se ve afectado por el cmp*/
		pop {r2}
		pop {r0}

		/* while y<= x */
		cmp y, x
		blt noFill
		beq noFill

		/*Si ya se termino el While, regresamos a donde fue llamada la subrutina*/
		pop {r4, r5, r6, r7, r8, r9, r10}
		mov pc,lr

	.unreq x0 					
	.unreq y0 					
	.unreq x
	.unreq y			
	.unreq radio
	.unreq relleno
	.unreq radiusError


	
.globl transpa
transpa:
	POP {R4}
	PUSH {R4-R7,lr}						
	PosInicialX .req R0					
	PosInicialY .req R1
	alto .req R2
	ancho .req R3
	imagen .req R4
	CMP PosInicialX,#1024				
	CMPLS PosInicialY,#768				
	CMPLS alto,#768
	CMPLS ancho,#1024
	BLS OK2								
	
	POP {R4-R7, pc}						 

OK2: 
	fbInfoAddr .req R5					
	LDR fbInfoAddr,=FrameBufferInfo	
	fbAddr .req R6
	LDR fbAddr,[fbInfoAddr,#32]
	.unreq fbInfoAddr
	
	color .req R5						
	
	MOV R7, #1024						
	MUL R7,PosInicialY					
	.unreq PosInicialY
	ADD R7,PosInicialX					
	.unreq PosInicialX
	ADD R7,R7							
	ADD fbAddr,R7						
	ADD imagen,R7						
	
	countByte .req R0					
	MOV countByte,#0					
	MOV R1,ancho
	
	MOV R7, #1024						
	SUB R7,ancho						
	ADD R7,R7							
	DibujarLinea2:
		MOV ancho,R1
		DibujarPixel2:
			LDRH color,[imagen,countByte]		
			STRH color, [fbAddr]				
			ADD fbAddr,#2						
			ADD countByte,#2					
			SUB ancho,#1						
			
			TEQ ancho, #0						 
			BNE DibujarPixel2
		ADD fbAddr, R7							
		ADD imagen, R7							
		SUB alto, #1														
		TEQ alto, #0							
		BNE DibujarLinea2						
		.unreq alto						 
		.unreq ancho
		.unreq imagen
		.unreq fbAddr
		.unreq color
		.unreq countByte
		POP {R4-R7, pc}					

/* ***************************************************************** 
   division.s
   Subrutina que calcula el cociente de dos numeros en memoria.
   
   Uso de registros:
   r0: envio de parametro dividendo para subrutinas division, 
   r1: envio de parametro divisor para subrutinas division
   ***************************************************************** */
.text
.align 2

@Subrutina que calcula el cociente  de dos numeros
@Parametros de entrada:
@r0: dividendo
@r1: divisor
@Parametros de salida
@r0: cociente
.global division
division:
	push {r4-r12,lr}
	
	mov r2,#-1	@negativo el valor del divisor
	mul r1,r2	
	and r3,#0	@inicializar en cero r3
	
ciclo:
	add r3,#1	@incrementa en 1 el valor del cociente
	add r0,r1	@resta al dividendo el valor del divisor
	cmp r0,#0	@es mayor que cero?
	bgt	ciclo	@si, realizar nuevamente la resta
	mov r0,r3	@no, mover valor de cociente a r0
	
	pop {r4-r12,pc}


