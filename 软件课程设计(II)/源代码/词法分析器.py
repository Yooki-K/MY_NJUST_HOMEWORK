import operator
import queue


class TYPE:
    gjc = "关键词"
    bsf = "标识符"
    cl = "常量"
    xdf = "限定符"
    ysf = "运算符"


result = []
gjz = ["auto", "break", "case", "char", "const", "continue", "default", "do", "double", "else", "enum", "extern",
       "float", "for", "goto", "if", "int", "long", "register", "return", "short", "signed", "sizeof", "static",
       "struct", "include", "while", "throw", "union", "this", "virtual", "class", "asm", "catch", "delete",
       "operator", "default", "new", "inline", "try", "switch", "private", "protected", "public", "volatile", "string",
       "void", "bool", "true", "false"]
xdf = ["(", ")", "{", "}", "[", "]", ";", ",", ":", "?", "/", "&&", "||"]
ysf = ["++", "--", '+=', '-=', '*=', '/=', "+", "-", "*", "/", "==", ">=", "<=", ">", "<", "^", "=", "!=", "%", "<<",
       ">>", "&", "|", "~"]


# bsf = []

class DFA:
    K = {}  # 状态集合（非终结符集）  {状态: {弧 : [到达的状态]}}
    S = []  # 初态集合  [初态,初态,...]
    Z = []  # 终态集合  [终态,终态,...]
    sigma = ''  # 弧集合（终结符集）
    closures = []  # 子集集合 [子集,子集,... ] 子集表示为列表[状态,状态,...]

    # 初始化DFA，对输入的数据进行简单处理罢了
    def __init__(self, sigma, S, Z, closures: list, data):
        self.sigma = sigma
        self.closures = closures
        self.K = data
        for x in closures:
            if S in x:
                self.S.append(closures.index(x))
        for x in closures:
            for y in Z:
                if y in x:
                    self.Z.append(closures.index(x))

    # DFA工作处理输入字符串 使用bfs算法
    def work(self, string):
        q = queue.Queue()  # 队列
        q.put([self.S[0], 0])  # 压入初态
        while not q.empty():
            u = q.get()
            if u[1] == len(string):  # 是否到达字符串末端
                if u[0] in self.Z:  # 是否处于终态
                    return True
                else:
                    return False
            c = string[u[1]]
            t = u[0]
            if t in self.K and c in self.K[t]:  # 是否存在路径
                res = self.K[t][c]
                for y in res:
                    q.put([y, u[1] + 1])  # 压入新状态
            else:
                return False


class NFA:
    data = {}  # 子集之间联系 {子集下标: {弧 : [到达的子集下标]}}
    K = {}  # 状态集合（非终结符集）  {状态: {弧 : [到达的状态]}}
    S = []  # 初态集合  [初态,初态,...]
    Z = []  # 终态集合  [终态,终态,...]
    sigma = ''  # 弧集合（终结符集）
    closures = []  # 子集集合 [子集,子集,... ] 子集表示为[状态,状态,...]
    closuresTemp = []  # 子集集合缓存 保存尚为被标记的子集

    # 从正规文法转换成NFA
    def __init__(self, filename):
        f = open(filename, 'r', encoding='utf-8')
        content = f.readlines()
        f.close()
        for x in content:
            x = x.replace('\n', '')
            if x.find(':') != -1:
                temp = x.split(':')
                if temp[0] == 'K':
                    for y in temp[1]:
                        self.K[y] = {}
                elif temp[0] == 'S':
                    self.S = temp[1]
                elif temp[0] == 'sigma':
                    temp[1] += temp[2]
                    self.sigma = temp[1]
            elif x.find('->') != -1:
                temp = x.split('->')
                if len(temp[1]) == 1:
                    if '' in self.K[temp[0]]:
                        self.K[temp[0]][''].append(temp[1][0])
                    else:
                        self.K[temp[0]][''] = [temp[1][0]]
                elif len(temp[1]) == 2:
                    if temp[1][0] in self.K[temp[0]]:
                        self.K[temp[0]][temp[1][0]].append(temp[1][1])
                    else:
                        self.K[temp[0]][temp[1][0]] = [temp[1][1]]
                else:
                    self.Z += temp[0]
        pass

    # 初始化e-closure
    def initClosure(self):
        key = self.S
        d = [key]
        for x in self.K[key]:
            if x == '':
                d += self.K[key][x]
        self.closuresTemp.append(d)

    # 创建e-closure()
    def createNode(self, keys: list, s, route):
        d = keys
        for key in keys:
            for x in self.K[key]:
                if x == '':
                    d += self.K[key][x]
        d.sort()  # 新子集
        isRepeat = False
        i = 0
        j = 0
        for i in range(0, len(self.closures)):  # 判断子集是否已经存在在子集集合
            if operator.eq(self.closures[i], d):
                isRepeat = True
                break
        if not isRepeat:
            if len(self.closures) > 0:
                i = i + 1
            for j in range(0, len(self.closuresTemp)):  # 判断子集是否已经存在在子集集合缓存
                if operator.eq(self.closuresTemp[j], d):
                    isRepeat = True
                    break
        if not isRepeat:
            if len(self.closuresTemp) > 0:
                j = j + 1
            self.closuresTemp.append(d)  # 添加到子集缓存
        if s not in self.data:
            self.data[s] = {}
        if route not in self.data[s]:
            self.data[s][route] = []
        self.data[s][route].append(i + j)  # 生成一条弧

    # 遍历所有弧，进行move计算
    def move(self):
        for route in self.sigma:
            t = []
            for x in self.closuresTemp[0]:  # 取缓存栈底
                if route in self.K[x]:
                    t += self.K[x][route]
            if len(t) > 0:
                self.createNode(t, len(self.closures), route)  # 生成新子集到缓存
        self.closures.append(self.closuresTemp.pop(0))  # 弹出缓存栈底到子集集合

    # 转化成DFA
    def toDFA(self):
        self.initClosure()
        while len(self.closuresTemp) > 0:  # 直到缓存为空
            self.move()
        pass
        return DFA(self.sigma, self.S, self.Z, self.closures, self.data)


def printToken(index, Type, content):
    global result
    result.append("%d %s %s\n" % (index, Type, content))
    print("(%3d , %s , %s )" % (index, Type, content))


# 分析源程序代码
def analysisDemo(content, dfa):
    index = 0
    for x in content:
        x = x.replace('\n', '')
        x = x.replace('\\\\', '\\')
        index = index + 1
        while len(x) > 0:
            state = 0
            if x[0] == ' ':
                x = x[1:]
                continue
            if x[0] in xdf:  # 判断是否为限定符
                printToken(index, TYPE.xdf, x[0])
                x = x[1:]
                state = 1
            if x[0:2] in xdf:  # 判断是否为限定符
                printToken(index, TYPE.xdf, x[0:2])
                x = x[2:]
                state = 1
            if state > 0:
                continue
            for a in ysf:  # 判断是否为运算符
                if x.startswith(a):
                    x = x[len(a):]
                    printToken(index, TYPE.ysf, a)
                    state = 2
                    break
            if state > 0:
                continue
            if x[0].isalpha():
                for a in gjz:
                    if x.startswith(a):  # 判断是否为关键词
                        t = x[len(a):len(a) + 1]
                        if t.isalpha() or t.isdigit():
                            continue
                        printToken(index, TYPE.gjc, a)
                        x = x[len(a):]
                        state = 3
                        break
            if state > 0:
                continue
            r = x.find(' ')
            if r == -1:
                r = len(x)
            for a in xdf:
                temp = x.find(a)
                if temp != -1:
                    r = min(r, temp)
            for a in ysf:
                temp = x.find(a)
                if temp != -1:
                    if a == '+' and x.find('E+') != -1:
                        continue
                    if a == '+' and x.replace(' ', '').find('i)') != -1:
                        continue
                    r = min(r, temp)
            if x[0] == '\"':
                ii = 1
                while ii < len(x):
                    r_ = x[ii:].find('"')
                    if r_ != -1 and x[r_] != '\\':
                        r = r_ + 1 + ii
                        break
                    else:
                        if r_ == -1:
                            break
                        ii = r_ + 1 + ii
            re = dfa.work(x[0:r])
            if re:
                if x[0].isalpha():
                    printToken(index, TYPE.bsf, x[0:r])
                else:
                    printToken(index, TYPE.cl, x[0:r])
            else:
                print('No: %d ' % index + x[0:r])
                return False
            x = x[r:]
    return True
