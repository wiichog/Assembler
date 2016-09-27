/******************************************************************************
*	gpio.s
*	 by Alex Chadwick
*
*	A sample assembly code implementation of the ok03 operating system.
*	Includes fix for SetGpioFunction.
*	See main.s for details.
*
*	gpio.s contains the rountines for manipulation of the GPIO ports.
******************************************************************************/

/* NEW
* According to the EABI, all method calls should use r0-r3 for passing
* parameters, should preserve registers r4-r8,r10-r11,sp between calls, and 
* should return values in r0 (and r1 if needed). 
* It does also stipulate many things about how methods should use the registers
* and stack during calls, but we're using hand coded assembly. All we need to 
* do is obey the start and end conditions, and if all our methods do this, they
* would all work from C.
*/

/* NEW
* GetGpioAddress returns the base address of the GPIO region as a physical address
* in register r0.
* C++ Signature: void* GetGpioAddress()
*/
.globl GetGpioAddress
GetGpioAddress: 
	ldr r0,=0x20200000
	mov pc,lr

/* NEW
* SetGpioFunction sets the function of the GPIO register addressed by r0 to the
* low  3 bits of r1.
* C++ Signature: void SetGpioFunction(u32 gpioRegister, u32 function)
*/
.globl SetGpioFunction
SetGpioFunction:
	cmp r0,#53			/* si Numero de pin es invalido sale de la funcion */
	cmpls r1,#7
	movhi pc,lr

	push {lr}
	mov r2,r0			/* guarda en r2 el numero de pin */
	bl GetGpioAddress

	functionLoop$:
		cmp r2,#9	
		subhi r2,#10	/* Si r2 > 9 le resta 10 a r2 */ 
		addhi r0,#4		/* y le suma 4 a la direccion GPIO (r0) */
		bhi functionLoop$

	add r2, r2,lsl #1	/* en r2 queda el residuo, lo multiplica * 3 */
	lsl r1,r2
	str r1,[r0]
	pop {pc}

/* NEW
* SetGpio sets the GPIO pin addressed by register r0 high if r1 != 0 and low
* otherwise. 
* C++ Signature: void SetGpio(u32 gpioRegister, u32 value)
*/
.globl SetGpio
SetGpio:	
    pinNum .req r0
    pinVal .req r1

	cmp pinNum,#53			/*Si pinNum es mayor de 53 sale de la función */
	movhi pc,lr
	push {lr}
	mov r2,pinNum			/*Numero de pin va en r2*/
    .unreq pinNum	
    pinNum .req r2
	bl GetGpioAddress		/*Obtiene direccion de GPIO*/
    gpioAddr .req r0

	pinBank .req r3			/*Calcula el "banco" que corresponde al pin. */
							/*El controlador GPIO tiene dos "bancos" de 4 
							bytes c/u (32 bits) para encender y apagar los pines.
							El primer "banco" controla los pines 0-31 y el 
							segundo los pines 32-53. Para saber a qué banco 
							corresponde se divide entre 32*/
	
	lsr pinBank,pinNum,#5	/*pinBank <-- pinNum / 32. Ej: para pin=7 pinBank<-0 */
	
	lsl pinBank,#2			/*pinBank*4<-pinBank. C/banco tiene 4 bytes, calcula direccion */
	add gpioAddr,pinBank 	/*Si el pin está entre 0-31 la direccion es x20200000, 
							si está entre 32-53 la direccion es x20200004 */
	.unreq pinBank

	and pinNum,#31 			/*Para fijar el bit correspondiente al pin*/
	setBit .req r3
	mov setBit,#1
	lsl setBit,pinNum
	.unreq pinNum

	teq pinVal,#0 			/*test equal: si el valor es cero, va a la direccion
							de apagar el pin, si no es cero, va a la dirección
							de encender el pin */
	.unreq pinVal
	streq setBit,[gpioAddr,#40] /*on*/
	strne setBit,[gpioAddr,#28] /*off*/
	.unreq setBit
	.unreq gpioAddr
	pop {pc}