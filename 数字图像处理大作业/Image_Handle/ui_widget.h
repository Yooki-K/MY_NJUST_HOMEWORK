/********************************************************************************
** Form generated from reading UI file 'widget.ui'
**
** Created by: Qt User Interface Compiler version 5.9.2
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WIDGET_H
#define UI_WIDGET_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpinBox>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Widget
{
public:
    QHBoxLayout *horizontalLayout;
    QVBoxLayout *verticalLayout_2;
    QHBoxLayout *H1;
    QLabel *label;
    QLineEdit *filename;
    QPushButton *btn1;
    QHBoxLayout *H2;
    QLabel *label_2;
    QComboBox *comboBox;
    QHBoxLayout *H3;
    QLabel *label_3;
    QComboBox *comboBox_2;
    QHBoxLayout *H4;
    QLabel *label_4;
    QSpinBox *spinBox_2;
    QHBoxLayout *H6;
    QLabel *label_7;
    QLineEdit *pre_point;
    QLabel *label_8;
    QSpinBox *spinBox_3;
    QPushButton *pushButton_3;
    QHBoxLayout *H5;
    QPushButton *pushButton_2;
    QPushButton *pushButton;
    QGridLayout *gridLayout;
    QLabel *label_5;
    QLabel *label_6;
    QLabel *image2;
    QLabel *image1;

    void setupUi(QWidget *Widget)
    {
        if (Widget->objectName().isEmpty())
            Widget->setObjectName(QStringLiteral("Widget"));
        Widget->resize(549, 331);
        Widget->setStyleSheet(QStringLiteral(""));
        horizontalLayout = new QHBoxLayout(Widget);
        horizontalLayout->setSpacing(6);
        horizontalLayout->setContentsMargins(11, 11, 11, 11);
        horizontalLayout->setObjectName(QStringLiteral("horizontalLayout"));
        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setSpacing(6);
        verticalLayout_2->setObjectName(QStringLiteral("verticalLayout_2"));
        H1 = new QHBoxLayout();
        H1->setSpacing(6);
        H1->setObjectName(QStringLiteral("H1"));
        label = new QLabel(Widget);
        label->setObjectName(QStringLiteral("label"));
        label->setMinimumSize(QSize(200, 50));
        label->setMaximumSize(QSize(200, 50));
        label->setStyleSheet(QStringLiteral("color:red"));

        H1->addWidget(label);

        filename = new QLineEdit(Widget);
        filename->setObjectName(QStringLiteral("filename"));
        filename->setMinimumSize(QSize(200, 0));
        filename->setMaximumSize(QSize(200, 16777215));
        filename->setReadOnly(true);
        filename->setClearButtonEnabled(false);

        H1->addWidget(filename);

        btn1 = new QPushButton(Widget);
        btn1->setObjectName(QStringLiteral("btn1"));
        btn1->setMaximumSize(QSize(30, 16777215));

        H1->addWidget(btn1);


        verticalLayout_2->addLayout(H1);

        H2 = new QHBoxLayout();
        H2->setSpacing(6);
        H2->setObjectName(QStringLiteral("H2"));
        label_2 = new QLabel(Widget);
        label_2->setObjectName(QStringLiteral("label_2"));
        label_2->setMaximumSize(QSize(200, 50));
        QFont font;
        font.setPointSize(14);
        font.setBold(true);
        font.setWeight(75);
        label_2->setFont(font);
        label_2->setTextFormat(Qt::AutoText);
        label_2->setAlignment(Qt::AlignCenter);
        label_2->setMargin(0);

        H2->addWidget(label_2);

        comboBox = new QComboBox(Widget);
        comboBox->setObjectName(QStringLiteral("comboBox"));

        H2->addWidget(comboBox);


        verticalLayout_2->addLayout(H2);

        H3 = new QHBoxLayout();
        H3->setSpacing(6);
        H3->setObjectName(QStringLiteral("H3"));
        label_3 = new QLabel(Widget);
        label_3->setObjectName(QStringLiteral("label_3"));
        label_3->setMaximumSize(QSize(200, 50));
        label_3->setFont(font);
        label_3->setTextFormat(Qt::AutoText);
        label_3->setAlignment(Qt::AlignCenter);
        label_3->setMargin(0);

        H3->addWidget(label_3);

        comboBox_2 = new QComboBox(Widget);
        comboBox_2->setObjectName(QStringLiteral("comboBox_2"));

        H3->addWidget(comboBox_2);


        verticalLayout_2->addLayout(H3);

        H4 = new QHBoxLayout();
        H4->setSpacing(6);
        H4->setObjectName(QStringLiteral("H4"));
        label_4 = new QLabel(Widget);
        label_4->setObjectName(QStringLiteral("label_4"));
        label_4->setMaximumSize(QSize(200, 50));
        label_4->setFont(font);
        label_4->setTextFormat(Qt::AutoText);
        label_4->setAlignment(Qt::AlignCenter);
        label_4->setMargin(0);

        H4->addWidget(label_4);

        spinBox_2 = new QSpinBox(Widget);
        spinBox_2->setObjectName(QStringLiteral("spinBox_2"));
        spinBox_2->setMinimum(3);
        spinBox_2->setSingleStep(2);
        spinBox_2->setValue(5);

        H4->addWidget(spinBox_2);


        verticalLayout_2->addLayout(H4);

        H6 = new QHBoxLayout();
        H6->setSpacing(6);
        H6->setObjectName(QStringLiteral("H6"));
        label_7 = new QLabel(Widget);
        label_7->setObjectName(QStringLiteral("label_7"));
        label_7->setMaximumSize(QSize(200, 50));
        label_7->setFont(font);
        label_7->setTextFormat(Qt::AutoText);
        label_7->setAlignment(Qt::AlignCenter);
        label_7->setMargin(0);

        H6->addWidget(label_7);

        pre_point = new QLineEdit(Widget);
        pre_point->setObjectName(QStringLiteral("pre_point"));
        pre_point->setMinimumSize(QSize(100, 0));
        pre_point->setMaximumSize(QSize(100, 16777215));
        pre_point->setReadOnly(true);
        pre_point->setClearButtonEnabled(false);

        H6->addWidget(pre_point);

        label_8 = new QLabel(Widget);
        label_8->setObjectName(QStringLiteral("label_8"));
        label_8->setMaximumSize(QSize(200, 50));
        label_8->setFont(font);
        label_8->setTextFormat(Qt::AutoText);
        label_8->setAlignment(Qt::AlignCenter);
        label_8->setMargin(0);

        H6->addWidget(label_8);

        spinBox_3 = new QSpinBox(Widget);
        spinBox_3->setObjectName(QStringLiteral("spinBox_3"));
        spinBox_3->setMinimum(1);
        spinBox_3->setMaximum(255);
        spinBox_3->setSingleStep(1);
        spinBox_3->setValue(1);

        H6->addWidget(spinBox_3);

        pushButton_3 = new QPushButton(Widget);
        pushButton_3->setObjectName(QStringLiteral("pushButton_3"));
        pushButton_3->setMaximumSize(QSize(100, 16777215));

        H6->addWidget(pushButton_3);


        verticalLayout_2->addLayout(H6);

        H5 = new QHBoxLayout();
        H5->setSpacing(6);
        H5->setObjectName(QStringLiteral("H5"));
        pushButton_2 = new QPushButton(Widget);
        pushButton_2->setObjectName(QStringLiteral("pushButton_2"));
        pushButton_2->setMaximumSize(QSize(100, 16777215));

        H5->addWidget(pushButton_2);

        pushButton = new QPushButton(Widget);
        pushButton->setObjectName(QStringLiteral("pushButton"));
        pushButton->setMaximumSize(QSize(100, 16777215));

        H5->addWidget(pushButton);


        verticalLayout_2->addLayout(H5);


        horizontalLayout->addLayout(verticalLayout_2);

        gridLayout = new QGridLayout();
        gridLayout->setSpacing(6);
        gridLayout->setObjectName(QStringLiteral("gridLayout"));
        gridLayout->setSizeConstraint(QLayout::SetDefaultConstraint);
        gridLayout->setHorizontalSpacing(4);
        gridLayout->setVerticalSpacing(2);
        gridLayout->setContentsMargins(-1, -1, -1, 0);
        label_5 = new QLabel(Widget);
        label_5->setObjectName(QStringLiteral("label_5"));
        label_5->setMaximumSize(QSize(16777215, 20));
        label_5->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(label_5, 1, 4, 1, 1);

        label_6 = new QLabel(Widget);
        label_6->setObjectName(QStringLiteral("label_6"));
        label_6->setMaximumSize(QSize(16777215, 20));
        label_6->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(label_6, 1, 3, 1, 1);

        image2 = new QLabel(Widget);
        image2->setObjectName(QStringLiteral("image2"));

        gridLayout->addWidget(image2, 0, 4, 1, 1);

        image1 = new QLabel(Widget);
        image1->setObjectName(QStringLiteral("image1"));
        image1->setCursor(QCursor(Qt::CrossCursor));
        image1->setMouseTracking(true);

        gridLayout->addWidget(image1, 0, 3, 1, 1);


        horizontalLayout->addLayout(gridLayout);


        retranslateUi(Widget);

        QMetaObject::connectSlotsByName(Widget);
    } // setupUi

    void retranslateUi(QWidget *Widget)
    {
        Widget->setWindowTitle(QApplication::translate("Widget", "Widget", Q_NULLPTR));
        label->setText(QApplication::translate("Widget", "<html><head/><body><p align=\"center\"><span style=\" font-size:14pt; font-weight:600; color:#070707;\">\346\226\207\344\273\266\350\267\257\345\276\204\357\274\232</span></p></body></html>", Q_NULLPTR));
        btn1->setText(QApplication::translate("Widget", "...", Q_NULLPTR));
        label_2->setText(QApplication::translate("Widget", "\351\200\211\346\213\251\345\244\204\347\220\206\346\250\241\345\274\217\357\274\232", Q_NULLPTR));
        comboBox->clear();
        comboBox->insertItems(0, QStringList()
         << QApplication::translate("Widget", "\345\277\253\351\200\237\351\253\230\346\226\257\346\273\244\346\263\242", Q_NULLPTR)
         << QApplication::translate("Widget", "\346\213\211\346\231\256\346\213\211\346\226\257\351\224\220\345\214\226", Q_NULLPTR)
         << QApplication::translate("Widget", "\351\242\221\350\260\261", Q_NULLPTR)
         << QApplication::translate("Widget", "\347\233\270\344\275\215\350\260\261", Q_NULLPTR)
         << QApplication::translate("Widget", "\350\276\271\347\274\230\346\243\200\346\265\213", Q_NULLPTR)
         << QApplication::translate("Widget", "\347\233\264\346\226\271\345\233\276\345\235\207\350\241\241\345\214\226", Q_NULLPTR)
         << QApplication::translate("Widget", "\346\231\272\350\203\275\346\212\240\345\233\276", Q_NULLPTR)
        );
        label_3->setText(QApplication::translate("Widget", "\351\200\211\346\213\251\345\241\253\345\205\205\346\250\241\345\274\217\357\274\232", Q_NULLPTR));
        comboBox_2->clear();
        comboBox_2->insertItems(0, QStringList()
         << QApplication::translate("Widget", "\351\233\266\345\241\253\345\205\205", Q_NULLPTR)
         << QApplication::translate("Widget", "\345\244\215\345\210\266\345\241\253\345\205\205", Q_NULLPTR)
         << QApplication::translate("Widget", "\351\225\234\345\203\217\345\241\253\345\205\205", Q_NULLPTR)
        );
        comboBox_2->setCurrentText(QApplication::translate("Widget", "\351\233\266\345\241\253\345\205\205", Q_NULLPTR));
        label_4->setText(QApplication::translate("Widget", "\351\253\230\346\226\257\346\250\241\346\235\277\350\276\271\351\225\277\357\274\232", Q_NULLPTR));
        label_7->setText(QApplication::translate("Widget", "\345\210\235\345\247\213\347\202\271\357\274\232", Q_NULLPTR));
        label_8->setText(QApplication::translate("Widget", "\350\257\257\345\267\256\345\200\274\357\274\232", Q_NULLPTR));
        pushButton_3->setText(QApplication::translate("Widget", "\347\273\247\347\273\255", Q_NULLPTR));
        pushButton_2->setText(QApplication::translate("Widget", "\346\270\205\347\251\272", Q_NULLPTR));
        pushButton->setText(QApplication::translate("Widget", "\347\241\256\345\256\232", Q_NULLPTR));
        label_5->setText(QString());
        label_6->setText(QString());
        image2->setText(QString());
        image1->setText(QString());
    } // retranslateUi

};

namespace Ui {
    class Widget: public Ui_Widget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WIDGET_H
