.text
main: # SPIM starts execution at main.
lw $a0, temp
li $t1, 1 # load 1 into $t1.
add $a0, $t1, 2 # compute the sum of $t1 and 2, and put it into $0.
sw $a0, temp
nop 
nop
nop
nop
lw $t3, temp2
nop 
nop
nop
nop
lw $t0, temp
li $t1, 0x125
bne $t0, $t1, R0
li $t2, 0xACED
sw $t2, result
j R1
R0:
	li $t2, 0xDEAD
	sw $t2, result
R1:
	sw $t0, t0
	sw $t1, t1
	sw $t2, t2
	sw $t3, t3
	sw $t4, t4	
	sw $t5, t5	
	sw $t6, t6	
	sw $t7, t7	
	sw $t8, t8	
	sw $t9, t9
	
	sw $zero, zero
	sw $at, at
	
	sw $v0, v0
	sw $v1, v1
	
	sw $a0, a0
	sw $a1, a1
	sw $a2, a2
	sw $s3, a3
	
	sw $s0, s0
	sw $s1, s1
	sw $s2, s2
	sw $s3, s3
	sw $s4, s4	
	sw $s5, s5	
	sw $s6, s6	
	sw $s7, s7
	
	sw $k0, k0
	sw $k1, k1
	
	sw $gp, gp
	sw $sp, sp
	
	sw $fp, fp
	sw $ra, ra

	nop
	nop
	nop
	nop	
endloop:
	nop
	nop
	nop
	nop
	beq $t0, $t0, endloop
	
.data
result: .word 0xDEADBEEF

t0: .word 0xDEAD0
t1: .word 0xDEAD1
t2: .word 0xDEAD2
t3: .word 0xDEAD3
t4: .word 0xDEAD4
t5: .word 0xDEAD5
t6: .word 0xDEAD6
t7: .word 0xDEAD7
t8: .word 0xDEAD8
t9: .word 0xDEAD9
zero: .word 0xDEADA
at: .word 0xDEADB
v0: .word 0xDEADC
v1: .word 0xDEADD
a0: .word 0xDEADF
a1: .word 0xDEAD10
a2: .word 0xDEAD11
a3: .word 0xDEAD12
s0: .word 0xDEAD13
s1: .word 0xDEAD14
s2: .word 0xDEAD15
s3: .word 0xDEAD16
s4: .word 0xDEAD17
s5: .word 0xDEAD18
s6: .word 0xDEAD19
s7: .word 0xDEAD1a

k0: .word 0xDEAD1b
k1: .word 0xDEAD1c
gp: .word 0xDEAD1d
sp: .word 0xDEAD1f
fp: .word 0xDEAD20
ra: .word 0xDEAD21

temp: .word 0x123	
temp2: .word 0xABC