TEMPLATE = app

QT += quick texttospeech widgets

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    CppObject.cpp \
    Speak.cpp

RESOURCES += qml.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/demos/alarms
INSTALLS += target

HEADERS += \
    CppObject.h \
    Speak.h

