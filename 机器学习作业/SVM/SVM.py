from libsvm.svm import *
from libsvm.svmutil import *

if __name__ == '__main__':
    # 加载数据
    y, x = svm_read_problem('')
    # 训练全部数据
    # -t type 0 为线性 -b是否概率估计
    r1 = svm_train(y, x, '-t 0 -b 1')
    # p_labs是存储预测标签的列表。
    # p_acc存储了预测的精确度，均值和回归的平方相关系数。
    # p_vals在指定参数'-b 1'时将返回判定系数(判定的可靠程度)
    label, acc, val = svm_predict(y, x, r1)
    # 评估结果
    ACC, MES, SCC = evaluations(y, label)
    # 交叉验证
    r2 = svm_train(y, x, '-t 0 -b 1 -v 5')
    print(r2)
    pass
