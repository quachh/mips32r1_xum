.text
main: # SPIM starts execution at main.
lw $a0, temp
li $t1, 1 # load 1 into $t1.
add $a0, $t1, 2 # compute the sum of $t1 and 2, and put it into $t0.
sw $a0, temp
li $v0, 10 # syscall code 10 is for exit.
syscall # make the syscall.
nop
nop
nop
nop
nop
nop

.data
temp: .word 1