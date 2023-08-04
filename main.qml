import QtQuick 2.12 //
import QtQuick.Controls 2.12 //提供一组控件，可自定义样式
import QtQuick.Window 2.12
import Qt.labs.calendar 1.0
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import MyCppObject 1.0
//样式顶层窗口
ApplicationWindow{
    id: window
    width: 400
    height: 500
    x:0
    y:0
    //窗口是否可见
    title:"闹钟"
    visible: true

    signal onQmlSignalA(variant date)
    signal onSendText(string str)

    CppObject{
        id:cpp_obj
        //也可以像原生QML对象一样操作，增加属性之类的
        property int counts: 0

    }

    Component.onCompleted: {
        //关联信号与信号处理函数的方式同QML中的类型
        //Cpp对象的信号关联到Qml

        //cpp_obj.onCppSignalA.connect(function(){console.log('qml signalA process')})
        //           cpp_obj.ShouldShow.connect(
        //           console.log("....")
        //                                      ) //js的lambda
        //           //Qml对象的信号关联到Cpp
        window.onSendText.connect(cpp_obj.getText);
        window.onQmlSignalA.connect(cpp_obj.cppSlotA)
    }





    //列表视图
    ListView{
        id:alarmListView
        //锚填充，parent保存可视化父窗口
        anchors.fill: parent
        //模型。提供数据
        model: AlarmModel {}
        //委托。以何种方式显示数据
        delegate: AlarmDelegate {}

    }

    //可单击带圆角的按钮
    RoundButton {
        id: addAlarmButton
        text: "+"
        //锚底部，锚到列表视图类的底部
        anchors.bottom: alarmListView.bottom
        //页下空白距离
        anchors.bottomMargin: 8
        //锚水平居中
        anchors.horizontalCenter: parent.horizontalCenter
        //单击进入添加界面
        onClicked: alarmDialog.open()
    }

    //自定义添加警报类
    AlarmDialog{
        id: alarmDialog
        //js中的Math.round函数为四舍五入
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        //alarmModel自定义属性引用列表视图中的数据模型
        alarmModel: alarmListView.model
    }

    SmoothedAnimation on y { to: 500 ;duration: 5000}

}



