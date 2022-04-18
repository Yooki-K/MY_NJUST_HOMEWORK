.data
data: .word 5,2,9
sp: .asciiz " "
.globl main
.text
main:
la $t0,data
lw $a0,($t0)
lw $a1,4($t0)
lw $a2,8($t0)
jal sort
li $v0,1
syscall
li $v0,4
la $a0,sp
syscall
li $v0,1
move $a0,$a1
syscall
li $v0,4
la $a0,sp
syscall
li $v0,1
move $a0,$a2
syscall
li $v0,4
la $a0,sp
syscall
li $v0,10
syscall
sort:
bgt $a0,$a1,if1
b if2
if1:
move $t0,$a0
move $a0,$a1
move $a1,$t0
bgt $a0,$a2,if2
b if3
if2:
move $t0,$a0
move $a0,$a2
move $a2,$t0
if3:
bgt $a1,$a2,if4
b end
if4:
move $t0,$a1
move $a1,$a2
move $a2,$t0
end:
jr $ra
