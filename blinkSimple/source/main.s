.section .init
.globl _start
_start:
ldr r0,=0x20200000 @addr of gpio controller

@enable output:
@want to access pin 16: in second set (pins10-19) of 4 bytes, where 3 bits:1pin. 6X3 = 18.
mov r1,#1
lsl r1,#18 @shift left by 18
str r1,[r0,#4] @load control word into 2nd word of controller (since pin16 in 2nd set)

@turn on led (=turn OFF gpio):
mov r1,#1
lsl r1,#16


loop$:

str r1,[r0,#40] @40 = offset for CLEAR bits

mov r2,#0x3F0000
wait1$:
sub r2,r2,#1
cmp r2,#0
bne wait1$

str r1,[r0,#28] @turn ON gpio (LED OFF)

mov r2,#0x3F0000
wait2$:
sub r2,#1
cmp r2,#0
bne wait2$


b loop$

