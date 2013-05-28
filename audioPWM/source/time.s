.globl wait
wait:
delay .req r0
base .req r1
ldr base,=0x20003000    @base systimer addr
mov r2, #0
str r2, [base, #12]     @clear compare0
ldr r2, [base, #4]      @load counter (lower bits)
add r2, r2, delay       @add delay
str r2, [base, #12]     @store in compare0
stall$:
ldr r2, [base]
ands r2, r2, #1
beq stall$
mov pc, lr

.globl spin
spin:
mov pc, lr
