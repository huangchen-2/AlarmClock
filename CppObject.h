#ifndef CPPOBJECT_H
#define CPPOBJECT_H

#include <QObject>
#include <QVariant>
#include "Speak.h"
#include <QTimer>
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
    void ShouldSpeak();
public slots:
    //public槽函数可以在QML中访问
    void cppSlotA(QVariant date);//一个无参槽函数
    void checktime(bool year,bool month,bool day,bool hour,bool minute);
    void getText(QString alarm_text);
public:
    Speak *speak;
    QTimer *timer;
    bool year,month,day, hour, minute =false;
    QVariant alarm_time ;
};

#endif // CPPOBJECT_H
