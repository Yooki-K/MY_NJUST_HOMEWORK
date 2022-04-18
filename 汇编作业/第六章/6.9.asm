.data
data: .word 1,0,1
sp: .asciiz " "
enter: .asciiz "\n"
err: .asciiz "calculate error!!!"
.globl main
.text
main:
la $8,data
lw $9,0($8)
lw $10,4($8)
lw $11,8($8)
addiu $sp,$sp,-28
sw $9,($sp)
sw $10,4($sp)
sw $11,8($sp)
sw $ra,24($sp)
jal Roots
lw $8,12($sp)
lw $9,16($sp)
lw $10,20($sp)
addiu $sp,$sp,28
# 打印结果
move $a0,$8
jal print
addi $8,$8,-3
beqz $8,error
move $a0,$20
jal print
move $a0,$21
jal print
# end
exit:
li $v0,10
syscall
Roots:
lw $16,($sp) #a
lw $17,4($sp) #b
lw $18,8($sp) #c
li $19,0 #status
li $20,0 #r1
li $21,0 #r2
mul $14,$17,$17 #b*b
mul $15,$16,$18 #a*c
sll $15,$15,2 #4*a*c
sub $14,$14,$15 # b*b-4*a*c
beqz $14,type1
# 求|b^2-4ac|的开根号
abs $22,$14 # |b^2-4ac|
addiu $sp,$sp,-12
sw $22,($sp)
sw $ra,8($sp)
jal sqrt
lw $22,4($sp)
lw $ra,8($sp)
addiu $sp,$sp,12
# end
bgtz $14,type0
b type2
end:
sw $19,12($sp)
sw $20,16($sp)
sw $21,20($sp)
jr $ra
type0:
beqz $22,type3
sub $8,$0,$17
sub $9,$8,$22
add $10,$8,$22
div $20,$9,$16
sra $20,$20,1
div $21,$10,$16
sra $21,$21,1
b end
type1:
ori $19,$19,1
beqz $17,type3
sub $20,$0,$16
div $20,$8,$17
move $21,$20
b end
type2:
ori $19,$19,2
sub $20,$0,$17
div $20,$20,$16
sra $20,$20,1
div $21,$22,$16
sra $21,$21,1
b end
type3:
ori $19,$19,3
b end
print:
li $v0,1
syscall
la $a0,sp
li $v0,4
syscall
jr $ra
sqrt:
lw $8,($sp)
li $9,1
loop:
mul $10,$9,$9
blt $10,$8,next
beq $10,$8,end_
li $9,0
end_:
sw $9,4($sp)
jr $ra
next:
addi,$9,$9,1
b loop
error:
la $a0,err
li $v0,4
syscall
b exit