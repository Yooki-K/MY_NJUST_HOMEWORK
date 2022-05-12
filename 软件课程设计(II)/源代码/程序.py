from 词法分析器 import *
import 语法分析器 as yf
import 语义分析器 as yy
from tkinter import filedialog, Tk
import os


# pyinstaller 程序.py 语义分析器.py 语法分析器.py 词法分析器.py

def selectPath(tip):
    print(tip)
    root = Tk()
    root.withdraw()
    while True:
        path = filedialog.askopenfilename(filetypes=(('文本文件', '*.txt'),), initialdir=os.getcwd())
        if path != '':
            break
    path = path.replace("/", "\\\\")
    print(path)
    return path


def readFile(filename, isList):
    with open(filename, 'r', encoding='utf-8') as f:
        if isList:
            return f.readlines()
        else:
            return f.read()


def writeFile(filename, content, isList):
    with open(filename, 'w', encoding='utf-8') as f:
        if isList:
            f.writelines(content)
        else:
            f.write(content)


def queryItem(r):
    # 用户查询单个项目集
    while True:
        n = input('\n请输入想获得的项目集：')
        try:
            n = int(n)
            if n < 0:
                print('退出')
                break
            if r == 1:
                yf.printItem(n)
            else:
                yy.printItem(n)
        except Exception as e:
            print(e)
            pass


def addSrc(mes):
    a = ''
    for i in range(0, len(result)):
        if i < len(src):
            a += '<tr><td >%s</td><td >%s</td></tr>' % (src[i].replace(' ', '&ensp;'), result[i])
        else:
            a += '<tr><td ></td><td >%s</td></tr>' % (result[i])
    return mes.replace('(src)', a)


if __name__ == '__main__':
    while True:
        n = input('\n请选择 词法分析0 or 语法分析1 or 语义分析2:')
        try:
            n = int(n)
            if n < 0:
                print('退出')
            break
        except Exception as e:
            print(e)
            pass
    TokenFilename = 'Token.txt'
    htmlFilename = 'template.html'
    resultFilename = 'result.html'
    zgPath = selectPath('请选择正规文法产生式文件')
    if n != 0:
        grammarFilename = selectPath('请选择文法产生式文件')
    filename = selectPath('请选择源代码文件')
    a = NFA(zgPath)
    dfa = a.toDFA()
    Mes = readFile(htmlFilename, False)
    src = readFile(filename, True)
    re1 = analysisDemo(src, dfa)
    if re1:
        writeFile(TokenFilename, result, True)
        print('生成Token文件Token.txt!')
    if n != 0:
        if re1:
            Mes = addSrc(Mes)
            s = []
            if n != 1:
                yy.LR1(grammarFilename)
                Mes = yy.addFirst(Mes)
                Mes = yy.addAnalysisTable(Mes)
                yy.printAnalysisTable()
                for x in result:
                    x = x.replace('\n', '').split(' ')
                    if x[1] == TYPE.cl:
                        s.append(['const', int(x[2])])
                    else:
                        s.append([x[2], '-'])
                re2, Mes = yy.analysisTokens(s, Mes)
                if re2 is not True:
                    print('NO')
                    if re2 >= len(result):
                        temp = result[len(result) - 1].replace('\n', '').split(' ')
                    else:
                        temp = result[re2].replace('\n', '').split(' ')
                    column = src[int(temp[0]) - 1].find(temp[2])
                    print('%s:%d' % (temp[0], column))
                    print(src[int(temp[0]) - 1])
                    print(''.join([' ' for x in range(0, column)]) + '^')
                a = ''
                yy.printTitle("四元式")
                for x in yy.TAC:
                    a += "<tr><td>%s</td><td>%.3f</td><td>%.3f</td><td>%.3f</td></tr>" % x
                    print("(%s , %.3f , %.3f , %.3f)" % x)
                Mes = Mes.replace('(result2)', a)
                Mes = Mes.replace('(?)', '语义')
                Mes = Mes.replace('(yes_or_no2)', '<div class="title" style="font-size:15px">四元式</div>')
            else:
                yf.LR1(grammarFilename)
                Mes = yf.addFirst(Mes)
                Mes = yf.addAnalysisTable(Mes)
                yf.printAnalysisTable()
                for x in result:
                    x = x.replace('\n', '').split(' ')
                    if x[1] == TYPE.bsf or x[1] == TYPE.cl:
                        s.append(x[1].replace(TYPE.bsf, 'id').replace(TYPE.cl, 'const'))
                    else:
                        if x[2] == 'true' or x[2] == 'false':
                            s.append('const')
                        else:
                            s.append(x[2])
                re2, Mes = yf.analysisTokens(s, Mes)
                a = ''
                if re2 is True:
                    Mes = Mes.replace('(yes_or_no2)', '<div class="title" style="font-size:15px">YES</div>')
                    print('YES')
                else:
                    Mes = Mes.replace('(yes_or_no2)', '<div class="title" style="font-size:15px">NO</div>')
                    print('NO')
                    i = 0
                    for x in re2:
                        if x[0] - i >= len(result):
                            temp = result[len(result) - 1].replace('\n', '').split(' ')
                        else:
                            temp = result[x[0] - i].replace('\n', '').split(' ')
                        column = src[int(temp[0]) - 1].find(temp[2])
                        a += '<tr><td class=\'boder-top\'>%s:%d: error:%s</td></tr>' % (temp[0], column, x[1])
                        a += '<tr><td >%s</td></tr>' % src[int(temp[0]) - 1].replace(' ', '&ensp;')
                        a += '<tr class=\'red\'><td >%s^</td></tr>' % ''.join(['&ensp;' for x in range(0, column)])
                        print('%d. %s:%d: error:%s' % (i, temp[0], column, x[1]))
                        print(src[int(temp[0]) - 1], end='')
                        print(''.join([' ' for x in range(0, column)]) + '^')
                        i = i + 1
                Mes = Mes.replace('(result2)', a)
                Mes = Mes.replace('(?)', '语法')
            print('生成结果文件result.html!')
            writeFile(resultFilename, Mes, False)
            queryItem(n)  # 用户查询单个项目集信息
    else:
        input()