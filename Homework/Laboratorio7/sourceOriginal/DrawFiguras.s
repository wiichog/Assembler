/****************************
* DrawCircle
* Autor: Juan Diego Benitez
* Autor: Juan Luis Garcia
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


/****************************
* DrawCuadrado
* Autor: Juan Diego Benitez
* Autor: Juan Luis Garcia
*
* Esta subrutina dibuja un cuadrado ya sea relleno o vacio
*
* Parametros de entrada:
* 	R0: posicion en X de la esquina superior izquierda del cuadrado
*	R1: posicion en Y de la esquina superior izquierda del cuadrado
*	R2: ancho del cuadrado
*	R3: 1 si es un circulo relleno, 0 si no
*
****************************/

.globl DrawCuadrado
DrawCuadrado:

	push {r4, r5, r6, r7, r8, r9, r10}
	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	x0 .req r4 					/*La coordenada en X de la esquina superior izquierda del cuadrado*/
	y0 .req r5 					/*La coordenada en Y de la esquina superior izquierda del cuadrado*/
	ancho .req r6
	relleno .req r7				/*El "condicional" de que si esta relleno o no el circulo*/
	contadory .req r8


	/*Movemos los datos recibidos a los registros correspondientes para su futuro manejo*/
	mov x0, r0 					/*Movemos a la variable x0 la coordenada en x de la esqunia sup-izq del cuadrado*/
	mov y0, r1 					/*Movemos a la variable y0 la coordenada en y de la esquina sup-izq del cuadrado*/
	mov ancho, r2 				/*Movemos a la variable ancho el ancho enviado por el usuario*/
	mov relleno, r3 			/*Movemos a relleno el 1 o 0 enviado por el usuario*/
	mov contadory, #0 			/*Inicializamos el contador con 0*/

	cmp relleno, #1
	bne noRelleno

	Relleno:
		/*Basicamente se dibujan lineas horizontales. Solo varia y0*/
		mov r0, x0
		mov r1, y0
		add r2, x0, ancho
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		add y0, #1 				/*Bajamos un pixel*/
		add contadory, #1
		cmp contadory, ancho
		blt Relleno

		pop {r4, r5, r6, r7, r8, r9, r10}
		mov pc, lr

	noRelleno:
		/*Dibujamos la linea desde sup-izq hacia sup-der*/
		mov r0, x0
		mov r1, y0
		add r2, x0, ancho
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde sup-der hacia inf-der*/
		add r0, x0, ancho
		mov r1, y0
		add r2, x0, ancho
		add r3, y0, ancho
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-der hacia inf-izq*/
		add r0, x0, ancho
		add r1, y0, ancho
		mov r2, x0
		add r3, y0, ancho
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-der hacia inf-izq*/
		mov r0, x0
		add r1, y0, ancho
		mov r2, x0
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		pop {r4, r5, r6, r7, r8, r9, r10}
		mov pc, lr

	.unreq x0 					
	.unreq y0 					
	.unreq ancho
	.unreq relleno				
	.unreq contadory


/****************************
* DrawRectangulo
* Autor: Juan Diego Benitez
* Autor: Juan Luis Garcia
*
* Esta subrutina dibuja un rectangulo, ya sea relleno o vacio
*
* Parametros de entrada:
* 	R0: posicion en X de la esquina superior izquierda del cuadrado
*	R1: posicion en Y de la esquina superior izquierda del cuadrado
*	R2: ancho del rectangulo
*	R3: altura del rectangulo
*	Stack: 1 si es un circulo relleno, 0 si no
*
****************************/

.globl DrawRectangulo
DrawRectangulo:

	relleno .req r8				/*El "condicional" de que si esta relleno o no el circulo*/
	pop {relleno}

	push {r4, r5, r6, r7, r9, r10}
	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	x0 .req r4 					/*La coordenada en X de la esquina superior izquierda del renctangulo*/
	y0 .req r5 					/*La coordenada en Y de la esquina superior izquierda del rectangulo*/
	ancho .req r6 				/*El ancho del rectangulo*/
	altura .req r7 				/*La altura del rectangulo*/
	contadory .req r9


	/*Movemos los datos recibidos a los registros correspondientes para su futuro manejo*/
	mov x0, r0 					/*Movemos a la variable x0 la coordenada en x de la esqunia sup-izq del rectangulo*/
	mov y0, r1 					/*Movemos a la variable y0 la coordenada en y de la esquina sup-izq del rectangulo*/
	mov ancho, r2 				/*Movemos a la variable ancho el ancho enviado por el usuario*/
	mov altura, r3  			/*Movemos a la variable altura la altura enviada por el usuario*/
	mov contadory, r3 			/*Movemos tambien la altura al contadory*/				


	cmp relleno, #1
	bne noRelleno$

	Relleno$:
		/*Basicamente se dibujan lineas horizontales. Solo varia y0*/
		mov r0, x0
		mov r1, y0
		add r2, x0, ancho
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		add y0, #1 				/*Bajamos un pixel*/
		sub contadory, #1
		cmp contadory, #0
		bgt Relleno$

		pop {r4, r5, r6, r7, r9, r10}
		mov pc, lr

	noRelleno$:
		/*Dibujamos la linea desde sup-izq hacia sup-der*/
		mov r0, x0
		mov r1, y0
		add r2, x0, ancho
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde sup-der hacia inf-der*/
		add r0, x0, ancho
		mov r1, y0
		add r2, x0, ancho
		add r3, y0, altura
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-der hacia inf-izq*/
		add r0, x0, ancho
		add r1, y0, altura
		mov r2, x0
		add r3, y0, altura
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-der hacia inf-izq*/
		mov r0, x0
		add r1, y0, altura
		mov r2, x0
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		pop {r4, r5, r6, r7, r9, r10}
		mov pc, lr

	.unreq x0 					
	.unreq y0 					
	.unreq ancho
	.unreq altura
	.unreq relleno				
	.unreq contadory
	
	/****************************
* DrawTriangulo
* Autor: Juan Diego Benitez
* Autor: Juan Luis Garcia
*
* Esta subrutina dibuja un triangulo ya sea relleno o vacio
*
* Parametros de entrada:
* 	R0: posicion en X de la esquina superior izquierda del cuadrado
*	R1: posicion en Y de la esquina superior izquierda del cuadrado
*	R2: ancho del cuadrado
*	R4: 1 si es un circulo relleno, 0 si no
*	R3: Alto del triangulo

****************************/

.globl DrawTriangulo
DrawTriangulo:

	pop {r4}
	relleno .req r8				/*El "condicional" de que si esta relleno o no el triangulo*/
	mov relleno, r4 			/*Movemos a relleno el 1 o 0 enviado por el usuario*/

	push {r5, r6, r7, r8, r9, r10,r11}

	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	x0 .req r5 					/*La coordenada en X de la esquina superior izquierda del cuadrado*/
	y0 .req r6 					/*La coordenada en Y de la esquina superior izquierda del cuadrado*/
	ancho .req r7
	
	contadorx .req r9
	alto .req r10
	mitadancho .req r11

	

		/*Movemos los datos recibidos a los registros correspondientes para su futuro manejo*/
	mov x0, r0 					/*Movemos a la variable x0 la coordenada en x de la esqunia sup-izq del cuadrado*/
	mov y0, r1 					/*Movemos a la variable y0 la coordenada en y de la esquina sup-izq del cuadrado*/
	mov ancho, r2 				/*Movemos a la variable ancho el ancho enviado por el usuario*/
	mov alto, r3 				/*Movemos a alto lo que viene en r4*/
	mov contadorx, #0 			/*Inicializamos el contador con 0*/
	
	/* Llamamos a la subrutina de division para saber la mitad del ancho  */
	mov r0,ancho				@Asignamos a r0 el ancho
	mov r1,#2					@asignamos a r1 el numero 2 para que sea la mitad
	push {lr}
	bl division					@llamammos a subturina
	pop {lr}
	mov mitadancho,r0			@movemos el residuo de la division a la variable que es la mtiad del ancho
	
	cmp relleno, #1
	bne noLleno

	Lleno:
		/*Basicamente se dibujan lineas horizontales. Solo varia y0*/
		mov r0, x0				@posicion inicial en x
		mov r1, y0				@posicion inicial en y
		mov r2, mitadancho		@se tiene la mitad del ancho 
		mov r3, alto			@alto del triangulo
		push {lr}
		bl DrawLine				@llamamos a la subrutina que dibujara las lineas
		pop {lr}

		add x0, #1 				@nos movemos uno en x
		add contadorx, #1		@le agregamos 1 al contador para saber cuando parar
		sub r4,mitadancho,x0	@le restamos a la mitad del ancho la posicion inicial para saber cuanto mide una mitad del triangulo
		add r4,mitadancho,r4	@luego a esa mitad le sumamos la otra mitad para saber donde parar
		cmp contadorx, r4		@comparamos el contador con la suma
		blt Lleno				@si nos es igual repite el ciclo

		pop {r4, r5, r6, r7, r8, r9, r10,r11}
		mov pc, lr

	noLleno:
		/*Dibujamos la linea desde sup-izq hacia sup-der*/
		mov r0, x0
		mov r1, y0
		add r2, x0, ancho
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde sup-der hacia inf-der*/
		mov r0, ancho
		mov r1, y0
		mov r2, mitadancho
		mov r3, alto
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-der hacia inf-izq*/
		add r0, x0, ancho
		add r1, y0
		mov r2, mitadancho
		mov r3, alto
		push {lr}
		bl DrawLine
		pop {lr}

		pop {r4, r5, r6, r7, r8, r9, r10,r11}
		mov pc, lr

	.unreq x0 					
	.unreq y0 					
	.unreq ancho
	.unreq relleno				
	.unreq contadorx
	.unreq mitadancho
	
/****************************
* DrawRombo
* Autor: Juan Diego Benitez
* Autor: Juan Luis Garcia
*
* Esta subrutina dibuja un rombo, ya sea relleno o vacio, de altura 2N y ancho 2N + 1
*
* Parametros de entrada:
* 	R0: posicion en X de la esquina superior del triangulo
*	R1: posicion en Y de la esquina superior triangulo
*	R2: mitad de la altura del rombo
*	R3: 1 si es relleno, 0 si no
*
****************************/

.globl DrawRombo
DrawRombo:


	push {r4, r5, r6, r7, r8, r9, r10}
	/*Colocamos nombres a los registros r4, r5, r6, r7, r8 y r9 para facilitar el uso de ellos en las operaciones*/
	x0 .req r4 					/*La coordenada en X de la esquina superior del triangulo*/
	y0 .req r5 					/*La coordenada en Y de la esquina superior del triangulo*/
	altura .req r6 				/*La altura del triangulo*/
	contadory .req r7
	contadory2 .req r8
	offset .req r9 				/*Lo que se le va a sumar-restar para las posiciones iniciales y finales de la linea a dibujar*/
	mov offset, #0

	/*Movemos los datos recibidos a los registros correspondientes para su futuro manejo*/
	mov x0, r0 					/*Movemos a la variable x0 la coordenada en x de la esqunia superior del triangulo*/
	mov y0, r1 					/*Movemos a la variable y0 la coordenada en y de la esquina superior del triangulo*/
	mov altura, r2  			/*Movemos a la variable altura la altura enviada por el usuario*/
	mov contadory, r2 			/*Movemos tambien la altura al contadory*/
	mov contadory2, r2 			/*Movemos tambien la altura al contadory2*/				

	/*Comparamos para ver si es un triangulo relleno o no*/
	cmp r3, #1
	bne keineFullung

	Fullung:
		/*Basicamente se dibujan lineas horizontales que se les va cambiando de donde comienzan y donde terminan por una unidad, ademas se varia y0.*/
		sub r0, x0, offset
		mov r1, y0
		add r2, x0, offset
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		add y0, #1 				/*Bajamos un pixel*/
		add offset, #1
		sub contadory, #1
		cmp contadory, #0
		bgt Fullung

		Fullung2:
		/*Basicamente se dibujan lineas horizontales que se les va cambiando de donde comienzan y donde terminan por una unidad, ademas se varia y0.*/
		sub r0, x0, offset
		mov r1, y0
		add r2, x0, offset
		mov r3, y0
		push {lr}
		bl DrawLine
		pop {lr}

		add y0, #1 				/*Bajamos un pixel*/
		sub offset, #1
		sub contadory2, #1
		cmp contadory2, #0
		bgt Fullung2

		pop {r4, r5, r6, r7, r8, r9, r10}
		mov pc, lr

	keineFullung:
		/*Dibujamos la linea desde la punta hacia el primer lado izquierdo del rombo*/
		mov r0, x0
		mov r1, y0
		sub r2, x0, altura
		add r3, y0, altura
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde la punta hacia inf-der*/
		mov r0, x0
		mov r1, y0
		add r2, x0, altura
		add r3, y0, altura
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-der hacia la punta de abajo*/
		add r0, x0, altura
		add r1, y0, altura
		mov r2, x0
		add r3, y0, altura
		add r3, r3, altura
		push {lr}
		bl DrawLine
		pop {lr}

		/*Dibujamos la linea desde inf-izq hacia la punta de abajo*/
		sub r0, x0, altura
		add r1, y0, altura
		mov r2, x0
		add r3, y0, altura
		add r3, r3, altura
		push {lr}
		bl DrawLine
		pop {lr}

		pop {r4, r5, r6, r7, r8, r9, r10}
		mov pc, lr

	.unreq x0 					
	.unreq y0 					
	.unreq offset
	.unreq altura			
	.unreq contadory
	.unreq contadory2
	
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
		

	
	


