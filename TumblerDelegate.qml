import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4

//作为滚轮部件中的字体，设置样式
Text {
    text: modelData
    //设置颜色
    color: Tumbler.tumbler.Material.foreground
    //字体
    font: Tumbler.tumbler.font
    //设置透明。Math.abs返回一个绝对值。displacement是当前项时为1.
    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

    //水平对齐为居中
    horizontalAlignment: Text.AlignHCenter
    //垂直对齐为居中
    verticalAlignment: Text.AlignVCenter



    //调试用的
//        Button{
//            id: d
//            text: "测试按钮"
//            onClicked:console.log("dis=",Tumbler.displacement,"vis=",Tumbler.tumbler.visibleItemCount);

//        }

}
