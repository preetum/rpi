.globl initLED
.globl ledON
.globl ledOFF

initLED:
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





.globl initPWM40
.globl initPWMclk
.globl setPWM1
.globl clearPWM1

initPWM40:
ldr r2,=0x20200000 	@addr of gpio controller
mov r3, #4			@ 4 = 0b100 = alt func 0 (PWM1)
str r3, [r2, #16]
mov pc, lr


initPWMclk:
@	initializes the PWM clock to 500Mhz divided by 5 = 100 Mhz (largely undocumented)
ldr r0, =0x2020c000	@addr of PWMCTL
mov r1, #0
str r1, [r0]		@better turn PWM off first...

ldr r0, =0x201010a0	@addr of CM_PWMCTL (PWM clock control)
ldr r1, [r0]
bic r1, r1, #0x10	@r0 = r0 & imm (clear the 'enable' bit)
orr r1, r1, #0x5a000000
str r1, [r0] 
waitOff$:
ldr r1, [r0]
ands r1, r1, #0x80	@wait for 'busy' flag off
bne waitOff$

ldr r1, =0x5a005000	@divisor = intpart:5, fracpart:0
str r1, [r0, #4]	@store CM_PWMDIV

ldr r1, =0x5a000016	@control = source:PLLD (500Mhz), 0-MASH (int division), ENABLE SET
str r1, [r0]		@store CM_PWMCTL, ENABLED!
waitOn$:
ldr r1, [r0]
ands r1, r1, #0x80
beq waitOn$
mov pc, lr


setPWM1:
ldr r3, =0x2020c000	@addr of PWMCTL
str r0, [r3, #0x14] @ PWMDAT1
str r1, [r3, #0x10]	@ PWMRNG1
mov r2, #1
str r2, [r3]		@ PWMCTL = channel 1 ENABLED, PWM mode, PWM transmission
mov pc, lr

clearPWM1:
ldr r3, =0x2020c000	@addr of PWMCTL
mov r2, #0
str r2, [r3]		@ DISABLE
mov pc, lr
