	.text
main:
	la 	$fp, temp
	sw	$0,16($fp)
	sw	$0,20($fp)
	li	$t2,5			# 0x00000005
	sw	$t2,24($fp)
	sw	$t2, temp3
$L2:
	lw	$t2,24($fp)
	slti	$t3,$t2,35
	bne	$t3,$0,$L5
	j	$L3
$L5:
	lw	$t2,24($fp)
	andi	$t3,$t2,0x0001
	bne	$t3,$0,$L6
	lw	$t2,16($fp)
	lw	$t3,24($fp)
	addu	$t2,$t2,$t3
	sw	$t2,16($fp)
	sw	$t2, temp1
	lw	$t2,16($fp)
	addu	$t3,$t2,-1
	sw	$t3,16($fp)
	sw	$t3, temp1
	lw	$t2,16($fp)
	sra	$t3,$t2,31
	srl	$t4,$t3,31
	addu	$t3,$t2,$t4
	sra	$t2,$t3,1
	sw	$t2,16($fp)
	sw	$t2, temp1
	lw	$t2,16($fp)
	move	$t3,$t2
	sll	$t2,$t3,1
	sw	$t2,16($fp)
	sw	$t2, temp1
	lw	$t3,16($fp)
	addu	$t2,$t3,2
	lw	$t3,16($fp)
	or	$t2,$t3,$t2
	sw	$t2,16($fp)
	sw	$t2, temp1
	lw	$t3,16($fp)
	addu	$t2,$t3,-2
	lw	$t3,16($fp)
	and	$t2,$t3,$t2
	sw	$t2,16($fp)
	sw	$t2, temp1
	move	$t2,$0
	lw	$t3,16($fp)
	bne	$t3,$0,$L8
	lw	$t3,16($fp)
	li	$t4,2			# 0x00000002
	bne	$t3,$t4,$L8
	j	$L7
$L8:
	li	$t2,1			# 0x00000001
$L7:
	sw	$t2,16($fp)
	sw	$t2, temp1
	move	$t2,$0
	lw	$t3,16($fp)
	beq	$t3,$0,$L9
	lw	$t3,16($fp)
	li	$t4,2			# 0x00000002
	beq	$t3,$t4,$L9
	li	$t2,1			# 0x00000001
$L9:
	sw	$t2,16($fp)
	sw	$t2, temp1
	lw	$t2,16($fp)
	lw	$t3,24($fp)
	addu	$t2,$t2,$t3
	sw	$t2,16($fp)
	sw	$t2, temp1
	j	$L4
$L6:
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	addu	$t2,$t2,$t3
	sw	$t2,20($fp)
	sw	$t2, temp2
	lw	$t2,20($fp)
	addu	$t3,$t2,-1
	sw	$t3,20($fp)
	sw	$t3, temp2
	lw	$t2,20($fp)
	sra	$t3,$t2,31
	srl	$t4,$t3,31
	addu	$t3,$t2,$t4
	sra	$t2,$t3,1
	sw	$t2,20($fp)
	sw	$t2, temp2
	lw	$t2,20($fp)
	move	$t3,$t2
	sll	$t2,$t3,1
	sw	$t2,20($fp)
	sw	$t2, temp2
	lw	$t3,20($fp)
	addu	$t2,$t3,2
	lw	$t3,20($fp)
	or	$t2,$t3,$t2
	sw	$t2,20($fp)
	sw	$t2, temp2
	lw	$t3,20($fp)
	addu	$t2,$t3,-2
	lw	$t3,20($fp)
	and	$t2,$t3,$t2
	sw	$t2,20($fp)
	sw	$t2, temp2
	move	$t2,$0
	lw	$t3,20($fp)
	bne	$t3,$0,$L12
	lw	$t3,20($fp)
	li	$t4,2			# 0x00000002
	bne	$t3,$t4,$L12
	j	$L11
$L12:
	li	$t2,1			# 0x00000001
$L11:
	sw	$t2,20($fp)
	sw	$t2, temp2
	move	$t2,$0
	lw	$t3,20($fp)
	beq	$t3,$0,$L13
	lw	$t3,20($fp)
	li	$t4,2			# 0x00000002
	beq	$t3,$t4,$L13
	li	$t2,1			# 0x00000001
$L13:
	sw	$t2,20($fp)
	sw	$t2, temp2
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	addu	$t2,$t2,$t3
	sw	$t2,20($fp)
	sw	$t2, temp2
$L10:
$L4:
	lw	$t2,24($fp)
	addu	$t3,$t2,1
	sw	$t3,24($fp)
	sw	$t3, temp3
	j	$L2

$L3:
	j	$L1
$L1:	
	li $t5, 0x23
  	bne $t2, $t5, R1
$R4:
  	lw $t1, temp1
	li $t3, 0x23
	bne $t1, $t3, R1
$R3: 
	lw $t1, temp2
	li $t3, 0x22
	bne $t1, $t3, R1
$R2:
	lw $t1, temp3
	li $t3, 0x23
	bne $t1, $t3, R1
	
	li $t2, 0xACED
	sw $t2, result
	j R0
R1:
	li $t2, 0xDEAD
	sw $t2, result
R0:
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
temp:  .word 0
