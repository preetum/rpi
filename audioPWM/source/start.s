.section .init
.globl _start
_start:
mov sp, #0x8000
bl initLED
bl main
halt$: b halt$
