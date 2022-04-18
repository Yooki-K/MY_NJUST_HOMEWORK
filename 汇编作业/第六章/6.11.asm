.data
tip: .asciiz "please input a string (<=16):"
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
move $17,$a0
addi $sp,$sp,-8
sw $a0,($sp)
jal search
lw $8,4($sp)
addi $sp,$sp,8
addi $sp,$sp,-20
move $9,$sp
addi $9,$9,2
sb $8,1($sp)
move $10,$17
loop2:
lb $11,($10)
sb $11,($9)
addi $10,$10,1
addi $9,$9,1
addi $8,$8,-1
bgtz $8,loop2
jal Palindrome
lb $a0,($sp)
addi $sp,$sp,20
li $v0,1
syscall
li $v0,10
syscall
Palindrome:
lb $10,1($sp)
move $8,$sp
addi $8,$8,2 #第一个
add $9,$8,$10
addi $9,$9,-1 # 最后一个
addi $sp,$sp,-8
sw $10,($sp)
li $10,1
sw $10,4($sp)
loop3:
lb $11,($8) 
lb $12,($9)
bne $11,$12,case1
addi $9,$9,-1
addi $8,$8,1
blt $9,$8,end3
b loop3
case1:# 不相等
sw $0,4($sp)
end3:
lw $8,4($sp)
addi $sp,$sp,8
sb $8,($sp)
jr $ra

search:
li $8,0
li $10,0x0a
lw $11,($sp)
loop1:
lb $9,($11)
beqz $9,end1
beq $9,$10,end1
addi $8,$8,1
addi $11,$11,1
b loop1
end1:
sw $8,4($sp)
jr $ra