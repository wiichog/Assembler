@ *************************************************************
@Subrutina que convierte un numero de 3 digitos (0-999) y lo guarda en una cadena
@Parametros:
@  r0: valor a convertir de 3 dígitos
@  r1: direccion en memoria donde guardar el resultado
@ *************************************************************

.global num2str_3, dividir
num2str_3:
	unidad	.req r4
	decena	.req r5
	centena	.req r6
    push {lr}

    push {r1} @guardar la direccion donde almacenar la cadena
    
    @r0 tiene el valor
    mov r1, #100
    bl dividir  @dividir valor/100
        @retorna r0 = resultado, r1 = residuo
	mov centena,r0
	mov r0,r1 
	mov r1, #10
    bl dividir  @dividir valor/10
        @retorna r0 = resultado, r1 = residuo
	mov decena,r0
	mov unidad,r1 
    
    add centena,centena,#0x30 @convertir resultado a caracter ascii
    add decena,decena,#0x30 @convertir residuo a caracter ascii
	add unidad,unidad,#0x30
    
    pop {r1} @recuperar direccion
    
    @almacenar caracteres
    strb centena,[r1]     @centena
	strb decena,[r1,#1]!   @decena
    strb unidad,[r1,#1]  @unidad
    .unreq centena
	.unreq decena
	.unreq unidad
	
    pop {pc}

@ *************************************************************
@Subrutina que realiza una division entre 2 numeros (A/B)
@Parametros:
@  r0: numero 1 (A)
@  r1: numero 2 (B)
@Retorna:
@  r0: resultado
@  r1: residuo
@ *************************************************************
dividir:
    push {lr}

    @ reiniciamos los valores de los registros donde iran los resultados
    mov r2, #0
    mov r3, r0 @asignamos el residuo como A
    
    inicio_div:
        cmp r3,r1
        blt fin_div     @terminar ya que B es mas grande que el residuo
        sub r3,r3,r1    @residuo = residuo-B 
        add r2,r2,#1    @resultado = resultado+1
        b inicio_div
    fin_div:

    mov r0, r2
    mov r1, r3

    pop {pc}
	