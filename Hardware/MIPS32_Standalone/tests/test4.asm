	.text
main:
	la 	$fp, temp
	sw	$0,16($fp)
	sw	$0,20($fp)
	sw	$0,24($fp)

	li	$t2,124			
	sw	$t2,24($fp)
	lw	$t2,24($fp)
	sw	$t2,16($fp)
	lw	$t2,16($fp)
	lw	$t3,24($fp)
	mult	$t2,$t3
	mflo	$t5
	sw	$t5,32($fp)
	lw	$t5,32($fp)
	sw	$t5,16($fp)
	lw	$t2,16($fp)
	lw	$t3,24($fp)
	xor	$t2,$t2,$t3
	lw	$t3,24($fp)
	subu	$t2,$t3,$t2
	lw	$t3,16($fp)
	srlv	$t2,$t3,$t2
	sw	$t2,16($fp)
	lw	$t2,16($fp)
	lw	$t3,24($fp)
	addu	$t2,$t2,$t3
	sw	$t2,16($fp)
	lw	$t2,16($fp)
	sll	$t3,$t2,5
	sw	$t3,16($fp)
	lw	$t2,16($fp)
	andi	$t3,$t2,0x0001
	beq	$t3,$0,$L2
	lw	$t2,24($fp)
	nor	$t3,$0,$t2
	sw	$t3,20($fp)
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	divu	$t2,$t2,$t3
	sw	$t2,20($fp)
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	sllv	$t2,$t2,$t3
	sw	$t2,20($fp)
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	subu	$t2,$t2,$t3
	sw	$t2,20($fp)
	lw	$t2,20($fp)
	sll	$t3,$t2,5
	sw	$t3,20($fp)
	lw	$t3,20($fp)
	xori	$t2,$t3,0x0058
	lw	$t3,20($fp)
	srlv	$t2,$t3,$t2
	sw	$t2,20($fp)
	nop
	j	$L3
$L2:
	lw	$t2,20($fp)
	ori	$t3,$t2,0x001c
	sw	$t3,20($fp)
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	divu	$t2,$t2,$t3
	sw	$t2,20($fp)
	lw	$t2,20($fp)
	sll	$t3,$t2,16
	sw	$t3,20($fp)
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	subu	$t2,$t2,$t3
	sw	$t2,20($fp)
	lw	$t2,20($fp)
	sll	$t3,$t2,5
	sw	$t3,20($fp)
$L3:
	lw	$t2,20($fp)
	andi	$t3,$t2,0x0003
	beq	$t3,$0,$L4
	lw	$t2,24($fp)
	move	$t3,$t2
	sll	$t4,$t3,2
	addu	$t2,$t4,$t2
	sw	$t2,24($fp)
	lw	$t3,24($fp)
	srl	$t2,$t3,4
	sw	$t2,24($fp)
	lw	$t2,24($fp)
	sll	$t3,$t2,2
	sw	$t3,24($fp)
	nop
	j	$L5
$L4:
	lw	$t2,24($fp)
	move	$t3,$t2
	sll	$t2,$t3,4
	sw	$t2,24($fp)
	lw	$t3,24($fp)
	srl	$t2,$t3,2
	sw	$t2,24($fp)
	lw	$t2,24($fp)
	move	$t3,$t2
	sll	$t4,$t3,2
	addu	$t2,$t4,$t2
	sw	$t2,24($fp)
	lw	$t2,24($fp)
	sll	$t3,$t2,2
	sw	$t3,24($fp)
$L5:
	nop		
	j	$L1

$L1:
#checker for expected result starts here
	li $s1, 0x3c10
  	bne $t5, $s1, $R1

$R4:
  	li $s1, 0x9b0
	bne $s1, $t2, $R1
$R3: 
	li $s1, 0x26c0
	bne $s1, $t3, $R1
$R2:
	li $s1, 0x7c0 
	bne $s1, $t4, $R1
	
	li $t2, 0xACED
	sw $t2, result
	j $R0
$R1:
	li $t2, 0xDEAD
	sw $t2, result
$R0:
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
temp1: .word 0
temp2: .word 0
temp3: .word 0
temp4: .word 0
temp:  .word 0
