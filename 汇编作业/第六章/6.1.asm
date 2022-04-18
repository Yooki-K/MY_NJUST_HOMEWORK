.data
N: .word 8
X: .word -112,5,4,8,12,-5,96,-88
sp: .asciiz " "
enter: .asciiz "\n"
.globl main
.text
main:
la $8,N
la $9,X
lw $8,($8)
addiu $sp,$sp,-20
sw $8,($sp)
sw $9,4($sp)
sw $ra,16($sp)
jal MinMax
lw $a0,8($sp)
li $v0,1
syscall
la $a0,sp
li $v0,4
syscall
lw $a0,12($sp)
li $v0,1
syscall
addiu $sp,$sp,20
li $v0,10
syscall
MinMax:
lw $8,($sp) #n
lw $9,4($sp) #&X
lw $10,($9) #min
lw $11,($9) #max
addi $9,$9,4 #i
addi $8,$8,-1
loop:
lw $12,($9) #x[i]
blt $12,$10,ifmin
bgt $12,$11,ifmax
ifend:
addi $9,$9,4
addi $8,$8,-1
bgtz $8,loop
sw $10,8($sp)
sw $11,12($sp)
jr $ra
ifmax:
lw $11,($9)
b ifend
ifmin:
lw $10,($9)
b ifend

