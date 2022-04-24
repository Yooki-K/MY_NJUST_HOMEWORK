#include "widget.h"
#include "ui_widget.h"
#include <QDir>
Widget::Widget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Widget)
{
    ui->setupUi(this);

    ui->spinBox_3->hide();
    ui->label_7->hide();
    ui->label_8->hide();
    ui->pre_point->hide();
    ui->pushButton_3->hide();
    setWindowTitle("数字图像处理工具");
}
Widget::~Widget()
{
    if(p!=nullptr){
        delete p;
    }
    delete ui;
}
//打开文件
void Widget::on_btn1_clicked()
{
    QString fileName = QFileDialog::getOpenFileName(
        this,
        tr("open a file."),
        "D:\\ChromeCoreDownloads",
        tr("images(*.png *jpeg *bmp *jpg);;All files(*.*)"));
    if (fileName.isEmpty()) {
        QMessageBox::warning(this, "Warning!", "文件不存在或无法打开 to open the image!");
    }
    else {
        ui->filename->setText(fileName);
        ui->filename->setToolTip(fileName);
        this->srcPath = fileName;
        QPixmap pixmap1(this->srcPath);
        pixmap1.scaled(ui->image1->size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
        ui->image1->setScaledContents(true);
        ui->label_6->setText("原图");
        ui->image1->setPixmap(pixmap1);
    }
}
void Widget::mouseReleaseEvent(QMouseEvent *event){
    if(this->model!=7){
        return;
    }
    QPoint cursor = event->pos();
    QPoint img = ui->image1->pos();
    QSize size = ui->image1->size();
    int x = cursor.x()-img.x();
    int y = cursor.y()-img.y();
    qDebug()<<x<<" "<<y<<"\n";
    if(x>=0 && x<size.width() && y>=0 && y<size.height()){
        this->px = x;
        this->py = y;
        ui->pre_point->setText(QString::number(x)+" "+QString::number(y));
    }
}
//运行
void Widget::on_pushButton_clicked()
{
    p = new QProcess(this);
    QStringList argument;
    switch (this->model) {
    case 1:
        argument<<path+"Project1.exe "<<this->srcPath<<QString::number(this->model)<<QString::number(this->filltype)<<QString::number(this->ma);
        break;
    case 2:
        argument<<path+"Project1.exe "<<this->srcPath<<QString::number(this->model)<<QString::number(this->filltype);
        break;
    case 7:
        argument<<path+"Project1.exe "<<this->srcPath<<QString::number(this->model)<<QString::number(this->py)<<QString::number(this->px)<<QString::number(this->d);
        break;
    default:
        argument<<path+"Project1.exe "<<this->srcPath<<QString::number(this->model);
        break;
    }
    p->start(argument.join(' '));
    qDebug()<<argument.join(' ');
    p->waitForStarted(); //等待程序启动
    p->waitForFinished();
    QString temp=QString::fromLocal8Bit(p->readAllStandardOutput()); //程序输出信息
    qDebug()<<temp;
    QStringList l = temp.split("::");
    if(l.size()>1){
        QPixmap pixmap1;
        if(!pixmap1.load(l[1])){
            QMessageBox::warning(this, "Warning!", "文件不存在或无法打开!!!");
            return;
        }
        pixmap1.scaled(ui->image1->size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
        ui->image1->setScaledContents(true);
        ui->image1->setPixmap(pixmap1);
    }
    QPixmap pixmap2;
    if(!pixmap2.load(l[0])){
        QMessageBox::warning(this, "Warning!", "文件不存在或无法打开!!!");
        return;
    }
    this->disPath=l[0];
    pixmap2.scaled(ui->image2->size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
    ui->image2->setScaledContents(true);
    ui->image2->setPixmap(pixmap2);
    ui->label_5->setText("目标");
}



void Widget::on_comboBox_currentIndexChanged(int index)
{
    this->model=index+1;
    if(this->model==1 || this->model==2){
        ui->comboBox_2->show();
        ui->label_3->show();
    }else{
        ui->comboBox_2->hide();
        ui->label_3->hide();
    }
    if(this->model==1){
        ui->spinBox_2->show();
        ui->label_4->show();
    }else{
        ui->spinBox_2->hide();
        ui->label_4->hide();
    }
    if(this->model==7){
        ui->spinBox_3->show();
        ui->label_7->show();
        ui->label_8->show();
        ui->pre_point->show();
        ui->pushButton_3->show();
        ui->image1->setStyleSheet("border:1px solid black;");
    }else{
        ui->spinBox_3->hide();
        ui->label_7->hide();
        ui->label_8->hide();
        ui->pre_point->hide();
        ui->pushButton_3->hide();
        ui->image1->setStyleSheet("border:0 solid black;");
    }
}

void Widget::on_spinBox_2_valueChanged(int arg1)
{
    this->ma=arg1;
}

void Widget::on_comboBox_2_currentIndexChanged(int index)
{
    this->filltype=index;
}
//清空
void Widget::on_pushButton_2_clicked()
{
    ui->filename->setText("");
    this->srcPath = "";
    ui->image1->clear();
    ui->image2->clear();
    ui->label_6->setText("");
    ui->label_5->setText("");
    ui->pre_point->setText("");
    resize(QSize(550,330));
}

void Widget::on_spinBox_3_valueChanged(int arg1)
{
    this->d = arg1;
}

void Widget::on_pushButton_3_clicked()
{
    this->srcPath = this->disPath;
    ui->filename->setText(this->srcPath);
    ui->image2->clear();
    QPixmap pixmap1;
    if(!pixmap1.load(this->srcPath)){
        QMessageBox::warning(this, "Warning!", "文件不存在或无法打开!!!");
        return;
    }
    pixmap1.scaled(ui->image1->size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
    ui->image1->setScaledContents(true);
    ui->image1->setPixmap(pixmap1);
}
