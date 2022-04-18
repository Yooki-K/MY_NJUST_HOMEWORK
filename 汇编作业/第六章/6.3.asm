.data
N: .word 8
X: .asciiz "a123vdAQ"
sp: .asciiz " "
enter: .asciiz "\n"
.globl main
.text
main:
la $8,N
la $9,X
lw $8,($8)
addiu $sp,$sp,-24
sw $8,($sp)
sw $9,4($sp)
sw $ra,16($sp)
jal Scan
lw $a0,8($sp)
jal print
lw $a0,12($sp)
jal print
lw $a0,16($sp)
jal print
addiu $sp,$sp,24
li $v0,10
syscall
Scan:
lw $8,($sp) #n
lw $9,4($sp) #&X
li $10,0 #大写字母个数U
li $11,0 #小写字母个数L
li $12,0 #十进制数字个数D
loop:
lb $13,($9) #x[i]
addi $13,$13,-48
bltz $13,end
addi $13,$13,-9
blez $13,calD
addi $13,$13,-8
bltz $13,end
addi $13,$13,-25
blez $13,calU
addi $13,$13,-7
bltz $13,end
addi $13,$13,-25
blez $13,calL
calU:
addi $10,$10,1
b end
calL:
addi $11,$11,1
b end
calD:
addi $12,$12,1
b end
end:
addi $9,$9,1
addi $8,$8,-1
bgtz $8,loop
sw $10,8($sp)
sw $11,12($sp)
sw $12,16($sp)
jr $ra
print:
li $v0,1
syscall
la $a0,sp
li $v0,4
syscall
jr $ra
