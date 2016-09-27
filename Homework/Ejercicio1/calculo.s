/* Subrutina 
	
	AUTORES: JUAN LUIS GARCIA 14189
				
	FECHA: 31 JULIO 2015
	*/
/******** USO DE REGISTROS ********/
@s9:Nota1
@s8:Nota2
@s7:Nota3
@s6:Nota4
@s5:Contante 61
@s4: Suma de todas
@s3: Operaciones
@s2: Constante 5
@s1: Constantes 1/4
/******** INICIO DE AREA DE DATOS ********/
.text
.align 2
/******** SUBRUTINA DE NOTA DE PROYECTO ********/
.global CalculoNotaProyecto
CalculoNotaProyecto:
push {lr}
@Convertimos las variables a registro tipo s
@Conversion nota 1 venia en r0
	pop {r1} 		@recupero r1
	str r0,[r1] 	@en la direccion de r1 cargo el dato
	flds s9,[r1] 	@guardo el dato en s9
@Conversion nota 2
	str r1,[r0] 	@en la direccion de r0 cargo el dato
	flds s8,[r0] 	@guardo el dato en s9
@Conversion nota 3
	str r2,[r1] 	@en la direccion de r1 cargo el dato
	flds s7,[r1] 	@guardo el dato en s9
@Conversion nota 4
	str r3,[r1] 	@en la direccion de r1 cargo el dato
	flds s6,[r1] 	@guardo el dato en s9
/******** DECLARACION DE CONSTANTES ********/
@Constate 61
	ldr r0,notaminima
	str r0,[r1]
	flds s5,[r1]
@Constante 5
	ldr r0,constante1
	str r0,[r1]
	flds s2,[r1]
@Constante un cuarto
	ldr r0,constante2
	str r0,[r1]
	flds s1,[r1]
@Constante 85
	ldr r0,constante2
	str r0,[r1]
	flds s0,[r1]


	@En s9 se guardaran todas las sumas 
		fadds s4,s9,s8 @Suma de nota1 con nota2
		fadds s4,s4,s7 @Suma de lo anterior con nota3
		fadds s4,s4,s6 @Suma de lo anterior con nota4
	@en s9 se guardara la resta
		fsubs s3,s5,s4
	@en s9 se guardara la multiplicacion
		fmuls s3,s3,s2
	
/******** SUBRUTINA DE POSIBLE MENCION ********/
.global PosibleMencion
PosibleMencion:
	@Multiplicacion de la suma de todas por un cuarto para sacar el promedio
	fmuls s4,s4,s1
	@comparacion de registros para ver si supera el 85
	fcmps s9,s0
	movgt r0,#1
	movlt r0,#0
	push{r0}
	pop{pc}

/******** CONSTANTES ********/
notaminima:	.float 61.00
constante1: .float 5.00
constante2: .float 0.25
constante3: .float 85.0