from copy import deepcopy
import string

TAC = []  # 四元组


class DATA:
    yuyi = []  # 语义函数集合
    rules = []  # 文法产生式集合
    first = {}  # first集合 {非终结符:(终结符，终结符,...)}
    items = []  # 项目集集合
    d = []  # 项目集未进行闭包时的集合
    K = {}  # 非终结符集
    S = ''  # 开始符
    sigma = []  # 终结符集

def printTitle(title):
    print('\n' + title.center(100, "-"))


def printFirst():
    printTitle('First集合')
    for x in DATA.first:
        print("FIRST( %s ) = %s" % (x, ' '.join(DATA.first[x])))


def printAnalysisTable():
    printTitle('预测分析表')
    action = ""
    for x in DATA.sigma:
        action += x.ljust(20, ' ')
    goto = ""
    for x in DATA.K:
        goto += x.ljust(20, ' ')

    print('状态   |' + 'ACTION'.ljust(len(action) - 1, ' ') + "|" + 'GOTO'.ljust(len(goto), ' '))
    print('      ' + action + goto)
    i = 0
    for x in DATA.items:
        print("%-6d" % i, end='')
        for y in DATA.sigma:
            if y in x.child:
                if type(x.child[y]) == int:
                    print(('S_' + str(x.child[y])).ljust(20, ' '), end='')
                else:
                    if x.child[y] == 'acc':
                        print('acc'.ljust(20, ' '), end='')
                    else:
                        print(('r_' + str(DATA.rules.index(x.child[y]))).ljust(20, ' '), end='')
            else:
                print(''.ljust(20, ' '), end='')
        for y in DATA.K:
            if y in x.child:
                print(str(x.child[y]).ljust(20, ' '), end='')
            else:
                print(''.ljust(20, ' '), end='')
        print()
        i = i + 1


def printItem(index):
    u: Item = DATA.items[index]
    printTitle('状态%d' % index)
    for x in u.data:
        for y in u.data[x]:
            for z in u.data[x][y]:
                print("%s->%s , %s" % (x, ' '.join(z[0][0:z[1]] + ['·'] + z[0][z[1]:]), '/'.join(z[2])))
    printTitle('子结点')
    for x in u.child:
        if type(u.child[x]) == int:
            print('-> %s -> %s' % (x.center(20, ' '), u.child[x]))
    printTitle('结束')


class Item:

    def __init__(self, d):
        self.child = {}
        self.content = {}
        self.data = deepcopy(d)
        DATA.d.append(deepcopy(d))
        # 进行闭包
        while True:
            isOK = True
            Temp = {}
            for xx in d:
                for yy in d[xx]:
                    for zz in d[xx][yy]:
                        if zz[1] == len(zz[0]):
                            continue
                        c = zz[0][zz[1]]
                        if c in DATA.K:
                            if c not in Temp:
                                Temp[c] = {}
                            if c not in self.data:
                                self.data[c] = {}
                            for z in DATA.K[c]:
                                if z not in Temp[c]:
                                    Temp[c][z] = []
                                if z not in self.data[c]:
                                    self.data[c][z] = []
                                for k in DATA.K[c][z]:
                                    te = zz[0][zz[1] + 1:]
                                    te.append(zz[2])
                                    l = [k, 0, getFirst(te)]
                                    Temp[c][z].append(l)
                                    try:
                                        self.data[c][z].index(l)
                                    except ValueError:
                                        self.data[c][z].append(l)
                                        if k[0] in DATA.K:
                                            isOK = False
            d = deepcopy(Temp)
            if isOK:
                break

        # 为生成新项目集做准备
        for x in self.data:
            for y in self.data[x]:
                for z_ in self.data[x][y]:
                    if z_[1] == len(z_[0]):
                        for k in z_[2]:
                            if k not in self.child:
                                self.child[k] = ''
                            if x == DATA.S:
                                self.child[k] = 'acc'
                            else:
                                self.child[k] = x + '->' + ' '.join(z_[0])
                        continue
                    c = z_[0][z_[1]]
                    if c not in self.content:
                        self.content[c] = {}
                    if x not in self.content[c]:
                        self.content[c][x] = []
                    self.content[c][x].append(z_)
        DATA.items.append(self)
        self.createChildren()
        pass

    def createChildren(self):
        for x in self.content:
            d = {}
            for y in self.content[x]:
                for z in self.content[x][y]:
                    if y not in d:
                        d[y] = {}
                    if z[0][0] not in d[y]:
                        d[y][z[0][0]] = []
                    d[y][z[0][0]].append([z[0], z[1] + 1, z[2]])
            if len(d) > 0:
                try:
                    index = DATA.d.index(d)
                    self.child[x] = index
                except ValueError:
                    self.child[x] = len(DATA.items)
                    Item(d)


def LR1(filename):
    f = open(filename, 'r', encoding='utf-8')
    content = f.readlines()
    f.close()
    for x in content:
        x = x.replace('\n', '')
        if x.find(':=') == -1 and x.find(':') != -1:
            temp = x.split(':')
            if temp[0] == 'K':
                for y in temp[1].split(' '):
                    DATA.K[y] = {}
            elif temp[0] == 'S':
                DATA.S = temp[1]
            elif temp[0] == 'sigma':
                DATA.sigma = temp[1].split(' ')
        elif x.find('->') != -1:
            m = x.find('{')
            if m == -1:
                DATA.rules.append(x)
                DATA.yuyi.append('')
            else:
                DATA.rules.append(x[0:m])
                DATA.yuyi.append(x[m:])
                x = x[0:m]
            temp = x.split('->')
            temp_ = temp[1].split(' ')
            if temp_[0] in DATA.K[temp[0]]:
                DATA.K[temp[0]][temp_[0]].append(temp_)
            else:
                DATA.K[temp[0]][temp_[0]] = [temp_]
    # 生成First集
    createFirst()
    # 生成项目集
    for x in DATA.K[DATA.S]:
        Item({DATA.S: {x: [[DATA.K[DATA.S][x][0], 0, set('#')]]}})


# 创建First集合
def createFirst():
    s = {}
    t = []
    for x in DATA.K:
        isOk = True
        for y in DATA.K[x]:
            if y in DATA.K and y != x:
                if x not in DATA.first:
                    DATA.first[x] = set()
                if x in s:
                    s[x].append(y)
                else:
                    s[x] = [y]
                isOk = False

            elif y in DATA.sigma:
                if x not in DATA.first:
                    DATA.first[x] = set()
                DATA.first[x].add(y)
        if isOk:
            t.append(x)
    while len(s) > 0:
        for x in s:
            if len(s[x]) == 0:
                s.pop(x)
                t.append(x)
                break
            else:
                for y in s[x]:
                    if y in t:
                        DATA.first[x] = DATA.first[x].union(DATA.first[y])
                        s[x].remove(y)
    printFirst()


# 获得当前字符串的First
def getFirst(s) -> set:
    need = set()
    i = 0
    while i < len(s):
        if type(s[i]) == set:
            need = need.union(s[i])
            break
        else:
            if s[i] in DATA.sigma and s[i] != '$':
                need.add(s[i])
                break
            elif s[i] in DATA.K:
                need = need.union(DATA.first[s[i]])
                if '$' not in DATA.K[s[i]]:
                    break
        i = i + 1
    return need


def addFirst(mes):
    a = ''
    for x in DATA.first:
        a += "<tr><td>FIRST( %s )=%s</td></tr>" % (x, '&nbsp&nbsp&nbsp'.join(DATA.first[x]))
    return mes.replace('(First)', a)


def addAnalysisTable(mes: str):
    l1 = len(DATA.sigma)
    l2 = len(DATA.K)
    mes = mes.replace('(LR1_2_width)', str((l1 + l2) * 80))
    a = '<tr><td rowspan="2">状态</td><td colspan="%d">ACTION</td><td colspan="%d">GOTO</td></tr>\n<tr>' % (l1, l2)
    for x in DATA.sigma:
        a += "<td>%s</td>" % x
    for x in DATA.K:
        a += "<td>%s</td>" % x
    a += '</tr>\n'
    i = 0
    for x in DATA.items:
        a += '<tr><td>%d</td>' % i
        for y in DATA.sigma:
            if y in x.child:
                if type(x.child[y]) == int:
                    a += '<td>S_%d</td>' % x.child[y]
                else:
                    if x.child[y] == 'acc':
                        a += '<td>acc</td>'
                    else:
                        a += '<td>r_%d</td>' % DATA.rules.index(x.child[y])
            else:
                a += '<td></td>'
        for y in DATA.K:
            if y in x.child:
                a += '<td>%d</td>' % x.child[y]
            else:
                a += '<td></td>'
        a += '</tr>\n'
        i = i + 1
    mes = mes.replace('(LR1_2_height)', str(i * 10))
    mes = mes.replace('(LR1_2)', a)
    return mes


# 分析Token表
def analysisTokens(string: list, mes: str):
    global TAC
    printTitle('分析过程')
    string.append('#')
    stack = [[0, '#', '-']]  # 语义栈
    i = 0
    index = 0
    a = ''
    while len(stack) > 0:
        index = index + 1
        c = string[i]
        state_cur = stack[-1]
        if c[0] not in DATA.items[state_cur[0]].child:
            if '$' in DATA.items[state_cur[0]].child:
                c[0] = '$'
        if c[0] in DATA.items[state_cur[0]].child:
            temp = DATA.items[state_cur[0]].child[c[0]]
            if type(temp) == str:
                print('步骤:%d' % index)
                print('状态栈:%s' % str(stack))
                print('余留符号串:%s' % string[i:])
                print('分析动作:%s\n' % temp)
                a += '<tr class=\'bz\'><td>步骤</td><td>%d</td></tr>' % index
                a += '<tr><td>状态栈</td><td>%s</td></tr>' % str(stack)
                a += '<tr><td>余留符号串</td><td>%s</td></tr>' % string[i:]
                a += '<tr><td>分析动作</td><td>%s</td></tr>' % temp
                if temp == 'acc':
                    print(state_cur[2])
                    return True, mes.replace('(process2)', a)
                else:
                    t = temp.split('->')
                    tt = t[1].split(' ')
                    ii = len(tt)
                    paras = []  # 弹出的值
                    while ii > 0:
                        ii = ii - 1
                        temp_digit = stack.pop()[2]
                        if type(temp_digit) != str:
                            paras.append(temp_digit)
                    if t[0] not in DATA.items[stack[-1][0]].child:
                        if '$' in DATA.items[stack[-1][0]].child:
                            t[0] = '$'
                    if t[0] in DATA.items[stack[-1][0]].child:
                        try:
                            index1 = DATA.rules.index(temp)
                            m = DATA.yuyi[index1]
                            n = '-'  # 进行语义计算
                            if '+' in m:
                                n = paras[1] + paras[0]
                                TAC.append(('+', paras[1], paras[0], n))
                            elif '-' in m:
                                n = paras[1] - paras[0]
                                TAC.append(('-', paras[1], paras[0], n))
                            elif '*' in m:
                                n = paras[1] * paras[0]
                                TAC.append(('*', paras[1], paras[0], n))
                            elif '/' in m:
                                n = paras[1] / paras[0]
                                TAC.append(('/', paras[1], paras[0], n))
                            elif ':=' in m:
                                n = paras[0]
                            stack.append([DATA.items[stack[-1][0]].child[t[0]], t[0], n])
                        except Exception as e:
                            print(e)
                            return i, mes.replace('(process2)', a)
                    else:
                        return i, mes.replace('(process2)', a)

            elif type(temp) == int:
                print('步骤:%d' % index)
                print('状态栈:%s' % str(stack))
                print('余留符号串:%s' % string[i:])
                print('分析动作:S_%d\n' % temp)
                a += '<tr class=\'bz\'><td>步骤</td><td>%d</td></tr>' % index
                a += '<tr><td>状态栈</td><td>%s</td></tr>' % str(stack)
                a += '<tr><td>余留符号串</td><td>%s</td></tr>' % string[i:]
                a += '<tr><td>分析动作</td><td>S_%d</td></tr>' % temp
                stack.append([temp, c[0], c[1]])
                if c[0] != '$':
                    i = i + 1
        else:
            return i, mes.replace('(process2)', a)
