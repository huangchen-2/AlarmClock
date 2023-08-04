#include "CppObject.h"
#include <QDateTime>
#include <QDebug>
#include <QDate>
CppObject::CppObject(QObject *parent)
    : QObject(parent)
{
    speak = new Speak();
    connect(this,&CppObject::ShouldSpeak,speak,&Speak::SpeakText);
    timer = new QTimer();
    connect(timer,&QTimer::timeout,[this]
    {
         QDateTime time = QDateTime::currentDateTime(); // 获取当前时间
         year = time.date().year()==alarm_time.toStringList().at(0).toInt();
         month = time.date().month()==alarm_time.toStringList().at(1).toInt();
         day = time.date().day()==alarm_time.toStringList().at(2).toInt();
         minute = time.time().minute()==alarm_time.toStringList().at(3).toInt();
         hour = time.time().hour()==alarm_time.toStringList().at(4).toInt();
           qDebug()<<"---------------"<<year<<month<<day<<hour<<minute;
           qDebug()<< time.time().hour()<<time.time().minute();
         checktime(year,month,day,hour,minute);

    });
    connect(this,&CppObject::SendText,speak,&Speak::GetText);
}



void CppObject::cppSlotA(QVariant date)
{
    qDebug()<<"收到日期"<<date.toStringList();
   alarm_time = date;
   timer->start(2000);
}

void CppObject::checktime(bool year, bool month, bool day, bool hour, bool minute)
{
    if(year&&month&day&&hour&&minute)
    {
        qDebug()<<"true";
        emit ShouldSpeak();
        emit ShouldShow();
        timer->stop();
    }
    else {

    }
}

void CppObject::getText(QString alarm_text)
{
    qDebug()<<alarm_text;
}

