#include <QApplication>
#include <QQmlApplicationEngine>
#include "CppObject.h"
#include <QSystemTrayIcon>
#include <QMenu>
#include <QMetaObject>

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    CppObject cpp;
    qmlRegisterType<CppObject>("MyCppObject", 1, 0, "CppObject");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    // 创建系统托盘图标对象
    QSystemTrayIcon trayIcon;

    // 创建菜单
    QIcon icon = QIcon(":/icon/icon/alarm.png");
    trayIcon.setIcon(icon);
    // 显示系统托盘图标
    trayIcon.show();
    QMenu *menu = new QMenu();
    QAction *show = new QAction("显示闹钟");
    QAction *info = new QAction("显示本机信息");
    QAction *exit = new QAction("退出");
    menu->addAction(show);
    menu->addAction(info);
    menu->addSeparator();
    menu->addAction(exit);
    // 设置菜单
    trayIcon.setContextMenu(menu);
    //发送界面显示
    qDebug()<<    QObject::connect(show, &QAction::triggered,[&app, &engine]
    {
        QMetaObject::invokeMethod(engine.rootObjects().at(0), "startAnimation", Qt::QueuedConnection);

    });

    //切换信息界面
    QObject::connect(info, &QAction::triggered, [&app] {

    });
    //退出程序
    QObject::connect(exit, &QAction::triggered, [&app] {
        app.exit(0);
    });

    return app.exec();
}
