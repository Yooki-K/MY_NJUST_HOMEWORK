import math
import random
import matplotlib.pyplot as plt


class AStar:
    # 初始化
    def __init__(self, ox, oy, edge, radius):
        self.min_x = None
        self.min_y = None
        self.max_x = None
        self.max_y = None
        self.x_width = None
        self.y_width = None
        self.obstacle_map = None

        self.edge = edge  # 网格边长
        self.radius = radius
        self.calc_obstacle_map(ox, oy)  # 绘制
        self.motion = self.get_motion_model()  # 无人车运动方向

    class Node:
        def __init__(self, x, y, cost, parent_index):
            self.x = x
            self.y = y
            self.cost = cost
            self.parent_index = parent_index

        def __str__(self):
            return str(self.x) + ',' + str(self.y) + ',' + str(self.cost) + ',' + str(self.parent_index)

    # 寻找最优路径，返回最短路径
    def planning(self, sx, sy, gx, gy):
        start_node = self.Node(self.calc_xy_index(sx, self.min_x),
                               self.calc_xy_index(sy, self.min_y), 0.0, -1)
        goal_node = self.Node(self.calc_xy_index(gx, self.min_x),
                              self.calc_xy_index(gy, self.min_y), 0.0, -1)
        # 保存进入集合节点和待计算节点
        open_set, closed_set = dict(), dict()
        open_set[self.calc_index(start_node)] = start_node
        while True:
            # f(n)= g(n) + h(n)
            c_id = min(open_set, key=lambda o: open_set[o].cost + self.calc_heuristic(goal_node, open_set[o]))
            current = open_set[c_id]
            # plt.plot(self.calc_position(current.x),
            #          self.calc_position(current.y), 'xc')
            # plt.pause(0.0001)
            if current.x == goal_node.x and current.y == goal_node.y:
                goal_node.cost = current.cost
                goal_node.parent_index = current.parent_index
                break
            del open_set[c_id]
            closed_set[c_id] = current

            # 遍历邻接节点
            for move_x, move_y, move_cost in self.motion:
                node = self.Node(current.x + move_x,
                                 current.y + move_y,
                                 current.cost + move_cost, c_id)
                n_id = self.calc_index(node)
                if n_id in closed_set:
                    continue
                # 判断邻接节点
                if not self.verify_node(node):
                    continue
                if n_id not in open_set:
                    open_set[n_id] = node
                else:
                    # 更新
                    if node.cost <= open_set[n_id].cost:
                        open_set[n_id] = node
        rx, ry = self.calc_final_path(goal_node, closed_set)
        return rx, ry

    @staticmethod
    def calc_heuristic(n1, n2):  # n1终点，n2当前网格
        return math.hypot(n1.x - n2.x, n1.y - n2.y)  # 当前网格和终点距离

    # 无人车每次能向周围移动8个网格移动
    @staticmethod
    def get_motion_model():
        # [dx, dy, cost]
        motion = [[1, 0, 1],  # 右
                  [0, 1, 1],  # 上
                  [-1, 0, 1],  # 左
                  [0, -1, 1],  # 下
                  [-1, -1, math.sqrt(2)],  # 左下
                  [-1, 1, math.sqrt(2)],  # 左上
                  [1, -1, math.sqrt(2)],  # 右下
                  [1, 1, math.sqrt(2)]]  # 右上
        return motion

    # 绘制栅格地图
    def calc_obstacle_map(self, ox, oy):
        self.min_x = 0
        self.min_y = 0
        self.max_x = N
        self.max_y = N
        self.x_width = round((self.max_x - self.min_x) / self.edge)  # x方向网格个数
        self.y_width = round((self.max_y - self.min_y) / self.edge)  # y方向网格个数
        # 初始化地图
        self.obstacle_map = [[False for _ in range(self.y_width)]
                             for _ in range(self.x_width)]

        # 设置障碍物
        for ix in range(self.x_width):
            x = self.calc_position(ix)
            for iy in range(self.y_width):
                y = self.calc_position(iy)
                for iox, ioy in zip(ox, oy):
                    d = math.hypot(iox - x, ioy - y)
                    if d <= self.radius:
                        self.obstacle_map[ix][iy] = True
                        break

    # 根据网格编号计算实际坐标
    def calc_position(self, index):
        pos = index * self.edge
        return pos

    # 位置坐标转为网格坐标
    def calc_xy_index(self, position, minp):
        return round((position - minp) / self.edge)

    # 给每个网格编号，得到每个网格的key
    def calc_index(self, node):
        return node.y * self.x_width + node.x

    # 邻居节点是否超出范围
    def verify_node(self, node):
        px = self.calc_position(node.x)
        py = self.calc_position(node.y)
        if px < self.min_x:
            return False
        if py < self.min_y:
            return False
        if px >= self.max_x:
            return False
        if py >= self.max_y:
            return False
        if self.obstacle_map[node.x][node.y]:
            return False
        return True

    # 计算路径
    def calc_final_path(self, goal_node, closed_set):
        rx = [self.calc_position(goal_node.x)]
        ry = [self.calc_position(goal_node.y)]
        parent_index = goal_node.parent_index
        while parent_index != -1:
            n = closed_set[parent_index]
            rx.append(self.calc_position(n.x))
            ry.append(self.calc_position(n.y))
            parent_index = n.parent_index
        return rx, ry


if __name__ == '__main__':
    # 设置障碍物数量
    m = 400
    # 设置网格大小
    N = 60
    # ------------------
    # 起点和终点
    sx = 5.0
    sy = N - 5.0
    gx = N - 5.0
    gy = 5.0
    # 网格边长
    grid_size = 1.0
    # 无人车半径
    radius = 1.0
    # 生成障碍物位置
    ox, oy = [], []
    for i in range(0, N + 1):    ox.append(i); oy.append(0)  # 下边界
    for i in range(0, N + 1):    ox.append(N); oy.append(i)  # 右边界
    for i in range(0, N + 1):    ox.append(i); oy.append(N)  # 上边界
    for i in range(0, N + 1):    ox.append(0); oy.append(i)  # 左边界
    while m > 0:
        x = random.randint(1, N)
        y = random.randint(1, N)
        if x == sx and y == sy: continue
        if x == gx and y == gy: continue
        ox.append(x)
        oy.append(y)
        m = m - 1

    plt.plot(ox, oy, label="obstacle", color='k', linestyle='None', marker='.')  # 障碍物黑色
    plt.plot(sx, sy, label="starting point", color='g', linestyle='None', marker='x')  # 起点绿色
    plt.plot(gx, gy, label="goal point", color='b', linestyle='None', marker='x')  # 终点蓝色
    plt.grid(True)
    plt.axis('equal')
    plt.legend(loc="upper right")
    dijkstra = AStar(ox, oy, grid_size, radius)
    # 求解路径
    rx, ry = dijkstra.planning(sx, sy, gx, gy)
    # 绘制路径
    plt.plot(rx, ry, label="shortest path", color='r', linestyle='-')
    plt.legend(loc="upper right")
    plt.pause(0.1)
    plt.show()
