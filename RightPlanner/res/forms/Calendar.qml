import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as V
import QtQuick.Controls.Styles 1.1


import "../components"
import "../images/png"

Rectangle {
    anchors.fill: parent
    color: "blue"

    RowLayout{
        id: rowUser
        height: 24
        LabelPlanner{
            text: qsTr("Пользователь: ")
        }
        LabelPlanner{
            text: qsTr("Андрей")
        }
    }

    V.Calendar{
        id:calendar
        anchors.top:rowUser.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10

        style: CalendarStyle{

            dayDelegate: Item {
                property var dateOnFocus: styleData.date
                opacity: styleData.visibleMonth ? 1.0 : 0.5
                Rectangle {
                    id:rectDay
                    anchors.fill: parent
                    border.color: "grey"
                    border.width: 1

                    color: {
                        if(styleData.selected && styleData.visibleMonth){
                            return "blue"
                        }
                        return "white"
                    }

                    Image {
                        id: imgBurger
                        anchors.fill: parent
                        source: "qrc:/res/images/png/burger.png"
                    }
                }

                Rectangle{
                    anchors.centerIn: parent
                    height: 25
                    width: 25
                    color: "lightgrey"
                    Label {
                        id:lblTextDate
                        text: dateOnFocus.getDate()
                        anchors.centerIn: parent
                        color: {
                            if(!styleData.visibleMonth){
                                return "red"
                            }else{
                                return styleData.selected ? "red" : "red"
                            }
                        }
                        font {
                            bold: true
                            pixelSize: 20
                        }


                    }
                }


                MouseArea{
                    anchors.fill: parent
                    onClicked:  {
                        if(!styleData.visibleMonth){
                            return
                        }
                        calendar.selectedDate = dateOnFocus
                    }

                }

            }
        }
    }
}
