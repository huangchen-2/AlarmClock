import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.12 //设计模块，可以其项目的大小。因为是布局项所以可以嵌套在其它地方

//本机对话框的基类
Dialog{
    id: alarmDialog
    title: "添加新的闹钟"
    //窗口是否为模态
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property AlarmModel alarmModel
    property var date :[]


    //小于10时前面加个"0"
    function formatNumber(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }

    //点击ok按钮时执行此信号中的添加功能
    onAccepted: {
        //添加数据到列表视图中的model(数据模型)
        alarmModel.append({
                              "hour": hoursTumbler.currentIndex,
                              "minute": minutesTumbler.currentIndex,
                              "day": dayTumbler.currentIndex + 1,
                              "month": monthTumbler.currentIndex + 1,
                              "year": yearTumbler.years[yearTumbler.currentIndex],
                              "activated": false,
                              "label": "",
                              "repeat": false,
                              "daysToRepeat": [
                                  { "dayOfWeek": 0, "repeat": false },
                                  { "dayOfWeek": 1, "repeat": false },
                                  { "dayOfWeek": 2, "repeat": false },
                                  { "dayOfWeek": 3, "repeat": false },
                                  { "dayOfWeek": 4, "repeat": false },
                                  { "dayOfWeek": 5, "repeat": false },
                                  { "dayOfWeek": 6, "repeat": false }
                              ],

                          })
        date.length = 0
        console.log(monthTumbler.currentIndex + 1)
        date.push(formatNumber(yearTumbler.years[yearTumbler.currentIndex]))
        date.push(formatNumber(monthTumbler.currentIndex + 1))
        date.push(formatNumber(dayTumbler.currentIndex + 1))
        date.push(formatNumber(minutesTumbler.currentIndex))
        date.push(formatNumber(hoursTumbler.currentIndex))
        onQmlSignalA(date);
    }

    //点击拒绝按钮时关闭对话框
    onRejected: alarmDialog.close()

    //contentItem实现对话框内容的QML对象，应该是一个项。RowLayout为一行
    contentItem: RowLayout{

        RowLayout{
            id: rowTumbler
            //一个滚轮选择部件，小时
            Tumbler{
                id: hoursTumbler
                model: 24 //数据模型
                //何种方式显示
                delegate: TumblerDelegate{
                    //modelData代表滚轮选中的数据
                    text: formatNumber(modelData)
                }
            }
            //分钟滚轮
            Tumbler {
                id: minutesTumbler
                model: 60
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                }
            }
        }

        //一行
        RowLayout{
            id: datePicker
            //外边距
            Layout.leftMargin: 20

            property alias dayTumbler: dayTumbler
            //monthTumbler:月份
            property alias monthTumbler: monthTumbler
            property alias yearTumbler: yearTumbler

            //每个月的天数
            readonly property var days: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            //天数
            Tumbler {
                id: dayTumbler
                //判断该怎么显示天数
                function updateModel() {
                    // Populate the model with days of the month. For example: [0, ..., 30]
                    //js中的var代表一个变量。滚轮的索引
                    var previousIndex = dayTumbler.currentIndex
                    var array = []
                    //得到月份的正确天数
                    var newDays = datePicker.days[monthTumbler.currentIndex]
                    //
                    for (var i = 1; i <= newDays; ++i)
                        array.push(i)
                    //每月的日期
                    dayTumbler.model = array
                    //Math.min返回最小值。这里currentIndex得到滚轮项的索引
                    dayTumbler.currentIndex = Math.min(newDays - 1, previousIndex)
                }
                //onCompleted：对象被实例化后马上发出
                Component.onCompleted: updateModel()

                delegate: TumblerDelegate {
                    //                    Button{
                    //                        width: 20
                    //                        height:20
                    //                        text: "测试按钮"
                    //                        onClicked:console.log("1==",dayTumbler.currentIndex);

                    //                    }
                    text: formatNumber(modelData)
                }


            }

            //月份
            Tumbler {
                id: monthTumbler
                //当索引通过用户交互发生变化时发出信号。根据月份显示正确的天数
                onCurrentIndexChanged: dayTumbler.updateModel()

                model: 12
                delegate: TumblerDelegate {
                    //standaloneMonthName返回本地化的月份名称。
                    text: window.locale.standaloneMonthName(modelData, Locale.ShortFormat)
                }
            }

            //年
            Tumbler {
                id: yearTumbler
                //只读属性
                readonly property var years: (function() {
                    //getFullYear为js函数，返回系统当前年份
                    var currentYear = new Date().getFullYear()
                    //js函数map() 方法返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。把数组值0,1,2依次加上当前年份后返回
                    return [0, 1, 2].map(function(value) { return value + currentYear; })
                })()

                model: years
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                }
            }
        }


    }

}

