@********************************************************
@ rutinas.s
@ Autor: Martin L. Guzman
@ Fecha: 30/07/2015
@ Curso: CC4010 Taller de Assembler
@ Contiene rutinas para division, conversion de numero a
@ 2 caracteres ascii y viseversa.
@********************************************************


@ *************************************************************
@Subrutina que realiza una division entre 2 numeros (A/B)
@Parametros:
@  r0: numero 1 (A)
@  r1: numero 2 (B)
@Retorna:
@  r0: resultado
@  r1: residuo
@ *************************************************************
.global dividir
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
    
    
@ *************************************************************
@Subrutina que convierte un numero de 2 digitos (0-99) y lo guarda
@en una cadena
@Parametros:
@  r0: valor a convertir
@  r1: direccion en memoria donde guardar el resultado
@ *************************************************************
.global num2str
num2str:
    push {lr}

    push {r1} @guardar la direccion donde almacenar la cadena
    
    @r0 tiene el valor
    mov r1, #10
    bl dividir  @dividir valor/10
        @retorna r0 = resultado, r1 = residuo
    
    add r2,r0,#0x30 @convertir resultado a caracter ascii
    add r3,r1,#0x30 @convertir residuo a caracter ascii
    
    pop {r1} @recuperar direccion
    
    @almacenar caracteres
    strb r2,[r1]     @decena
    strb r3,[r1,#1]  @unidad
    
    pop {pc}



@ *************************************************************
@Subrutina que lee una cadena de largo 2 y lo convierte en un numero
@Por ejemplo: si se ingresa "35" retorna en r0 el valor numerico 35
@Parametros:
@  r0: direccion en memoria donde leer los caracteres
@Retorna:
@  r0: valor numerico
@ *************************************************************
.global str2num
str2num:
    push {lr}

    @ leer los 2 caracteres
    ldrb r1,[r0]
    ldrb r2,[r0,#1]
    
    @ convertirlos a valores numericos
    sub r1,r1,#0x30
    sub r2,r2,#0x30
    
    @ 10*caracter1+caracter2. Ejemplo: "65" = 10*6+5
    mov r3,#10
    mul r1,r3
    add r0,r1,r2
    
    pop {pc}
