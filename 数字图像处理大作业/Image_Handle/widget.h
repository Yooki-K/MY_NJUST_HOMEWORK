#ifndef WIDGET_H
#define WIDGET_H
#include "QFileDialog"
#include "QMessageBox"
#include<QProcess>
#include <QWidget>
#include<QDebug>
#include<QMouseEvent>
namespace Ui {
class Widget;
}

class Widget : public QWidget
{
    Q_OBJECT

public:
    QString srcPath;
    QString disPath;
    QString path="D:\\mixed_file\\daima\\C++\\repos\\Project1\\x64\\Debug\\";
    QProcess *p=nullptr;
    int model=1;
    int filltype=1;
    int ma=15;
    int px=0;
    int py=0;
    int d=1;
    explicit Widget(QWidget *parent = 0);
    ~Widget();

private slots:
    void on_btn1_clicked();

    void on_pushButton_clicked();

    void on_comboBox_currentIndexChanged(int index);

    void on_spinBox_2_valueChanged(int arg1);

    void on_comboBox_2_currentIndexChanged(int index);

    void on_pushButton_2_clicked();

    void mouseReleaseEvent(QMouseEvent *event);

    void on_spinBox_3_valueChanged(int arg1);

    void on_pushButton_3_clicked();

private:
    Ui::Widget *ui;
};

#endif // WIDGET_H
