import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12

//一个标准视图项
ItemDelegate{

    id: root
    //parent保存其可视父项
    width: 400 //不知道为什么使用parent会报width是空，后续再观察下
    //按钮是否可检查，检查按钮开关状态
    checkable: true
    //ListView显示模型中的数据，view管理委托示例的视图。currentIndex保存当前项的索引。index是视图索引
    onClicked: {ListView.view.currentIndex = index}
    onToggled: {console.log(index);} //调试输出

    //动态创建的项目需要显式地为contentItem添加父元素。:ColumnLayout在网格中动态排列项的方法，列
    contentItem: ColumnLayout{
        spacing: 0 //每个单元格之间的距离，默认5

        //行
        RowLayout{
            //列
            ColumnLayout{
                id: dateColumn
                //只读属性。model调用模型中的数据。
                readonly property date alarmDate: new Date(
                                                      model.year, model.month - 1, model.day, model.hour, model.minute)
                Label{
                    id: itmeLabel
                    //字体大小
                    font.pixelSize: Qt.application.font.pixelSize * 2
                    //设置自定义属性alarmDate的语言环境。toLocaleTimeString将日期转化为指定的环境格式。window.locale窗口的本地区域。ShortFormat为短格式
                    text: dateColumn.alarmDate.toLocaleTimeString(window.locale, Locale.ShortFormat)

                }
                //行
                RowLayout{
                    Label{
                        id: dateLabel
                        text: dateColumn.alarmDate.toLocaleDateString(window.locale,Locale.ShortFormat)
                    }
                    Label{
                        id: alarmAbout
                        text:". "+model.label
                        //是否可见
                        visible: model.label.length>0 &&!root.checked
                    }

                }

            }
            //Item是Qt Quick中所有可视项的基本类型。
            Item{
                //尽可能的宽
                Layout.fillWidth: true
            }
            //选项按钮，开关状态按钮
            Switch{
                id:isSwitch
                //checked按钮是否被选中
                checked: model.activated
                //指定对齐方式，与上级保持一致
                Layout.alignment: Qt.AlignTop
                onClicked:
                {
                    window.whichBtn(index,isSwitch.checked)
                }

            }

        }
        //复选框，可开关的检查按钮
        CheckBox {
            id: alarmRepeat
            text: qsTr("重复")
            checked: model.repeat
            //是否可见
            visible: root.checked
            //两种状态之间的切换
            onToggled: model.repeat = checked
        }

        //并排放置它的子元素
        Flow{
            //可见状态
            visible: root.checked && model.repeat
            //尽可能的宽
            Layout.fillWidth: true

            //用于创建大量类似的项，这类有模型和委托
            Repeater{
                id: dayRepeater
                model: daysToRepeat
                //RoundButton可单击的圆角按钮
                delegate: RoundButton{
                    //dayName返回本地化的日期名称,NarrowFormat一个特殊版本的日期格式，适合空间有限时使用。
                    text:Qt.locale().dayName(model.dayOfWeek,Locale.NarrowFormat)
                    flat: true //按钮是否为平的
                    //按钮是否选中
                    checked:model.repeat
                    //按钮可被检查状态
                    checkable: true
                    //Material模块设置背景色
                    Material.background: checked ? Material.accent:"transparent"
                    //触摸键盘鼠标时发出信号
                    onToggled: model.repeat = checked
                }
            }
        }

        //单行文本输入
        TextField{
            id: alarmDescriptionTextFileld
            placeholderText: qsTr("请在这里输入");
            //文本输入处显示一个光标
            cursorVisible: true
            visible: root.checked
            text: model.label
            //文本编辑时发出信号，把修改过的文本存储到数据源
            onTextEdited:
            {
                model.label = text
                window.onSendText(index,text);
                          }
        }
        //不晓得怎么把index对应上，暂时先隐藏了
        Button{
            id: deleteAlarmButton
            text: qsTr("删除")
            width: 40
            height: 40
        //    visible: root.checked //可见状态
            visible:false
            //单击后删除项
            onClicked:{
                window.deleteBtn(root.ListView.view.currentIndex);
                console.log("执行")
                root.ListView.view.model.remove(root.ListView.view.currentIndex,1);
            }
        }
    }
}
