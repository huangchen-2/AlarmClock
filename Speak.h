#ifndef SPEAK_H
#define SPEAK_H

#include <QObject>
#include <QTextToSpeech>
#include <QTimer>

class Speak: public QObject
{
    Q_OBJECT
public:
    Speak();
public:
    QTextToSpeech *Say;
    QTimer *timer;
    int speak_count = 0;
    QMap<int,QString> alarm_text;
    QString now_speak = "";
public slots:
    void SpeakText(int index);
    void GetText(int index, QString str);
};

#endif // SPEAK_H
