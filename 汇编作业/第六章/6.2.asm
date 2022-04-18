.data
N: .word 8
X: .byte -18,5,4,8,12,-5,96,-8
sp: .asciiz " "
enter: .asciiz "\n"
tip: .asciiz "please input the number you wish to search: "
.globl main
.text
main:
la $8,N
la $9,X
la $a0,tip
li $v0,4
syscall
li $v0,5
syscall
lw $8,($8)
addiu $sp,$sp,-20
sw $8,($sp)
sw $9,4($sp)
sw $v0,8($sp)
sw $ra,16($sp)
jal Search
lw $a0,12($sp)
li $v0,1
syscall
addiu $sp,$sp,20
li $v0,10
syscall
Search:
lw $8,($sp) #n
lw $9,4($sp) #&X
lw $10,8($sp) #V
li $11,-1 #return
li $13,1 #return
loop:
lb $12,($9) #x[i]
beq  $12,$10,setindex
addi $9,$9,1
addi $8,$8,-1
addi $13,$13,1
bgtz $8,loop
loopend:
sw $11,12($sp)
jr $ra
setindex:
move $11,$13
b loopend
