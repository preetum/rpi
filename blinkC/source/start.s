.section .init
.globl _start
_start:
mov sp, #0x8000
bl initGPIO
bl main
halt$: b halt$
