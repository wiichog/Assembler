		
/****************************
* DrawDiana
* Autor: Freddie Batlle
* Autor: Juan Luis Garcia
*
* Esta subrutina se basa en la subrutina drawcircle 
*
* Parametros de entrada:
*	R2: radio del circulo mas grande
*	R3: 1 si es un circulo relleno, 0 si no
****************************/


.globl DrawDiana
DrawDiana:
	push {r4, r5, r6, r7, r8, r9, r10,r11,r12,lr}
	
	
	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	x0 .req r4 					/*La coordenada en X del centro del circulo nombramos a r4 para no afectar el dato original*/
	y0 .req r5 					/*La coordenada en Y del centro del circulo nombramos a r5 para no afectar el dato original*/
	radiogrande .req r6 		/*El radio del circulo nombramos a r6 para no afectar el dato original*/
	radiomediano .req r7		/*Aqui guardaremos el segundo radio*/
	radiopequeno .req r8		/*Aqui guardaremos el tercer radio*/
	numeroarestar .req r9		/*Aqui se guardara el numero que se tendra que restar*/
	
	
	/******************************CIRCULO GRANDE********************************************************/
	/*Movemos los datos recibidos a los registros correspondientes para su futuro manejo*/
	mov x0, r0 					/*Movemos a la variable x0 la coordenada en x del centro del circulo*/
	mov y0, r1 					/*Movemos a la variable y0 la coordenada en y del centro del circulo*/
	mov radiogrande, r2 				/*Movemos a la variable radio el radio enviado por el usuario*/
	
	mov r11,radiogrande
	
	/*Aqio scmaos el 33.33 por ciento del radio para tener discos casi perfectos*/
	mov r10,#33
	mul radiogrande,r10
	
	/*mandamos a dividirlo entro de 100 para luego restarselo al radio grande*/
	
	mov r0,radiogrande			@Asignamos a r0 el mayor radio y asi obtendremos su 33..33%
	mov r1,#100					@asignamos a r1 el numero 100 por el porcentaje
	bl division					@llamammos a subturina
	mov numeroarestar,r0			@movemos el residuo de la division a la variable que guarda el numero a restar

	mov radiogrande,r11
	
	/******************************CIRCULO 	GRANDE********************************************************/
	/*Vamos a pintar de blanco el circulo mas grande*/
	ldr r0,=0b0000011111100000		/*Aqui pintamos de verde*/
	bl SetForeColour
	
	/*La posicion del centro de este circulo es en la esquina sup-derecha del a pantalla.*/
	mov r0, x0				/*X*/
	mov r1, y0				/*Y*/
	mov r2, radiogrande			/*Establecemos un radio de 200 pixeles*/
	mov r3, #1 					/*Mandamos 0 a R3 porque queremos que sea relleno*/
	bl DrawCircle 				/*LLamamos a la subrutina para dibujar el circulo.*/
	
	
	/******************************CIRCULO 	MEDIANO********************************************************/
	/*Vamos a pintar de blanco el circulo mas grande*/
	ldr r0,=0b1		/*Aqui pintamos de verde*/
	bl SetForeColour
	
	/*La posicion del centro de este circulo es en la esquina sup-derecha del a pantalla.*/
	mov r0, x0				/*X*/
	mov r1, y0				/*Y*/
	sub radiomediano,radiogrande,numeroarestar
	mov r2, radiomediano			/*Establecemos un radio de 200 pixeles*/
	mov r3, #1 					/*Mandamos 0 a R3 porque queremos que sea relleno*/
	bl DrawCircle 				/*LLamamos a la subrutina para dibujar el circulo.*/
	
	
	/******************************CIRCULO 	MEDIANO********************************************************/
	/*Vamos a pintar de blanco el circulo mas grande*/
	ldr r0,=0b0		/*Aqui pintamos de verde*/
	bl SetForeColour
	
	/*La posicion del centro de este circulo es en la esquina sup-derecha del a pantalla.*/
	mov r0, x0				/*X*/
	mov r1, y0				/*Y*/
	sub radiopequeno,radiomediano,numeroarestar
	mov r2, radiopequeno			/*Establecemos un radio de 200 pixeles*/
	mov r3, #1 					/*Mandamos 0 a R3 porque queremos que sea relleno*/
	bl DrawCircle 				/*LLamamos a la subrutina para dibujar el circulo.*/
	
	/*Tenemos que devolver el 33.33 por ciento en r0*/
	
	mov r0,numeroarestar
	
	pop {r4, r5, r6, r7, r8, r9, r10,r11,r12,pc}

		
		
						
	.unreq x0 			/*La coordenada en X del centro del circulo nombramos a r4 para no afectar el dato original*/
	.unreq y0 			/*La coordenada en Y del centro del circulo nombramos a r5 para no afectar el dato original*/
	.unreq radiogrande	/*El radio del circulo nombramos a r6 para no afectar el dato original*/
	.unreq radiomediano	/*Aqui guardaremos el segundo radio*/
	.unreq radiopequeno	/*Aqui guardaremos el tercer radio*/
	.unreq numeroarestar/*Aqui se guardara el numero que se tendra que restar*/
