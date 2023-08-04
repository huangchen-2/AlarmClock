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
public slots:
    void SpeakText();
};

#endif // SPEAK_H
