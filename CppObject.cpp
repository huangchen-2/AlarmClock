#include "CppObject.h"

CppObject::CppObject(QObject *parent)
    : QObject(parent)
{
    speak = new Speak();
    connect(this,&CppObject::ShouldSpeak,speak,&Speak::SpeakText);
    timer = new QTimer();
    connect(timer,&QTimer::timeout,[this]
    {
        QDateTime time1 = QDateTime::currentDateTime(); // 获取当前时间
        for(int i=0;i<alarm_date.size();++i)
        {
            qDebug()<<alarm_date.at(i).toTime_t()<<time1.toTime_t();
            if(alarm_date.at(i).toTime_t()-time1.toTime_t()<=2)
            {
                qDebug()<<i;
                checktime(i);
            }
        }

    });
    connect(this,&CppObject::SendText,speak,&Speak::GetText);
}

void CppObject::Send(bool state)
{
    qDebug()<<"进入";
    emit ShouldShow();
}



void CppObject::cppSlotA(QVariant date)
{
    alarm_time = date;
    QString datetime = QString("%1-%2-%3 %4:%5").arg(alarm_time.toStringList().at(0)).arg(alarm_time.toStringList().at(1))
            .arg(alarm_time.toStringList().at(2)).arg(alarm_time.toStringList().at(4))
            .arg(alarm_time.toStringList().at(3));
    time = QDateTime::fromString(datetime, "yyyy-MM-dd hh:mm");
    alarm_date.append(time);
    qDebug()<<"收到";
    timer->start(2000);
}

void CppObject::checktime(int index)
{
    qDebug()<<"传来的index"<<index;
    if(which_date.find(index).value())
    {
        qDebug()<<"正确";
        emit ShouldSpeak(index);
        emit ShouldShow();
        timer->stop();
    }
}

void CppObject::getText(int index,QString alarm_text)//闹钟提示内容
{
    emit SendText(index,alarm_text);
}

void CppObject::getState(int index, bool state)//修改或添加
{
    if(which_date.contains(index))
    {
        which_date.find(index).value()=state;
    }
    else
    {
        which_date.insert(index,state);
    }

}
//删除闹钟,后续实现
void CppObject::deleteState(int index)
{

}

