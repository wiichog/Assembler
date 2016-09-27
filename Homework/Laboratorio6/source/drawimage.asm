.globl drawimage
drawimage: 
	pop {r5}
	pop {r4}
	push {lr}
		fbAddr .req r5
		ldr fbAddr,[fbInfoAddr,#32]
		
		colour .req r0
		y .req r1
		
		//Inicializamos el contador 'y' con el alto de la imagen de Mario
		ldr y,=mecoboyHeight
		ldrh y,[y]
		
		addrPixel .req r4
		countByte .req r6
		mov countByte,#0 	//Contador que cuenta la cantidad de bytes del mario dibujados
		
		//Ciclo que dibuja filas
		drawRow$:
			x .req r3
			ldrh x,[x]
			
			drawPixel$:
				ldrh colour,[addrPixel,countByte]	//Leemos dato de matriz. Dato = direccionBaseFoto + bytesDibujados
				strh colour,[fbAddr]				//Almacenamos en el frameBuffer.
				add fbAddr,#2 						//Incrementamos el frame buffer para dibujar el siguiente pixel.
				add countByte,#2 					//Incrementamos los bytes dibujados en dos (ya dibujamos 2 bytes)
				sub x,#1 							//Decrementamos el contador del ancho de la imagen
			
				//Revisamos si ya dibujamos toda la fila
				teq x,#0
				bne drawPixel$
			
			//Calculamos la direccion del frameBuffer para dibujar la siguiente linea
			//Direccion siguiente linea = (Ancho de la pantalla - ancho de la imagen) * Bytes/pixel 
			ldr r7,=1848 	//(1024-100)*2=1848
			add fbAddr,r7	//Le sumamos al frameBuffer la cantidad calculada para bajar de linea
			
			//Decrementamos el contador del alto de la imagen
			sub y,#1 
			
			//Revisamos si ya dibujamos toda la imagen.
			teq y,#0
			bne drawRow$
			mov pc,lr