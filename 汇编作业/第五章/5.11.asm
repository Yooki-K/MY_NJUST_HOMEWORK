.data
zap: .space 200
err: .asciiz "\nerror\n"
tip: .asciiz "\nplease input:"
.globl main
.text 
main:
loop:
la $a0,tip
li $v0,4
syscall
li $v0,5
syscall
move $a0,$v0
li $t0,196
bgt $a0,$t0,Error
bltz $a0,Error
andi $v0,$v0,3
bnez $v0,Error
sw $s0,zap($a0)
li $v0,1
lw $a0,zap($a0)
syscall
b loop
Error:
la $a0,err
li $v0,4
syscall
b loop
