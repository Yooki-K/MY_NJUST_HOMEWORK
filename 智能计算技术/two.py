from time import time
import random
import matplotlib.pyplot as plt
shape_score = [(50, (0, 1, 1, 0, 0)),
               (50, (0, 0, 1, 1, 0)),
               (200, (1, 1, 0, 1, 0)),
               (500, (0, 0, 1, 1, 1)),
               (500, (1, 1, 1, 0, 0)),
               (5000, (0, 1, 1, 1, 0)),
               (5000, (0, 1, 0, 1, 1, 0)),
               (5000, (0, 1, 1, 0, 1, 0)),
               (5000, (1, 1, 1, 0, 1)),
               (5000, (1, 1, 0, 1, 1)),
               (5000, (1, 0, 1, 1, 1)),
               (5000, (1, 1, 1, 1, 0)),
               (5000, (0, 1, 1, 1, 1)),
               (50000, (0, 1, 1, 1, 1, 0)),
               (99999999, (1, 1, 1, 1, 1))]
def game_tree(is_prune):
    if is_prune:
        maxmin_with_prune(True, DEPTH, -99999999, 99999999)
    else:
        maxmin(True, DEPTH)
    return next_point[0], next_point[1]
def maxmin_with_prune(is_black, depth, alpha, beta):
    """
    maxmin算法搜索 alpha + beta剪枝
    """
    if is_win(list1) or is_win(list2) or depth == 0:
        return evaluation(is_black)

    blank_list = list(set(list_all).difference(set(list3)))
    order(blank_list)  # 搜索顺序排序
    for next_step in blank_list:
        if not has_neighbor(next_step):
            continue
        if is_black:
            list1.append(next_step)
        else:
            list2.append(next_step)
        list3.append(next_step)
        value = -maxmin_with_prune(not is_black, depth - 1, -beta, -alpha)
        if is_black:
            list1.remove(next_step)
        else:
            list2.remove(next_step)
        list3.remove(next_step)
        if value > alpha:
            if depth == DEPTH:
                next_point[0] = next_step[0]
                next_point[1] = next_step[1]
            # alpha + beta剪枝点
            if value >= beta:
                return beta
            alpha = value
    return alpha

def maxmin(is_black, depth):
    """
    maxmin算法搜索
    """
    # 游戏是否结束 | | 探索的递归深度是否到边界
    if is_win(list1) or is_win(list2) or depth == 0:
        return evaluation(is_black)
    blank_list = list(set(list_all).difference(set(list3)))
    order(blank_list)  # 搜索顺序排序
    value = -99999999
    if not is_black:
        value = -value
    for next_step in blank_list:
        if not has_neighbor(next_step):
            continue
        if is_black:
            list1.append(next_step)
        else:
            list2.append(next_step)
        list3.append(next_step)
        value = - maxmin(not is_black, depth - 1)
        if is_black:
            list1.remove(next_step)
        else:
            list2.remove(next_step)
        list3.remove(next_step)
        if depth == DEPTH:
            next_point[0] = next_step[0]
            next_point[1] = next_step[1]
    return value

# 离最后落子的邻居位置最有可能是最优点
def order(blank_list):
    last_pt = list3[-1]
    for i in range(-1, 2):
        for j in range(-1, 2):
            if i == 0 and j == 0:
                continue
            if (last_pt[0] + i, last_pt[1] + j) in blank_list:
                blank_list.remove((last_pt[0] + i, last_pt[1] + j))
                blank_list.insert(0, (last_pt[0] + i, last_pt[1] + j))


def has_neighbor(pt):
    for i in range(-1, 2):
        for j in range(-1, 2):
            if i == 0 and j == 0:
                continue
            if (pt[0] + i, pt[1] + j) in list3:
                return True
    return False

# 评估函数
def evaluation(is_black):
    if is_black:
        my_list = list1
        enemy_list = list2
    else:
        my_list = list2
        enemy_list = list1
    # 算自己的得分
    score_all_arr = []
    my_score = 0
    for pt in my_list:
        m = pt[0]
        n = pt[1]
        my_score += cal_score(m, n, 0, 1, enemy_list, my_list, score_all_arr)
        my_score += cal_score(m, n, 1, 0, enemy_list, my_list, score_all_arr)
        my_score += cal_score(m, n, 1, 1, enemy_list, my_list, score_all_arr)
        my_score += cal_score(m, n, -1, 1, enemy_list, my_list, score_all_arr)
    #  算对手的得分
    score_all_arr_enemy = []
    enemy_score = 0
    for pt in enemy_list:
        m = pt[0]
        n = pt[1]
        enemy_score += cal_score(m, n, 0, 1, my_list, enemy_list, score_all_arr_enemy)
        enemy_score += cal_score(m, n, 1, 0, my_list, enemy_list, score_all_arr_enemy)
        enemy_score += cal_score(m, n, 1, 1, my_list, enemy_list, score_all_arr_enemy)
        enemy_score += cal_score(m, n, -1, 1, my_list, enemy_list, score_all_arr_enemy)

    total_score = my_score - enemy_score * 0.1
    return total_score


# 每个方向上的分值计算
def cal_score(m, n, x_decrict, y_derice, enemy_list, my_list, score_all_arr):
    add_score = 0  # 加分项
    max_score_shape = (0, None)
    for item in score_all_arr:
        for pt in item[1]:
            if m == pt[0] and n == pt[1] and x_decrict == item[2][0] and y_derice == item[2][1]:
                return 0
    for offset in range(-5, 1):
        # offset = -2
        pos = []
        for i in range(0, 6):
            if (m + (i + offset) * x_decrict, n + (i + offset) * y_derice) in enemy_list:
                pos.append(2)
            elif (m + (i + offset) * x_decrict, n + (i + offset) * y_derice) in my_list:
                pos.append(1)
            else:
                pos.append(0)
        tmp_shap5 = (pos[0], pos[1], pos[2], pos[3], pos[4])
        tmp_shap6 = (pos[0], pos[1], pos[2], pos[3], pos[4], pos[5])
        for (score, shape) in shape_score:
            if tmp_shap5 == shape or tmp_shap6 == shape:
                if score > max_score_shape[0]:
                    max_score_shape = (score, ((m + (0 + offset) * x_decrict, n + (0 + offset) * y_derice),
                                               (m + (1 + offset) * x_decrict, n + (1 + offset) * y_derice),
                                               (m + (2 + offset) * x_decrict, n + (2 + offset) * y_derice),
                                               (m + (3 + offset) * x_decrict, n + (3 + offset) * y_derice),
                                               (m + (4 + offset) * x_decrict, n + (4 + offset) * y_derice)),
                                       (x_decrict, y_derice))
    if max_score_shape[1] is not None:
        for item in score_all_arr:
            for pt1 in item[1]:
                for pt2 in max_score_shape[1]:
                    if pt1 == pt2 and max_score_shape[0] > 10 and item[0] > 10:
                        add_score += item[0] + max_score_shape[0]
        score_all_arr.append(max_score_shape)
    return add_score + max_score_shape[0]


def is_win(list):
    for m in range(COLUMN):
        for n in range(ROW):
            if n < ROW - 4 and (m, n) in list and (m, n + 1) in list and (m, n + 2) in list and (
                    m, n + 3) in list and (m, n + 4) in list:
                return True
            elif m < ROW - 4 and (m, n) in list and (m + 1, n) in list and (m + 2, n) in list and (
                    m + 3, n) in list and (m + 4, n) in list:
                return True
            elif m < ROW - 4 and n < ROW - 4 and (m, n) in list and (m + 1, n + 1) in list and (
                    m + 2, n + 2) in list and (m + 3, n + 3) in list and (m + 4, n + 4) in list:
                return True
            elif m < ROW - 4 and n > 3 and (m, n) in list and (m + 1, n - 1) in list and (
                    m + 2, n - 2) in list and (m + 3, n - 3) in list and (m + 4, n - 4) in list:
                return True
    return False


def main(is_prune):
    mode = 0
    for i in range(COLUMN):
        for j in range(ROW):
            list_all.append((i, j))
    g = 0
    change = 0
    while True:
        # black
        if change % 2 == mode:
            if change == 0:
                pos = ((ROW + 1) / 2, (COLUMN + 1) / 2)
            else:
                pos = game_tree(is_prune)
            list1.append(pos)
            list3.append(pos)
            # AI胜利
            if is_win(list1):
                print("black胜利---博弈树")
                break
            change = change + 1

        # red
        else:
            while True:
                x = random.randint(0, ROW - 1)
                y = random.randint(0, COLUMN - 1)
                if not (x, y) in list3:
                    break
            list2.append((x, y))
            list3.append((x, y))
            # 胜利
            if is_win(list2):
                print("red胜利---随机")
                break
            change = change + 1


if __name__ == '__main__':
    t1 = time()
    COLUMN = 5
    ROW = 5
    list1 = []  # game tree
    list2 = []  # random
    list3 = []  # game tree + random
    list_all = []  # all
    next_point = [0, 0]  # 下一步最应该下的位置
    DEPTH = 3
    main(is_prune=True)
    x1 = []
    y1 = []
    x2 = []
    y2 = []
    for p in list1:
        x1.append(p[0])
        y1.append(p[1])
    for p in list2:
        x2.append(p[0])
        y2.append(p[1])
    print('花费%f秒' % (time() - t1))
    plt.plot([0, 0, 4, 4, 0], [0, 4, 4, 0, 0], '-k')
    plt.plot(x1, y1, '.k', markersize=20, label='Game tree')
    plt.plot(x2, y2, '.r', markersize=20, label='random')
    plt.legend(loc="upper right")
    plt.grid(True)
    plt.axis('equal')
    plt.show()
