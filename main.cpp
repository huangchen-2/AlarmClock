#include <QGuiApplication> //管理gui程序的控制流和主设置
#include <QQmlApplicationEngine> //从单个qml文件中加载应用程序
#include "CppObject.h"
int main(int argc, char* argv[]){

    //在支持的平台上启用qt中的高DPI扩展
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //构造一个qt核心应用程序
    QGuiApplication app(argc,argv);
    QQmlApplicationEngine engine;
    //加载qml文件

    qmlRegisterType<CppObject>("MyCppObject",1,0,"CppObject");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if(engine.rootObjects().isEmpty()) //qml项目为空时
        return -1;

    return app.exec();

}
