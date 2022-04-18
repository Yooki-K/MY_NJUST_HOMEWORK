.data
N: .word 9,10,32666,32777,654321
sp: .asciiz "\n"
.globl main
.text
main:
li $t0,5
la $t1,N
loop1:
lw $a0,($t1)
jal SUM
move $a0,$v0
li $v0,1
syscall
la $a0,sp
li $v0,4
syscall
addi $t1,$t1,4
addi $t0,$t0,-1
bgtz $t0,loop1
li $v0,10
syscall
SUM:
xor $v0,$v0,$v0
addi $t2,$a0,1
mul $v0,$t2,$a0
sra $v0,$v0,1
jr $ra

