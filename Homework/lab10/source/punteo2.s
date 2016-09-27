/****************************
* Punteo
* Autor: Freddie Batlle
* Autor: Juan Luis Garcia
*
* Esta subrutina nos dice que punteo deberia de tener cada riro
*
* Parametros de entrada:
*	R0 : el 33.33 por ciento del radio mas grande
*	R1 : x del tiro
*	R2 : y del tiro
*	R3 : x de la diana
*	R4 : y de la diana
****************************/

.globl Punteo2
Punteo2:
	pop {r4,r9,r10,r11,r12}
	push {r4, r5, r6, r7, r8, r9, r10,r11}
	
	mov r9,r0
	mov r10,r1
	mov r11,r2
	mov r12,r3

	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	xdianamasnumero .req r5					/*Aqui se guarda la posicion de x de la diana para compararla y saber si esta dentro del circulo hacia la derecha*/
	xdianamenosnumero .req r6 				/*Aqui se guarda la posicion de x de la diana para compararla y saber si esta dentro del circulo hacia la izquierda*/
	ydianamasnumero .req r7					/*Aqui se guarda la posicion de y de la diana para compararla y saber si esta dentro del circulo hacia la arriba*/
	ydianamenosnumero .req r8						/*Aqui se guarda la posicion de y de la diana para compararla y saber si esta dentro del circulo hacia la abajo*/
	
	
	/***************************DAMOS VAROLES A LAS VARIABLES*********************************************/
	mov xdianamasnumero,#0
	mov xdianamenosnumero,#0
	mov ydianamasnumero,#0
	mov ydianamenosnumero,#0
	add xdianamasnumero,r12,r9  /*Sumamos a la diana el numero*/
	sub xdianamenosnumero,r12,r9  /*restamos a la diana el numero*/
	add ydianamasnumero,r4,r9  /*Sumamos a la diana el numero*/
	sub ydianamenosnumero,r4,r9  /*restamos a la diana el numero*/
	/******************************CirculoPequeno********************************************************/
	
	cmp r10,xdianamasnumero			/*comparamos con la derecha*/
	bgt mediano
	cmplt r10,xdianamenosnumero		/*comparamos con la izquierda*/
	blt mediano
	cmpgt r11,ydianamasnumero		/*comparamos para arriba*/
	bgt mediano
	cmplt r11,ydianamenosnumero		/*comparamos para abajo*/
	blt mediano
	movgt r0,#3						/*Si cumple con todas las condiciones regresa el mayor puntaje*/
	bgt fin2						/*finalizamos*/

mediano:	
	/***********SI NO CUMPLE NINGUNA DE ESTAS CONDICIONES PASAMOS AL OTRO CIRCULO***********************/
	/*Nuevamente le damos valores a los numeros con el 33.33 para tener el segundo circulo que se compone de un 66.66*/
	add xdianamasnumero,xdianamasnumero,r9  /*Sumamos a la diana el numero*/
	sub xdianamenosnumero,xdianamenosnumero,r9  /*restamos a la diana el numero*/
	add ydianamasnumero,ydianamasnumero,r9  /*Sumamos a la diana el numero*/
	sub ydianamenosnumero,ydianamenosnumero,r9  /*restamos a la diana el numero*/
	
	cmp r10,xdianamasnumero			/*comparamos con la derecha*/
	bgt grande
	cmplt r10,xdianamenosnumero		/*comparamos con la izquierda*/
	blt grande
	cmpgt r11,ydianamasnumero		/*comparamos para arriba*/
	bgt grande
	cmplt r11,ydianamenosnumero		/*comparamos para abajo*/
	blt grande
	movgt r0,#2						/*Si cumple con todas las condiciones regresa el mayor puntaje*/
	bgt fin2						/*finalizamos*/
	
grande:		
	/***********SI NO CUMPLE NINGUNA DE ESTAS CONDICIONES PASAMOS AL OTRO CIRCULO***********************/
	/*Nuevamente le damos valores a los numeros con el 66.66 para tener el segundo circulo que se compone de un 100*/
	add xdianamasnumero,xdianamasnumero,r9  /*Sumamos a la diana el numero*/
	sub xdianamenosnumero,xdianamenosnumero,r9  /*restamos a la diana el numero*/
	add ydianamasnumero,ydianamasnumero,r9  /*Sumamos a la diana el numero*/
	sub ydianamenosnumero,ydianamenosnumero,r9  /*restamos a la diana el numero*/
	
	cmp r10,xdianamasnumero			/*comparamos con la derecha*/
	bgt fin
	cmplt r10,xdianamenosnumero		/*comparamos con la izquierda*/
	blt fin
	cmpgt r11,ydianamasnumero		/*comparamos para arriba*/
	bgt fin
	cmplt r11,ydianamenosnumero		/*comparamos para abajo*/
	blt fin
	movgt r0,#1						/*Si cumple con todas las condiciones regresa el mayor puntaje*/
	bgt fin2						/*finalizamos*/
fin:	
	mov r0,#0 			/*Si no cumple con ninguna regresamos un cero en r0 para indicar que no dio en la diana*/
fin2: 	
	pop {r4, r5, r6, r7, r8, r9, r10,r11}
	mov pc,lr
		
	.unreq xdianamasnumero 							/*Aqui se guarda la posicion de x de la diana para compararla y saber si esta dentro del circulo hacia la derecha*/
	.unreq xdianamenosnumero						/*Aqui se guarda la posicion de x de la diana para compararla y saber si esta dentro del circulo hacia la izquierda*/
	.unreq ydianamasnumero							/*Aqui se guarda la posicion de y de la diana para compararla y saber si esta dentro del circulo hacia la arriba*/
	.unreq ydianamenosnumero 						/*Aqui se guarda la posicion de y de la diana para compararla y saber si esta dentro del circulo hacia la abajo*/

	