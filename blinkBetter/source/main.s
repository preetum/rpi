.section .init
.globl _start
_start:
b main

.section .text
main:
bl initGPIO
ldr r0, =0xf4240    @ 10^6 uS = 1 sec delay

loop$:
bl ledON
bl wait
bl ledOFF
bl wait
b loop$
