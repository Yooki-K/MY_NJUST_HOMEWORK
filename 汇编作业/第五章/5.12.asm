.data
N: .word 8
X: .word 1,4,5,8,12,15,16,-20
.globl main
.text
main:
la $a0,X
la $a1,N
lw $a1,($a1)
jal function
move $a0,$v0
li $v0,1
syscall
li $v0,10
syscall
function:
xor $v0,$v0,$v0
move $t0,$a0
loop:
lw $t1,($t0)
addi $t0,$t0,4
addi $a1,$a1,-1
andi $t1,$t1,3
beqz $t1,if
b endif
if:
addi $v0,$v0,1
endif:
bgtz $a1,loop
jr $ra
