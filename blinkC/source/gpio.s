.globl initGPIO
.globl ledON
.globl ledOFF

initGPIO:
@enable output:
ldr r2,=0x20200000 @addr of gpio controller
@want to access pin 16: in second set (pins10-19) of 4 bytes, where 3 bits:1pin. 6X3 = 18
mov r3,#1
lsl r3,#18 @shift left by 18
str r3,[r2,#4] @load control word into 2nd word of controller (since pin16 in 2nd set)
mov pc, lr

ledON:
@turn on led (=turn OFF gpio):
ldr r2,=0x20200000 @addr of gpio controller
mov r3,#0x10000 @1 << 16
str r3,[r2,#40] @40 = offset for CLEAR bits
mov pc, lr

ledOFF:
ldr r2,=0x20200000 @addr of gpio controller
mov r3,#0x10000 @1 << 16
str r3,[r2,#28] @turn ON gpio (LED OFF)
mov pc, lr
