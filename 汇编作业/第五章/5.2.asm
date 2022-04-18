.data
SRC: .space 400
DEST: .space 400
src: .asciiz "SRC:\n"
dest: .asciiz "DEST:\n"
sp: .asciiz " "
enter: .asciiz "\n"
.globl main
.text
main:
la $t0,SRC
la $t1,DEST
li $t2,100 #n
li $t3,0
li $t4,400
init:
sw $t3,SRC($t3)
addi $t3,$t3,4
blt $t3,$t4,init
la $a0,SRC
la $a1,src
jal printArr
loop:
lw $t3,($t0)
sw $t3,($t1)
addi $t0,$t0,4
addi $t1,$t1,4
addi $t2,$t2,-1
bgtz $t2,loop
la $a0,DEST
la $a1 dest
jal printArr
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
