.data
start_screen: .asciiz "-----------------Fibonacci-----------------\n-------------------menu--------------------\n\n1.Print first N numbers of Fiboaccai\n2.Print the N number of Fibonacci\n3.Find a number in Fibonacci\n4.exit\n"
exit_screen: .asciiz "\n-----------------byebye-----------------\n"
tip1: .asciiz "\nPlease input a dec value(<1000000000):"
tip2: .asciiz "\nPlease input your choise:"
buffer: .space 10
endl: .asciiz "\n"
sp: .asciiz " "
err1: .asciiz "\nIt's a empty string!\n"
err2: .asciiz "\nIt's a error string!\n"
err3: .asciiz "\nA nonpositive is not allowed!\n"
err4: .asciiz "\nIt's a number that is not allowed!\n"
.globl main
.text
main:
# ��ӡ��ʼ����                                        
li $v0 4
la $a0 start_screen
syscall
# end                                        
loop:
# �����û���ѡ��                                        
choose:
addi $sp,$sp,-4                         # ���ڴ���ֲ�����
addi $sp,$sp,-8
li $8,1                                 # ��ӦDecin��������type
sw $8,($sp)                             # type����ѹջ
jal Decin                               # ��ת��Decin����
lw $8,4($sp)                            # ����Decin��������ֵ����Ӧ�ֲ�����type
addi $sp,$sp,8
li $9,4
bgt $8,$9,out_5                         # �û�ѡ��ֵδ��ѡ��Χ
beq $8,$9,end_all                       # ��ֹ���򣬷���ϵͳ
addi $8,$8,-2                           # type=type-2
sw $8,($sp)                             # �洢 type ��ջ
# # ��������
addi $sp,$sp,-8
li $8,0                                 # ��ӦDecin��������type
sw $8,($sp )                            # type����ѹջ
jal Decin                               # ��ת��Decin����
lw $a0,4($sp )                          # ����Decin��������ֵ����Ӧ�ֲ�����m
addi $sp,$sp,8
# # end
lw $8,($sp )                            # ���ؾֲ�����type
beqz $8,recursive                       # ��type==0,��ת���ݹ���㲿��
bgtz $8,find_iteration                  # ��type>0,��ת���������Ҳ���
b print_iteration                       # ����,��ת��������ӡ����
out_5:
li $v0,4                                # ��ӡerr4
la $a0,err4
syscall                                 # end
b choose                                # ��������
# end                                        

print_iteration:
# ���õ�����ӡǰn������                                        
addi $sp,$sp,-4
sw $a0,($sp)                            # ��print_Fibonacci_iteration�����Ĳ���nѹջ
jal print_Fibonacci_iteration
addi $sp,$sp,4
b loop
# end                                        
recursive:
# ���õݹ�����n������                                        
addi $sp,$sp,-16
sw $a0,($sp)                            # ��Fibonacci_recursive�����Ĳ���nѹջ
jal Fibonacci_recursive
lw $a0,12($sp)                          # ���ز���ӡFibonacci_recursive��������ֵ
li $v0,1
syscall
la $a0,endl
li $v0,4
syscall                                 # end
addi $sp,$sp,16
b loop
# end                                        
find_iteration:
# ���õ�������ĳ�������Ƿ�����쳲���������                                        
addi $sp,$sp,-8
sw $a0,($sp)                            # ��find_Fibonacci_iteration�����Ĳ���nѹջ
jal find_Fibonacci_iteration
lw $a0,4($sp)                           # ���ز���ӡfind_Fibonacci_iteration��������ֵ
li $v0 1
syscall
li $v0,4
la $a0,endl
syscall                                 # end
addi $sp,$sp,8
b loop
# end                                        
end_all:                                # �������
addi $sp,$sp,4
# ��ӡ��������                                        
li $v0 4
la $a0 exit_screen
syscall
# end
li $v0,10
syscall
Decin:                                  # ��ȡʮ���ƺ��� Decin(m,type)
Decin_begin:
lw $a0,($sp)                            # ��ȡ����type
li $v0,4                                # ��ӡ��ʾ��Ϣ
beqz $a0,tip_1
la $a0,tip2
b endif
tip_1:
la $a0,tip1
endif:
syscall                                 # end
la $a0,buffer                           # �����ַ�������Ӧ�ֲ�����fp
li $a1,10
li $v0,8 
syscall                                 # end
li $8,0x20                              # ��Ӧ�ֲ�����sp ' '
li $9,0x0a                              # ��Ӧ�ֲ�����enter '\n'
li $10,0x2d                             # ��Ӧ�ֲ�����fh '-'
do_space1:                              # ���ǰ�ո�
lb  $17, ($a0)                          # ��Ӧ�ֲ�����temp
addi $a0, $a0, 1                        # fp++
beqz $17, out_1                         # �����մ�
beq $17, $9, out_1                      # �����մ�
beq $17, $8, do_space1                  # �������ո���������
beq $17, $10, out_3                     # ��������
li $12,0x30                             # '0'
li $13,0x39                             # '9'
move $v0,$0                             # ��Ӧ�ֲ�����m
li $14,10                               # Ȩ,��Ӧ�ֲ�����basis
do_zero:
bne $17, $12, loop1                     # �ж��Ƿ�Ϊ��0��
lb  $17, ($a0)
beqz $17, out_3                         # ���0������
beq $17, $9, out_3                      # ���0������
addi $a0, $a0, 1                        # fp++
b do_zero
loop1:
beq $17, $8, do_space2  
beqz $17, out_4                         # ����
beq $17, $9, out_4                      # ���� 
blt $17, $12, out_2                     # С��'0'������
bgt $17, $13, out_2                     # ����'9'������
mulo $v0, $v0, $14
addi $17, $17, -48                      # ��x��- '0'
add $v0, $v0, $17    
lb  $17, ($a0)                          # ����temp
addi $a0, $a0, 1                        # fp++
b  loop1
do_space2:                              # ����ո�
lb  $17, ($a0)                          # ����temp
addi $a0, $a0, 1                        # fp++
beqz $17, out_4                         # ����
beq $17, $9, out_4                      # ����
beq $17, $8, do_space2
b  out_2
out_1:
li $v0,4                                # ��ӡerr1
la $a0,err1
syscall                                 # end
b Decin_begin
out_2: 
li $v0,4                                # ��ӡerr2
la $a0,err2
syscall                                 # end
b Decin_begin
out_3:
li $v0,4                                # ��ӡerr3
la $a0,err3
syscall                                 # end
b Decin_begin
out_4:
sw $v0,4($sp)                           # ��������ֵѹջ
jr $ra                                  # ����
# Decin end                                        
print_Fibonacci_iteration:              # 쳲��������е����㷨 print_Fibonacci_iteration(n)
lw $8,($sp)                             # ����print_Fibonacci_iteration��������n
move $9,$0                              # ��Ӧ�ֲ�����pre
li $17,1                                # ��Ӧ�ֲ�����cur
li $v0,1                                # ��ӡ쳲��������е�һ����
li $a0,1
syscall
li $v0,4
la $a0,sp
syscall                                 # end
loop2:
addi $8,$8,-1                           # n = n - 1
blez $8,end2                            # n <= 0������ѭ��
move $10,$17                            # ��Ӧ�ֲ�����temp = pre
add $17,$17,$9                          # cur = cur + pre
move $9,$10                             # pre = temp
li $v0,1                                # ��ӡcur
move $a0,$17
syscall
li $v0,4
la $a0,sp
syscall                                 # end
b loop2
end2:
li $v0,4                                # ��ӡ���з�
la $a0,endl
syscall                                 # end
jr $ra
# print_Fibonacci_iteration end                                        

find_Fibonacci_iteration:               # 쳲��������е����㷨 find_Fibonacci_iteration(index,n)
lw $8,($sp)                             # ����find_Fibonacci_iteration��������n
move $9,$0                              # ��Ӧ�ֲ�����pre
li $17,1                                # ��Ӧ�ֲ�����cur
li $v0,1                                # ��Ӧ�ֲ�����index
loop3:
beq $8,$17,end3                         # n == cur,�ҵ�����ѭ��
blt $17,$8,content3                     # n < cur,��������
li $v0,-1                               # n>cur,û�ҵ�������ѭ��
b end3
content3:
addi $v0,$v0,1                          # index = index + 1
move $10,$17                            # ��Ӧ�ֲ�����temp = pre
add $17,$17,$9                          # cur = cur + pre
move $9,$10                             # pre = cur
b loop3
end3:
sw $v0,4($sp)                           # ��������ֵѹջ
jr $ra                                  # ����
# find_Fibonacci_iteration end                                        

Fibonacci_recursive :                   # 쳲��������еݹ��㷨 Fr(n,Fr(n-1),Fr(n-2),re)
lw $8,($sp)                             # ����Fibonacci_recursive��������n
li $9,1                                 # ��Ӧ����ֵre
li $10,2
ble $8,$10,re                           # n<=2,��ֱ�ӷ���
addi $8,$8,-1                           # n-1
addi $sp,$sp,-20 
sw $8,($sp)                             # n-1��ջ
sw $ra,16($sp)                          # $ra��ջ
jal Fibonacci_recursive                 # Fr(n-1, , ,r')
lw $9,12($sp)                           # ����r'
lw $ra,16($sp)                          # ����$ra
addi $sp,$sp,20
sw $9,4($sp)                            # r'��ջ����ӦFr(n-1)
lw $8,($sp)                             # ����n
addi $8,$8,-2                           # n-2
addi $sp,$sp,-20
sw $8,($sp)                             # n-2��ջ
sw $ra,16($sp)                          # $ra��ջ
jal Fibonacci_recursive                 # Fr(n-2, , ,r'')
lw $9,12($sp )                          #����r''
lw $ra,16($sp )                         #����$ra
addi $sp,$sp,20
sw $9,8($sp)                            # r''��ջ����ӦFr(n-2)
lw $8,4($sp)                            # ����Fr(n-1)
add $9,$8,$9                            # re = Fr(n-1) + Fr(n-1)
re:
sw $9,12($sp)                           # ��������ֵ��ջ
jr $ra                                  # ����
# Fibonacci_recursive end                                        