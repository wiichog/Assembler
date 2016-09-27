@ *************************************************************
@Subrutina que convierte un numero de 2 digitos (0-99) y lo guarda
@en una cadena
@Parametros:
@  r0: valor a convertir de 3 dígitos
@  r1: direccion en memoria donde guardar el resultado
@ *************************************************************
.global num2str_3dig
num2str_3dig:
	@registros para guardar el numero como caracteres ASCII
	centena	.req r8
	decena	.req r9
	unidad	.req r10
	
    push {lr}
    push {r1} @guardar la direccion donde almacenar la cadena 
	@r0 tiene el valor
    mov r1, #100
    bl dividir  @dividir valor/100
        @retorna r0 = resultado, r1 = residuo. r0 es el primer dígito
	mov centena, r0
	mov r0, r1				@r1 tiene el residuo. Es el siguiente numero para dividir
    
	@r0 tiene el valor
    mov r1, #10
    bl dividir  @dividir valor/10
        @retorna r0 = resultado, r1 = residuo
    mov decena, r0
	mov unidad, r1				@r1 tiene el residuo. Es la unidad
    
	add centena,centena,#0x30 	@convertir centena a caracter ascii
    add decena,decena,#0x30 	@convertir decena a caracter ascii
	add unidad,unidad,#0x30			@convertir unidad a caracter ascii
    
    pop {r1} @recuperar direccion de la cadena resultado
    
    @almacenar  caracteres en la cadena resultado
    strb centena,[r1]     	@centena
    strb decena,[r1,#1]  	@decena
	strb unidad,[r1,#2]		@unidad
	
	.unreq centena
	.unreq decena
	.unreq unidad
    
    pop {pc}