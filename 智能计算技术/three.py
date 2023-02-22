import random
import numpy as np


def get_matrix(num):
    dist_matrix = np.zeros((num, num))
    for i in range(num - 1):
        for j in range(i + 1, num):
            dist = random.randint(100, 500)
            dist_matrix[i, j] = dist
            dist_matrix[j, i] = dist
    return dist_matrix


# 计算某一路线的适应度
def get_route_fitness_value(route, dist_matrix):
    dist_sum = 0
    for i in range(len(route) - 1):
        dist_sum += dist_matrix[route[i], route[i + 1]]
    dist_sum += dist_matrix[route[len(route) - 1], route[0]]
    return 1 / dist_sum


# 计算所有路线的适应度
def get_all_routes_fitness_value(routes, dist_matrix):
    fitness_values = np.zeros(len(routes))
    for i in range(len(routes)):
        f_value = get_route_fitness_value(routes[i], dist_matrix)
        fitness_values[i] = f_value
    return fitness_values


# 随机初始化路线
def init_route(n_route, num):
    routes = np.zeros((n_route, num)).astype(int)
    for i in range(n_route):
        routes[i] = np.random.choice(range(num), size=num, replace=False)
    return routes


# 选择
def selection(routes, fitness_values):
    selected_routes = np.zeros(routes.shape).astype(int)
    probability = fitness_values / np.sum(fitness_values)
    n_routes = routes.shape[0]
    for i in range(n_routes):
        choice = np.random.choice(range(n_routes), p=probability)
        selected_routes[i] = routes[choice]
    return selected_routes


# 交叉
def crossover(routes, num):
    for i in range(0, len(routes), 2):
        r1_new, r2_new = np.zeros(num), np.zeros(num)
        seg_point = np.random.randint(0, num)
        cross_len = num - seg_point
        r1, r2 = routes[i], routes[i + 1]
        r1_cross, r2_cross = r2[seg_point:], r1[seg_point:]
        r1_non_cross = r1[np.in1d(r1, r1_cross, invert=True)]
        r2_non_cross = r2[np.in1d(r2, r2_cross, invert=True)]
        r1_new[:cross_len], r2_new[:cross_len] = r1_cross, r2_cross
        r1_new[cross_len:], r2_new[cross_len:] = r1_non_cross, r2_non_cross
        routes[i], routes[i + 1] = r1_new, r2_new
    return routes


# 变异
def mutation(routes, num):
    prob = 0.01  # 变异概率为 0.01
    p_rand = np.random.rand(len(routes))
    for i in range(len(routes)):
        if p_rand[i] < prob:
            mut_position = np.random.choice(range(num), size=2, replace=False)
            l, r = mut_position[0], mut_position[1]
            routes[i, l], routes[i, r] = routes[i, r], routes[i, l]
    return routes


if __name__ == '__main__':
    num = 100  # 节点个数
    n = 106  # 种群大小
    epoch = 5000  # 迭代次数
    dist_matrix_ = get_matrix(num)  # 随机生成节点距离矩阵
    routes_ = init_route(n, dist_matrix_.shape[0])  # 初始化所有路线
    fitness_values_ = get_all_routes_fitness_value(routes_, dist_matrix_)  # 计算所有初始路线的适应度
    best_index = fitness_values_.argmax()
    best_route, best_fitness = routes_[best_index], fitness_values_[best_index]  # 保存最短路线及其适应度

    # 开始迭代
    not_improve_time = 0
    for i_ in range(epoch):
        routes_ = selection(routes_, fitness_values_)  # 选择
        routes_ = crossover(routes_, num)  # 交叉
        routes_ = mutation(routes_, num)  # 变异
        fitness_values_ = get_all_routes_fitness_value(routes_, dist_matrix_)
        best_route_index = fitness_values_.argmax()
        best_route, best_fitness = routes_[best_route_index], fitness_values_[best_route_index]  # 保存最短路线及其适应度
        if (i_ + 1) % 500 == 0:
            print('迭代次数: {}, 当前最短路线距离： {}'.format(i_ + 1, 1 / get_route_fitness_value(best_route, dist_matrix_)))

    print('最短路线为：')
    print(best_route)
    print('总距离为： {}'.format(1 / get_route_fitness_value(best_route, dist_matrix_)))

