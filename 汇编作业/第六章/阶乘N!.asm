.data
sp: .asciiz " "
enter: .asciiz "\n"
tip: .asciiz "please input a number (<10):"
err: .asciiz "the number you input is too big!!!\n"
.globl main
.text
main:
# 输入
li $v0,4
la $a0,tip
syscall
li $v0,5
syscall
# 输入纠错
move $8,$v0
addi $8,$8,-10
bgtz $8,error
# end
# end
addi $sp,$sp,-4
sw $v0,($sp)
jal jc
addi $sp,$sp,4
li $v0,10
syscall
jc:
lw $8,($sp)
move $9,$8
loop:
addi,$8,$8,-1
beqz $8,endloop
mul $9,$9,$8
b loop
endloop:
# 嵌套调用打印函数
addi,$sp,$sp,-8
sw $9,($sp)
sw $ra,4($sp)
jal print
lw $ra,4($sp)
addi,$sp,$sp,8
# end
jr $ra
print:#可重入函数  靠右对齐
lw $8,($sp)
li $9,10
addi $sp,$sp,-12
addi $13,$sp,7
sb $0,8($sp)
loop2:
div $8,$9
mflo $8 #商
mfhi $12 #余数
addi $12,$12,0x30
sb $12,($13)
addi $13,$13,-1
bnez $8,loop2
li $9 0x20
loop3:
blt $13,$sp,end3
sb $9,($13)
addi $13,$13,-1
b loop3
end3:
li $v0,4
move $a0,$sp
syscall
la $a0,enter
li $v0,4
syscall
addi $sp,$sp,12
jr $ra

error:
la $a0,err
li $v0,4
syscall
b main