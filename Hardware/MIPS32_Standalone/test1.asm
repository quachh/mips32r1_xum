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
  	bne $t2, $t5, $R1
$R4:
  	lw $t1, temp1
	li $t3, 0x23
	bne $t1, $t3, $R1
$R3: 
	lw $t1, temp2
	li $t3, 0x22
	bne $t1, $t3, $R1
$R2:
	lw $t1, temp3
	li $t3, 0x23
	bne $t1, $t3, $R1
	j $R0
$R1:
	li $t1, 0xDEAD
	sw $t1, result
	nop



$R0:  
	li $v0, 10 # syscall code 10 is for exit.
	syscall # make the syscall.
	nop
 	nop
	nop
	nop

	.data
	.align 2	
result: .word 0xACED	
temp1: .word 0
temp2: .word 0
temp3: .word 0
temp:  .word 0
