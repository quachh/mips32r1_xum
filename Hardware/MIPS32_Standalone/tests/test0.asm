
#final expected resuls:
#$t2 == 0xB ; memLoc 16: 0x1E; memLoc 20: 0x19; memLoc 24: 0xB 


	.text 0x00000000
main: 
	la 	$fp, temp
	sw	$0,16($fp)
	sw	$0,20($fp)
	sw	$0,24($fp)
$L2:
	nop
 	nop
	nop
	nop
	lw	$t2,24($fp)
	nop
 	nop
	nop
	nop
	slti	$t3,$t2,11
	nop
 	nop
	nop
	nop
	bne	$t3,$0,$L5
	nop
 	nop
	nop
	nop
	j	$L3
	nop
 	nop
	nop
	nop
$L5:
	lw	$t2,24($fp)
	nop
 	nop
	nop
	nop
	andi	$t3,$t2,0x0001
	nop
 	nop
	nop
	nop
	bne	$t3,$0,$L6
	nop
 	nop
	nop
	nop
	lw	$t2,16($fp)
	nop
 	nop
	nop
	nop
	lw	$t3,24($fp)
	nop
 	nop
	nop
	nop
	addu	$t2,$t2,$t3
	nop
 	nop
	nop
	nop
	sw	$t2,16($fp)
	nop
 	nop
	nop
	nop
	sw	$t2, temp1
	nop
 	nop
	nop
	nop
	j	$L4
	nop
 	nop
	nop
	nop
$L6:
	lw	$t2,20($fp)
	nop
 	nop
	nop
	nop
	lw	$t3,24($fp)
	nop
 	nop
	nop
	nop
	addu	$t2,$t2,$t3
	nop
 	nop
	nop
	nop
  	sw	$t2,20($fp)
  	nop
 	nop
	nop
	nop
	sw	$t2, temp2
	nop
 	nop
	nop
	nop
$L7:
$L4:
	lw	$t2,24($fp)
	nop
 	nop
	nop
	nop
	addu	$t3,$t2,1
	nop
 	nop
	nop
	nop
	sw	$t3,24($fp)
	nop
 	nop
	nop
	nop
	sw	$t3, temp3
	nop
 	nop
	nop
	nop
	j	$L2
	nop
 	nop
	nop
	nop
$L3:
	nop
 	nop
	nop
	nop
	#move	$t2,$0
	j	$L1
	nop
 	nop
	nop
	nop
$L1:
  li $t3, 0xb
  bne $t2, $t3, $R1
  nop
 	nop
	nop
	nop
$R4:
  lw $t1, temp1
  li $t3, 0x1e
  bne $t1, $t3, $R1
  nop
 	nop
	nop
	nop
$R3: 
  lw $t1, temp2
  li $t3, 0x19
  bne $t1, $t3, $R1
  nop
 	nop
	nop
	nop
$R2:
  lw $t1, temp3
  li $t3, 0xB
  bne $t1, $t3, $R1
  nop
 	nop
	nop
	nop
  li $t1, 0xACED
  sw $t1, result
  nop
  nop
  nop
  nop
  j $R0
  nop
  nop
  nop
  nop
$R1:
  li $t1, 0xDEAD
  sw $t1, result
  nop
  nop
  nop
  nop
  
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
	
.data 0x00002000
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
temp: .word 0xabc