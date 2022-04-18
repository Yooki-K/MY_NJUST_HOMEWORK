.data
K: .word 0
Y: .word 0
Z: .space 200
.globl main
.text
main:
la $t0,K
la $t1,Y
li $t0,20
li $t1,56
move $t2,$t0
sra $t2,$t2,2
addi $t2,$t2,210
sll $t2,$t2,4
sub $t1,$t1,$t2
sw $t1,Z($t0)
li $v0,1
lw $a0,Z($t0)
syscall
li $v0,10
syscall
