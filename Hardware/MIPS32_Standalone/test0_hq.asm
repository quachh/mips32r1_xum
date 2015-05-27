
#final expected resuls:
#$t2 == 0xB ; memLoc 16: 0x1E; memLoc 20: 0x19; memLoc 24: 0xB 


	.text
main:
  lw 	$fp, temp
	sw	$0,16($fp)
	sw	$0,20($fp)
	sw	$0,24($fp)
$L2:
	lw	$t2,24($fp)
	slti	$t3,$t2,11
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
	j	$L4
$L6:
	lw	$t2,20($fp)
	lw	$t3,24($fp)
	addu	$t2,$t2,$t3
  sw	$t2,20($fp)
	sw	$t2, temp2
$L7:
$L4:
	lw	$t2,24($fp)
	addu	$t3,$t2,1
  sw	$t3,24($fp)
	sw	$t3, temp3
	j	$L2
$L3:
	#move	$t2,$0
	j	$L1
$L1:
  li $t3, 0xb
  bne $t2, $t3, $R1
$R4:
  lw $t1, temp1
  li $t3, 0x1e
  bne $t1, $t3, $R1
$R3: 
  lw $t1, temp2
  li $t3, 0x19
  bne $t1, $t3, $R1
$R2:
  lw $t1, temp3
  li $t3, 0xB
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
temp4: .word 0
temp: .word 0x1001000