/* Main Laboratorio 1
	
	AUTORES: JUAN LUIS GARCIA 14189
				
	FECHA: JULIO 2015
	*/
/******** INICIO DE AREA DE DATOS ********/
.data
.align 2
/******** INICIO PROGRAMA PRINCIPAL ********/
.text
.align 2
.global main
.type main,%function			
main:
stmfd sp!, {fp,lr}				@aqui tiene fp para trabajar punto flotante


/******* SALIDA AL SISTEMA OPERATIVO *********/
mov r0,#0
mov r3,#0
ldmfc sp!,{fp,pc}				@aqui tiene fp para trabajar punto flotante
bx lr
.align 2
/******* CONSTANTES *********/









