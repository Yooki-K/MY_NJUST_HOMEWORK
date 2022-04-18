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
# 打印开始界面                                        
li $v0 4
la $a0 start_screen
syscall
# end                                        
loop:
# 输入用户的选择                                        
choose:
addi $sp,$sp,-4                         # 用于储存局部变量
addi $sp,$sp,-8
li $8,1                                 # 对应Decin函数参数type
sw $8,($sp)                             # type参数压栈
jal Decin                               # 跳转到Decin函数
lw $8,4($sp)                            # 加载Decin函数返回值，对应局部变量type
addi $sp,$sp,8
li $9,4
bgt $8,$9,out_5                         # 用户选择值未在选择范围
beq $8,$9,end_all                       # 终止程序，返回系统
addi $8,$8,-2                           # type=type-2
sw $8,($sp)                             # 存储 type 到栈
# # 输入数字
addi $sp,$sp,-8
li $8,0                                 # 对应Decin函数参数type
sw $8,($sp )                            # type参数压栈
jal Decin                               # 跳转到Decin函数
lw $a0,4($sp )                          # 加载Decin函数返回值，对应局部变量m
addi $sp,$sp,8
# # end
lw $8,($sp )                            # 加载局部变量type
beqz $8,recursive                       # 若type==0,跳转到递归计算部分
bgtz $8,find_iteration                  # 若type>0,跳转到迭代查找部分
b print_iteration                       # 否则,跳转到迭代打印部分
out_5:
li $v0,4                                # 打印err4
la $a0,err4
syscall                                 # end
b choose                                # 继续输入
# end                                        

print_iteration:
# 调用迭代打印前n个数列                                        
addi $sp,$sp,-4
sw $a0,($sp)                            # 将print_Fibonacci_iteration函数的参数n压栈
jal print_Fibonacci_iteration
addi $sp,$sp,4
b loop
# end                                        
recursive:
# 调用递归计算第n个数字                                        
addi $sp,$sp,-16
sw $a0,($sp)                            # 将Fibonacci_recursive函数的参数n压栈
jal Fibonacci_recursive
lw $a0,12($sp)                          # 加载并打印Fibonacci_recursive函数返回值
li $v0,1
syscall
la $a0,endl
li $v0,4
syscall                                 # end
addi $sp,$sp,16
b loop
# end                                        
find_iteration:
# 调用迭代查找某个数字是否属于斐波那契数列                                        
addi $sp,$sp,-8
sw $a0,($sp)                            # 将find_Fibonacci_iteration函数的参数n压栈
jal find_Fibonacci_iteration
lw $a0,4($sp)                           # 加载并打印find_Fibonacci_iteration函数返回值
li $v0 1
syscall
li $v0,4
la $a0,endl
syscall                                 # end
addi $sp,$sp,8
b loop
# end                                        
end_all:                                # 程序结束
addi $sp,$sp,4
# 打印结束界面                                        
li $v0 4
la $a0 exit_screen
syscall
# end
li $v0,10
syscall
Decin:                                  # 读取十进制函数 Decin(m,type)
Decin_begin:
lw $a0,($sp)                            # 读取参数type
li $v0,4                                # 打印提示信息
beqz $a0,tip_1
la $a0,tip2
b endif
tip_1:
la $a0,tip1
endif:
syscall                                 # end
la $a0,buffer                           # 输入字符串，对应局部变量fp
li $a1,10
li $v0,8 
syscall                                 # end
li $8,0x20                              # 对应局部变量sp ' '
li $9,0x0a                              # 对应局部变量enter '\n'
li $10,0x2d                             # 对应局部变量fh '-'
do_space1:                              # 检测前空格
lb  $17, ($a0)                          # 对应局部变量temp
addi $a0, $a0, 1                        # fp++
beqz $17, out_1                         # 检测出空串
beq $17, $9, out_1                      # 检测出空串
beq $17, $8, do_space1                  # 若检测出空格，则继续检测
beq $17, $10, out_3                     # 检测出负号
li $12,0x30                             # '0'
li $13,0x39                             # '9'
move $v0,$0                             # 对应局部变量m
li $14,10                               # 权,对应局部变量basis
do_zero:
bne $17, $12, loop1                     # 判断是否为‘0’
lb  $17, ($a0)
beqz $17, out_3                         # 检测0，出错
beq $17, $9, out_3                      # 检测0，出错
addi $a0, $a0, 1                        # fp++
b do_zero
loop1:
beq $17, $8, do_space2  
beqz $17, out_4                         # 结束
beq $17, $9, out_4                      # 结束 
blt $17, $12, out_2                     # 小于'0'，出错
bgt $17, $13, out_2                     # 大于'9'，出错
mulo $v0, $v0, $14
addi $17, $17, -48                      # ‘x’- '0'
add $v0, $v0, $17    
lb  $17, ($a0)                          # 更新temp
addi $a0, $a0, 1                        # fp++
b  loop1
do_space2:                              # 检测后空格
lb  $17, ($a0)                          # 更新temp
addi $a0, $a0, 1                        # fp++
beqz $17, out_4                         # 结束
beq $17, $9, out_4                      # 结束
beq $17, $8, do_space2
b  out_2
out_1:
li $v0,4                                # 打印err1
la $a0,err1
syscall                                 # end
b Decin_begin
out_2: 
li $v0,4                                # 打印err2
la $a0,err2
syscall                                 # end
b Decin_begin
out_3:
li $v0,4                                # 打印err3
la $a0,err3
syscall                                 # end
b Decin_begin
out_4:
sw $v0,4($sp)                           # 函数返回值压栈
jr $ra                                  # 返回
# Decin end                                        
print_Fibonacci_iteration:              # 斐波那契数列迭代算法 print_Fibonacci_iteration(n)
lw $8,($sp)                             # 加载print_Fibonacci_iteration函数参数n
move $9,$0                              # 对应局部变量pre
li $17,1                                # 对应局部变量cur
li $v0,1                                # 打印斐波那契数列第一个数
li $a0,1
syscall
li $v0,4
la $a0,sp
syscall                                 # end
loop2:
addi $8,$8,-1                           # n = n - 1
blez $8,end2                            # n <= 0则跳出循环
move $10,$17                            # 对应局部变量temp = pre
add $17,$17,$9                          # cur = cur + pre
move $9,$10                             # pre = temp
li $v0,1                                # 打印cur
move $a0,$17
syscall
li $v0,4
la $a0,sp
syscall                                 # end
b loop2
end2:
li $v0,4                                # 打印换行符
la $a0,endl
syscall                                 # end
jr $ra
# print_Fibonacci_iteration end                                        

find_Fibonacci_iteration:               # 斐波那契数列迭代算法 find_Fibonacci_iteration(index,n)
lw $8,($sp)                             # 加载find_Fibonacci_iteration函数参数n
move $9,$0                              # 对应局部变量pre
li $17,1                                # 对应局部变量cur
li $v0,1                                # 对应局部变量index
loop3:
beq $8,$17,end3                         # n == cur,找到跳出循环
blt $17,$8,content3                     # n < cur,继续查找
li $v0,-1                               # n>cur,没找到，跳出循环
b end3
content3:
addi $v0,$v0,1                          # index = index + 1
move $10,$17                            # 对应局部变量temp = pre
add $17,$17,$9                          # cur = cur + pre
move $9,$10                             # pre = cur
b loop3
end3:
sw $v0,4($sp)                           # 函数返回值压栈
jr $ra                                  # 返回
# find_Fibonacci_iteration end                                        

Fibonacci_recursive :                   # 斐波那契数列递归算法 Fr(n,Fr(n-1),Fr(n-2),re)
lw $8,($sp)                             # 加载Fibonacci_recursive函数参数n
li $9,1                                 # 对应返回值re
li $10,2
ble $8,$10,re                           # n<=2,则直接返回
addi $8,$8,-1                           # n-1
addi $sp,$sp,-20 
sw $8,($sp)                             # n-1入栈
sw $ra,16($sp)                          # $ra入栈
jal Fibonacci_recursive                 # Fr(n-1, , ,r')
lw $9,12($sp)                           # 加载r'
lw $ra,16($sp)                          # 加载$ra
addi $sp,$sp,20
sw $9,4($sp)                            # r'入栈，对应Fr(n-1)
lw $8,($sp)                             # 加载n
addi $8,$8,-2                           # n-2
addi $sp,$sp,-20
sw $8,($sp)                             # n-2入栈
sw $ra,16($sp)                          # $ra入栈
jal Fibonacci_recursive                 # Fr(n-2, , ,r'')
lw $9,12($sp )                          #加载r''
lw $ra,16($sp )                         #加载$ra
addi $sp,$sp,20
sw $9,8($sp)                            # r''入栈，对应Fr(n-2)
lw $8,4($sp)                            # 加载Fr(n-1)
add $9,$8,$9                            # re = Fr(n-1) + Fr(n-1)
re:
sw $9,12($sp)                           # 函数返回值入栈
jr $ra                                  # 返回
# Fibonacci_recursive end                                        