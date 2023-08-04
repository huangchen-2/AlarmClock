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
        Say->say("时间到了，您该工作了");
        speak_count++;
        qDebug()<<"调用";
        if(speak_count>=5)
        {
            timer->stop();
        }
    });
}

void Speak::SpeakText()
{
    if(Say->state()==QTextToSpeech::Ready)
    {
        timer->start(3000);
    }
}

void Speak::GetText()
{

}
