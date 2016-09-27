@Juan Luis Garcia 14189
@Patrick Ordo;ez 
@Universidad del valle de Guatemala

.section .init
.globl _start
_start:

@esto hace que se encienda el pin durante un tiempo
@utiizamos el ejemplo subido por marta ligia a blackboard
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#1			@se fija el modo de seleccion apra apagar el pin
bl SetGpio				@se fija la opcion
decr .req r0			@se nombra registros
mov decr,#0x3F0000
bl wait1$				@se manda a subrutina para esperar


@esto hace que se apage el pin durante un tiempo
@utiizamos el ejemplo subido por marta ligia a blackboard
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#0			@se fija el modo de seleccion apra apagar el pin
bl SetGpio				@se fija la opcion
decr .req r0			@se nombra registros
mov decr,#0x3F0000
bl wait2$				@se manda a subrutina para esperar


b main
.section .text
main:
mov sp,#0x8000
pinNum .req r0
pinFunc .req r1
mov pinNum,#16
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc

loop$:
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#0
bl SetGpio
.unreq pinNum
.unreq pinVal
decr .req r0
mov decr,#0x3F0000
wait1$: 
	sub decr,#1
	teq decr,#0
	bne wait1$
.unreq decr
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#1
bl SetGpio
.unreq pinNum
.unreq pinVal
decr .req r0
mov decr,#0x3F0000
wait2$:
	sub decr,#1
	teq decr,#0
	bne wait2$
.unreq decr
b loop$








	