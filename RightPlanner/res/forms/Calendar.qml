import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as V
import QtQuick.Controls.Styles 1.1
import MyQmlEnums 1.1


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

                    Label{
                        anchors.fill: parent
                        color: "red"
                        font.pixelSize: 20
                        text:{
                            var string = "";

                            if(calendarModel !== null){

                                var vec = calendarModel.getSomething(styleData.date);
                                console.log(vec.length)
                                for(var i = 0; i < vec.length; i++){
                                    if(vec[i] === Something.Burger){
                                        string+="burger\n"
                                    }
                                    if(vec[i] === Something.Cola){
                                        string+="cola\n"
                                    }
                                }
                            }
                            return string

                        }
                    }







/*
                    Image {
                        id: imgBurger
                        anchors.fill: parent
                        source: "qrc:/res/images/png/burger.png"
                        property var myModel: calendarModel
                        visible: {
                            if(calendarModel !== null){
                                for(var i = 0; i < calendarModel.datesBurger.length; i++){
                                    if(calendar.compareDate(calendarModel.datesBurger[i], dateOnFocus)){
                                        return true
                                    }
                                }
                            }

                            return false
                        }

                        Connections{
                            target: calendarModel

                            onDatesBurgerChanged:{
                                if(calendarModel !== null){
                                    for(var i = 0; i < calendarModel.datesBurger.length; i++){
                                        if(calendar.compareDate(calendarModel.datesBurger[i], dateOnFocus)){
                                            imgBurger.visible = true
                                            return
                                        }
                                    }
                                }

                                imgBurger.visible =  false
                            }
                        }
                    }

                */
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
                    onClicked: {
                        calendar.selectedDate = styleData.date
                    }
                    onDoubleClicked: {
                        rectAdd.visible = true
                    }
                }

            }
        }
        function compareDate(lhs, rhs){
            return (lhs.getDate() === rhs.getDate() && lhs.getFullYear() === rhs.getFullYear() && lhs.getMonth() === rhs.getMonth())
        }
    }


    Rectangle{
        id: rectAdd
        anchors.centerIn: parent
        visible:  false
        width: 200
        height: 200
        color: "green"

        ListView{
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom:  btnAdd.top
            delegate: RowLayout{
                CheckBox{

                }
                Text{
                    text: name
                }
            }

            model: ListModel {
                ListElement {
                    name: qsTr("Бургер")
                }
                ListElement {
                    name: qsTr("Кола")
                }
                ListElement {
                    name: qsTr("Ещё что-то")
                }
            }

        }

        Button{
            id:btnAdd
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Обновить")
            onClicked: {
                //calendarModel.addSomething(calendar.selectedDate , [1,2,3])
                rectAdd.visible = false
            }
        }
    }
}
