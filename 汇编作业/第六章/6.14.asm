.data
sp: .asciiz " "
enter: .asciiz "\n"
tip: .asciiz "please input a string (<100):"
mes: .asciiz "A Vowel was Found at Relative Position:   "
vowels: .asciiz "aeiou"
str: .space 100
.globl main
.text
main:
# 输入
li $v0,4
la $a0,tip
syscall
li $v0,8
la $a0,str
li $a1,100
syscall
# end
addi $sp,$sp,-12
sw $a0,($sp)
sw $ra,8($sp)
jal Scan
li $v0,1
lw $a0,4($sp)
syscall
addi $sp,$sp,12
li $v0,10
syscall
Scan:
lw $9,($sp)
addi,$sp,$sp,-16
li $17,0 # n
li $12,0 # i
loop1:
la $8,vowels
addi,$12,$12,1
lb $10,($9) # str[i]
beqz $10,end1
loop2:
lb $11,($8) # yy[j]
beqz $11,end2
beq $10,$11,case1
addi $8,$8,1
b loop2
case1:
addi $17,$17,1
# 嵌套调用打印函数
sw $8,($sp)
sw $9,4($sp)
sw $17,8($sp)
sw $12,12($sp)
addi,$sp,$sp,-12
sw $12,($sp)
sw $ra,8($sp)
jal printDecimal
lw $ra,8($sp)
addi,$sp,$sp,12
lw $8,($sp)
lw $9,4($sp)
lw $17,8($sp)
lw $12,12($sp)
# end
end2:
addi $9,$9,1
b loop1
end1:
addi,$sp,$sp,16
sw $17,4($sp)
jr $ra
printDecimal:#可重入函数  靠右对齐
la $a0,mes
li $v0,4
syscall
lw $10,($sp)
li $9,10
sb $0,6($sp)
div $10,$9
mflo $8
mfhi $10
bnez $8,if
li $8,0x20
b endif
if:
addi $8,$8,0x30
endif:
addi $10,$10,0x30
sb $10,5($sp)
sb $8,4($sp)
li $v0,4
move $a0,$sp
addi $a0,$a0,4
syscall
la $a0,enter
li $v0,4
syscall
jr $ra