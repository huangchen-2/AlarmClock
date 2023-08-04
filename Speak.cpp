#include "Speak.h"
#include <QDebug>
Speak::Speak()
{
    Say= new QTextToSpeech(this);
    Say->setLocale(QLocale::Chinese);//设置语言环境
    Say->setRate(0.4);//设置语速-1.0到1.0
    Say->setPitch(1.0);//设置音高-1.0到1.0
    Say->setVolume(1.0);//设置音量0.0-1.0
    timer = new QTimer();
    connect(timer,&QTimer::timeout,[this]
    {
        if(now_speak=="")
        {
            Say->say("时间到了");
        }
        else
        {
            Say->say("时间到了，您该"+now_speak+"了");
        }

        speak_count++;
        qDebug()<<"调用";
        if(speak_count>=5)
        {
            timer->stop();
        }
    });
}

void Speak::SpeakText(int index)
{
    if(Say->state()==QTextToSpeech::Ready)
    {
        if(!(alarm_text.size()<=index))
        {
            now_speak = alarm_text.find(index).value();
        }

        timer->start(3000);
    }
}

void Speak::GetText(int index,QString str)
{
    if(alarm_text.contains(index))
    {
        alarm_text.find(index).value()=str;
    }
    else
    {
        alarm_text.insert(index,str);
    }
}
