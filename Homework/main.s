@UNIVERSIDAD DEL VALLE DE GUATEMALA
@TALLER DE ASSEMBLER
@SECCION 11
@LABORATORIO #8
@FREDDY JOSE RUIZ GATICA 14592
@MAIN DEL PROGRAMA
@--------------------------------------------------------------------------------------------
@							ESTE PROGRAMA TIENE COMO FUNCION DIBUJAR EN 
@							PANTALLA UN PERSONAJE MOVIENDOSE A LA DERECHA.
@							AL MOMENTO QUE ESTE SALE DE LA PANTALLA, MUESTRA
@							EL NOMBRE DE LOS DOS INTEGRANTES.
@--------------------------------------------------------------------------------------------
.section .init
.globl _start
_start:


b main
.section .text
@-------------------------------------------- INICIO DEL PROGRAMA ----------------------------------------------
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
@-------------------------------------- ERROR AL INICIALIZAR FRAMEBUFFER ---------------------------------------------
	error$:
		b error$
@------------------------------------- SIN ERROR AL INICIALIZAR FRAMEBUFFER--------------------------------------------
	noError$:

	fbInfoAddr .req r4
	mov fbInfoAddr,r0

@---------------------------------------SE ALMACENA LA DIRECCION DE LA INFO DEL FB---------------------------------
	bl SetGraphicsAddress 
	

@------------------------------------------COlOCACION DE ALIAS-------------------------------------------------------
    despx .req r7
    mov despx, #0

@-----------------------------------------TRAZO DEL MOVIMIENTO DEL PERSONAJE---------------------------------------
loop$:
	LDR R0,=0xFFFF	@COLOR VERDE 
    BL SetForeColour
@-------------------------------TRAZO DEL PRIMER SPRITE------------------------
	ldr r0, = jake1
	ldr r1, = jake1Length
	ldr r1,[r1]
	mov r2, despx
	mov r3, #0

	bl DrawString
@-----------------------------------RETRASO---------------------------------------
	ldr r0, = 10000
	bl Wait
@--------------------------------CAMBIO DE COLOR A NEGRO------------------------------
	LDR R0,=0x0000	@COLOR NEGRO
    BL SetForeColour	
@------------------------------------BORRADO DEL PRIMER SPRITE-------------------------
	ldr r0, = jake1
	ldr r1, = jake1Length
	ldr r1,[r1]
	mov r2, despx
	mov r3, #0

	bl DrawString
@-----------------------------------RETRASO---------------------------------------
	ldr r0, =10000
	bl Wait

	LDR R0,=0xFFFF	@COLOR VERDE 
    BL SetForeColour
@-------------------------------TRAZO DEL SEGUNDO  SPRITE---------------------------
	ldr r0, = jake2       @Direccion de la imagen
	ldr r1, = jake2Length  @Longitud de la cadena
	ldr r1,[r1]             
	mov r2, despx              @POSX
	mov r3, #0                @POSY

	bl DrawString

	ldr r0, =10000
	bl Wait
	LDR R0,=0x0000	@COLOR NEGRO
    BL SetForeColour
@------------------------------BORRADO DEL SEGUNDO SPRITE---------------------------	
	ldr r0, = jake2       @Direccion de la imagen
	ldr r1, = jake2Length  @Longitud de la cadena
	ldr r1,[r1]             
	mov r2, despx              @POSX
	mov r3, #0                @POSY

	bl DrawString

	ldr r0, =10000
	bl Wait

	cmp despx, #1024
	ADDLE despx, #5
	ble loop$

@------------------------------TRAZO DE LOS NOMBRES---------------------------------
	LDR R0,=0xFFFF	@COLOR BLANCO 
    BL SetForeColour

	ldr r0, = texto1       @DIRECCION DE LA IMAGEN
	ldr r1, = texto1Length  @LONGITU DE LA CADENA
	ldr r1,[r1]             
	ldr r2, = 394              @POSX
	ldr r3, =384               @POSY
	bl DrawString

@--------------------------------RETARDO DE 2 SEGUNDOS-------------------------------
 	ldr r0,= 2000000
	bl Wait
	mov despx, #0

	LDR R0,=0x0000	@COLOR NEGRO
    BL SetForeColour

    ldr r0, = texto1       @Direccion de la imagen
	ldr r1, = texto1Length  @Longitud de la cadena
	ldr r1,[r1]             
	ldr r2, = 394              @POSX
	ldr r3, =384               @POSY
	bl DrawString

	b loop$
