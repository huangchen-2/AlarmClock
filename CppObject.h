#ifndef CPPOBJECT_H
#define CPPOBJECT_H

#include <QObject>
#include <QVariant>
#include "Speak.h"
#include <QTimer>
#include<QList>
#include <QDateTime>
#include <QDebug>
#include <QDate>
//派生自QObject
//使用qmlRegisterType注册到QML中
class CppObject : public QObject
{
    Q_OBJECT


public:
    explicit CppObject(QObject *parent = nullptr);


signals:
    //信号可以在QML中访问
    void cppSignalA();//一个无参信号
    void ShouldShow();
    void ShouldSpeak(int index);
    void SendText(int index,QString str);
public slots:
    //public槽函数可以在QML中访问
    void cppSlotA(QVariant date);//一个无参槽函数
    void checktime(int index);
    void getText(int index, QString alarm_text);
    void getState(int index,bool state);
    void deleteState(int index);
public:
    Speak *speak;
    QTimer *timer;
    bool year,month,day, hour, minute =false;
    QVariant alarm_time ;
    QList<QDateTime> alarm_date;
    QMap<int,bool > which_date;
    QDateTime time ;
};

#endif // CPPOBJECT_H
