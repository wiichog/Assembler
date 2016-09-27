/****************************
* Autor: Martin Guzman
*
* Esta subrutina divide dos numeros
*
* Parametros de entrada:
* 	R0: dividendo
*	R1: divisor

****************************/
	.globl division
division:
	contador 	.req r2 
	divisor	 	.req r1
	dividendo	.req r0
		mov contador,#0	@inicializar contador
ciclo:
		cmp divisor, dividendo
		bgt fin
		sub dividendo,divisor
		add contador,#1
		b ciclo
fin:
		.unreq contador 
		.unreq dividendo
		.unreq divisor
		mov r1,r0	@guarda el residuo
		mov r0,r2 	@guarda el cociente
		mov pc,lr
		
/****************************
* Autor: Juan Luis Garcia 	14189
*
* Esta subrutina dibuja a charmander segun el color que le manden
*
* Parametros de entrada:
* 	R0: color
*	R1: posicion

****************************/
	.globl DibujarCharmander1
DibujarCharmander1:
	push {lr}
	posicion	 	.req r5
	colour .req r10
	/*Seteamos el color*/
	mov colour, #0b0000011111100000			@MOVEMOS A COLOUR EL COLOR verde
	mov r0,colour
	bl SetForeColour
	mov posicion,r1
	/*Dibujar Charmander1*/		
	ldr r0,=charmander1				/*Cargamos a charmander en r0*/
	ldr r1,=charmander1Length		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,posicion						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString
	pop {pc}
	
/****************************
* Autor: Juan Luis Garcia 	14189
*	
* Esta subrutina dibuja a charmander segun el color que le manden
*
* Parametros de entrada:
* 	R0: color
*	R1: posicion

****************************/
	.globl DibujarCharmander2
DibujarCharmander2:
	posicion	 	.req r5
	color	.req r0
	mov colour, color
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour
	mov posicion,r1					/*Guardamos en posicion el valor que venia en r1*/
	/*Dibujar Charmander2*/		
	ldr r0,=charmander2				/*Cargamos a charmander en r0*/
	ldr r1,=charmander2Length		/*Cargamos el length de charmander en r0*/
	ldr r1,[r1]
	mov r2,posicion						/*Aqui manejaremos el movimiento de charmander en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento de charmander en el eje y*/
	bl DrawString
	
/****************************
* Autor: 	Miguel Godoy Garin	14425
* Esta subrutina dibuja el nombre de Miguel Godoy
*
* Parametros de entrada:
* 	R0: color
*	R1: posicion

****************************/
	.globl DibujarMiguel
DibujarMiguel:
	posicion	.req r5
	color		.req r0
	colour 		.req r10		
	mov colour, color
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour
	
	/*Dibujar nombre de Miguel*/		
	ldr r0,=MiguelGodoy					/*Cargamos el nombre en r0*/
	ldr r1,=MiguelGodoyLength			/*Cargamos el length del nombre en r1*/
	ldr r1,[r1]
	mov r2,posicion						/*Aqui manejaremos el movimiento del nombre en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento del nombre en el eje y*/
	bl DrawString
	
	/****************************
* Autor: 	Miguel Godoy Garin	14425
* Esta subrutina dibuja el nombre de Miguel Godoy
*
* Parametros de entrada:
* 	R0: color
*	R1: posicion

****************************/
	.globl DibujarJuanLuis
DibujarJuanLuis:
	posicion	.req r5
	color		.req r0
	colour 		.req r10		
	mov colour, color
	mov r0, colour
	/*Seteamos el color*/
	bl SetForeColour
	
	/*Dibujar nombre de Miguel*/		
	ldr r0,=JuanLuis					/*Cargamos el nombre en r0*/
	ldr r1,=JuanLuisLength			/*Cargamos el length del nombre en r1*/
	ldr r1,[r1]
	mov r2,posicion						/*Aqui manejaremos el movimiento del nombre en el eje x*/
	mov r3,#0						/*Aqui manejaremos el movimiento del nombre en el eje y*/
	bl DrawString