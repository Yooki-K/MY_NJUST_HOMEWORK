.data
CHICO: .space 400
tip: .asciiz "chico:\n"
result: .asciiz "SUM:\n"
sp: .asciiz " "
enter: .asciiz "\n"
.globl main
.text
main:
li $t2,100 # n
li $t3,0
li $t4,400
init:
sw $t3,CHICO($t3)
addi $t3,$t3,4
blt $t3,$t4,init
la $a0,CHICO
la $a1,tip
jal printArr
la $t0,CHICO
li $t1,0
loop:
lw $t3,($t0)
add $t1,$t1,$t3
addi $t0,$t0,4
addi $t2,$t2,-1
bgtz $t2,loop
li $v0,4
la $a0,result
syscall
li $v0,1
move $a0,$t1
syscall
li $v0,10
syscall
printArr:
move $t5,$a0
li $v0,4
move $a0,$a1
syscall
li $t3,0
print:
lw $t6,($t5)
li $v0,1
move $a0,$t6
syscall
li $v0,4
la $a0,sp
syscall
addi $t3,$t3,4
addi $t5,$t5,4
blt $t3,$t4,print
li $v0,4
la $a0,enter
syscall
jr $ra
