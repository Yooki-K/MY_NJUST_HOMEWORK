from copy import deepcopy
import string


class DATA:
    rules = []  # 文法产生式集合
    first = {}  # first集合 {非终结符:(终结符，终结符,...)}
    items = []  # 项目集集合
    d = []  # 项目集未进行闭包时的集合
    K = {}  # 非终结符集
    S = ''  # 开始符
    sigma = []  # 终结符集


message = [
    'except ;',
    'declaration does not declare anything',
    'except }',
    'except )',
    'except ]',
]


def judge(child):
    if ';' in child:
        return [message[0], ';']
    elif 'id' in child:
        return [message[1], 'id']
    elif '}' in child:
        return [message[2], '}']
    elif ')' in child:
        return [message[3], ')']
    elif ']' in child:
        return [message[4], ']']
    else:
        return ['undefined error', None]


def printTitle(title):
    print('\n' + title.center(100, "-"))


def printFirst():
    printTitle('First集合')
    for x in DATA.first:
        print("FIRST( %s ) = %s" % (x, ' '.join(DATA.first[x])))


def addFirst(mes):
    a = ''
    for x in DATA.first:
        a += "<tr><td>FIRST( %s )=%s</td></tr>" % (x, '&nbsp&nbsp&nbsp'.join(DATA.first[x]))
    return mes.replace('(First)', a)


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
    child = {}  # 表示ACTION和GOTO {GOTO,ACTION} GOTO表示为{非终结符:项目集下标} ACTION表示为{终结符:文法产生式}
    content = {}  # 处理过后的内容 {活前缀后面一个符号:{非终结符:[[文法产生式,活前缀长度,向前搜索符集合()]]}}
    data = {}  # 内容 {非终结符:{文法产生式第一个符号:[[文法产生式,活前缀长度,向前搜索符集合()]]}}

    # 进行闭包处理生成项目集
    def __init__(self, d):
        self.child = {}
        self.content = {}
        self.data = deepcopy(d)
        DATA.d.append(deepcopy(d))
        # 进行闭包处理
        while True:
            isOK = True
            Temp = {}  # 一轮中新增的项目
            for xx in d:
                for yy in d[xx]:
                    for zz in d[xx][yy]:
                        if zz[1] == len(zz[0]):  # 已经到顶了
                            continue
                        c = zz[0][zz[1]]  # 活前缀后面第一个符号
                        if c in DATA.K:
                            if c not in Temp:
                                Temp[c] = {}
                            if c not in self.data:
                                self.data[c] = {}
                            for z in DATA.K[c]:  # 遍历c的文法产生式
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
            d = deepcopy(Temp)  # 深复制新增项目，继续进行闭包处理
            if isOK:
                break
        # 为生成新项目集做准备，生成self.content
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
        self.createChildren()  # 生成新项目集
        pass

    # 创建新项目集
    def createChildren(self):
        for x in self.content:  # x->弧
            d = {}
            # 创建一个项目集（未进行闭包处理）
            for y in self.content[x]:
                for z in self.content[x][y]:
                    if y not in d:
                        d[y] = {}
                    if z[0][0] not in d[y]:
                        d[y][z[0][0]] = []
                    d[y][z[0][0]].append([z[0], z[1] + 1, z[2]])
            if len(d) > 0:  # 查找是否已经存在与项目集集合
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
        if x.find(':') != -1:
            temp = x.split(':')
            if temp[0] == 'K':  # 非终结符
                for y in temp[1].replace('\n', '').split(' '):
                    DATA.K[y] = {}
            elif temp[0] == 'S':  # 初态
                DATA.S = temp[1].replace('\n', '')
            elif temp[0] == 'sigma':  # 终结符
                DATA.sigma = temp[1].replace('\n', '').split(' ')
        elif x.find('->') != -1:
            DATA.rules.append(x.replace('\n', ''))
            temp = x.split('->')
            temp_ = temp[1].replace('\n', '').split(' ')
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
    t = []  # First集合全为终结符的非终结符集合
    for x in DATA.K:
        isOk = True
        for y in DATA.K[x]:
            if y in DATA.K and y != x:  # first集合中加入非终结符，则存到s中
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
            if len(s[x]) == 0:  # first集合中无非终结符，则加入t,并从s中弹出
                s.pop(x)
                t.append(x)
                break
            else:
                for y in s[x]:
                    if y in t:
                        DATA.first[x] = DATA.first[x].union(DATA.first[y])
                        s[x].remove(y)
    printFirst()  # 打印First集合


# 获得当前符号列表的First
def getFirst(s) -> set:
    need = set()
    i = 0
    while i < len(s):
        if type(s[i]) == set:
            need = need.union(s[i])  # 合并
            break
        else:
            if s[i] in DATA.sigma and s[i] != '$':  # 如果是空集，则继续
                need.add(s[i])
                break
            elif s[i] in DATA.K:
                need = need.union(DATA.first[s[i]])
                if '$' not in DATA.K[s[i]]:  # 如果可以产生空集，则继续
                    break
        i = i + 1
    return need


# 分析Token表
def analysisTokens(string: list, mes: str):
    errors = []  # 错误信息集合
    printTitle('分析过程')
    string.append('#')  # 输入栈
    state = [0]  # 状态栈
    fhs = ['#']  # 符号栈
    i = 0
    index = 0
    a = ''
    while len(state) > 0:
        index = index + 1
        c = string[i]
        state_cur = state[-1]
        if c not in DATA.items[state_cur].child:  # 判断输入符号是否在预测表中，若不在，换成空字符串试试
            if '$' in DATA.items[state_cur].child:
                c = '$'
        if c in DATA.items[state_cur].child:
            temp = DATA.items[state_cur].child[c]
            if type(temp) == str: # 归约
                print('步骤:%d' % index)
                print('状态栈:%s' % str(state))
                print('符号栈:%s' % ','.join(fhs))
                print('输入栈:%s' % string[i:])
                print('Action:%s' % temp)
                a += '<tr class=\'bz\'><td>步骤</td><td>%d</td></tr>' % index
                a += '<tr><td>状态栈</td><td>%s</td></tr>' % str(state)
                a += '<tr><td>符号栈</td><td>%s</td></tr>' % ','.join(fhs)
                a += '<tr><td>输入栈</td><td>%s</td></tr>' % string[i:]
                a += '<tr><td>Action</td><td>%s</td></tr>' % temp
                if temp == 'acc':  # 接受，成功
                    print('GOTO:%s\n' % 'None')
                    a += '<tr><td>GOTO</td><td>None</td></tr>'
                    if len(errors) == 0:
                        return True, mes.replace('(process2)', a)
                    else:
                        return errors, mes.replace('(process2)', a)
                else:  # 归约
                    t = temp.split('->')
                    tt = t[1].split(' ')
                    ii = len(tt)
                    fhs = fhs[:-ii] + [t[0]]
                    while ii > 0: # 状态弹栈
                        ii = ii - 1
                        state.pop()
                    if t[0] not in DATA.items[state[-1]].child:
                        if '$' in DATA.items[state[-1]].child:
                            t[0] = '$'
                    if t[0] in DATA.items[state[-1]].child:
                        state.append(DATA.items[state[-1]].child[t[0]])  # 压入新状态
                    else:
                        errMes = judge(DATA.items[state[-1]].child)  # 判断错误信息
                        errors.append([i, errMes[0]])
                        if errMes[1] is None:  # 若为未定义错误信息，直接报错
                            return errors, mes.replace('(process2)', a)
                        string.insert(i, errMes[1])
                    a += '<tr><td>GOTO</td><td>%d</td></tr>' % state[-1]
                    print('GOTO:%d\n' % state[-1])

            elif type(temp) == int:  # 移进
                print('步骤:%d' % index)
                print('状态栈:%s' % str(state))
                print('符号栈:%s' % ','.join(fhs))
                print('输入栈:%s' % string[i:])
                print('Action:%s' % 'None')
                print('GOTO:%d\n' % temp)
                a += '<tr class=\'bz\'><td>步骤</td><td>%d</td></tr>' % index
                a += '<tr><td>状态栈</td><td>%s</td></tr>' % str(state)
                a += '<tr><td>符号栈</td><td>%s</td></tr>' % ','.join(fhs)
                a += '<tr><td>输入栈</td><td>%s</td></tr>' % string[i:]
                a += '<tr><td>Action</td><td>None</td></tr>'
                a += '<tr><td>GOTO</td><td>%d</td></tr>' % temp
                state.append(temp)
                fhs.append(c)
                if c != '$':
                    i = i + 1
        else:
            errMes = judge(DATA.items[state[-1]].child)
            errors.append([i, errMes[0]])
            if errMes[1] is None:
                return errors, mes.replace('(process2)', a)
            string.insert(i, errMes[1])
