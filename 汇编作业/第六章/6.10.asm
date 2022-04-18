.data
tip: .asciiz "please input a string (<=60):"
str: .space 60
.globl main
.text
main:
li $v0,4
la $a0,tip
syscall
li $v0,8
la $a0,str
li $a1,60
syscall
jal Reverse
li $v0,10
syscall
Reverse:
addiu $sp,$sp,-60
move $a1,$sp
addi $a1,$a1,60
sb $0,($a1)
move $8,$a0
loop:
lb $9,($8)
beqz $9,end
addi $a1,$a1,-1
sb $9,($a1)
addi $8,$8,1
b loop
end:
# ´òÓ¡
move $a0,$a1
li $v0,4
syscall
addi $sp,$sp,60
jr $ra
