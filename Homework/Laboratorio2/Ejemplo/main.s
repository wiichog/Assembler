@********************************************************
@ main.s
@ Autor: Martin L. Guzman
@ Fecha: 30/07/2015
@ Curso: CC4010 Taller de Assembler
@ La secuencia del programa es la siguiente:
@   * Lee un valor numerico almacenado en dato
@   * Despliega el valor numerico formando 2 caracteres
@   * Toma esos 2 caracteres y lo vuelve a convertir en un numero
@   * Despliega el ascii correspondiente a dicho numero
@********************************************************

@********************************************************
@***************** AREA DE CODIGO ***********************
@********************************************************
@area del codigo
.global _start
_start:

    
    @ ******************************
    @ Convertir numero a string
    @ ******************************
    
    @ obtener el valor a convertir
    ldr r0,=dato
    ldr r0,[r0]
    
    ldr r1,=resultado @ lugar donde almacenar los caracteres
    bl num2str_3
    
    @ ------------------------------
    @ desplegar resultado
    mov r7, #4      @4=llamado a "write" swi
    mov r0, #1      @1=stdout (monitor)
    mov r2, #3      @longitud de la cadena: 3 caracteres
    ldr r1, =resultado  @apunta a la cadena
    swi 0
    
    @ ******************************
    @ Imprimir enter (\n)
    @ ******************************
    
    mov r7, #4      @4=llamado a "write" swi
    mov r0, #1      @1=stdout (monitor)
    mov r2, #1      @longitud de la cadena: 1 caracter
    ldr r1, =enter  @apunta a la cadena
    swi 0
     
    @ ------------------------------
    @ salida al sistema operativo
    mov r7, #1
    swi 0


@********************************************************
@****************** AREA DE DATOS ***********************
@********************************************************
.data

@ -----------------------------
dato:   .word 148       @ Numero a desplegar en pantalla
enter:  .asciz "\n"	    @ enter
letra:  .asciz " "	    @ almacenar el valor numerico
resultado: .asciz "   "  @ Espacio para almacenar caracteres

