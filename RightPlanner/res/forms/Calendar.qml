import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as V   //for calendar
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.12
import Theme 1.0
//import MyQmlEnums 1.1


import "../components"
import "../images/png"

Rectangle {
    anchors.fill: parent
    color: "blue"

    Component.onCompleted: {
        Theme.theme = 0
    }

    Rectangle{
        id:mainPage
        anchors.fill: parent
        color: "blue"

        enabled: !rectAdd.visible

        RowLayout{
            id: rowUser
            height: 24
            LabelPlanner{
                text: qsTr("Пользователь: ")
            }

            ComboBoxPlanner{
                Component.onCompleted: {
                    model = calendarModel.getUsersNames()
                }

                onCurrentIndexChanged: {
                    calendarModel.changeUser(currentIndex)
                }
            }

        }

        RowLayout{
            id: rowTheme
            anchors.right: parent.right
            height: 24
            LabelPlanner{
                text: qsTr("Тема: ")
            }

            ComboBoxPlanner{
                model: ["Тема 1", "Тема 2"]

                onCurrentIndexChanged: {
                    Theme.theme = currentIndex
                }
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
                    property var currentMounth: styleData.date.getMonth()

                    onCurrentMounthChanged: calendarRefresh()

                    opacity: styleData.visibleMonth ? 1.0 : 0.5
                    Rectangle {
                        id:rectDay
                        anchors.fill: parent
                        border.color: "grey"
                        border.width: 1

                        color: {
                            if(styleData.selected && styleData.visibleMonth){
                                return Theme.calendar.colorSelectedBackground
                            }
                            return "white"
                        }

                        Label{
                            id:txt
                            anchors.fill: parent
                            color: "red"
                            font.pixelSize: 20

                            Connections{
                                target: calendarModel
                                onCalendarChanged: calendarRefresh()
                            }
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
                                    return Theme.calendar.colorCommonText
                                }else{
                                    return styleData.selected ? Theme.calendar.colorCommonText : Theme.calendar.colorCommonText
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

                        Timer{
                            id: timer
                            interval: 200

                        }
                        onClicked: {
                            calendar.selectedDate = styleData.date
                            calendarModel.changeDate(styleData.date)

                            if(timer.running){

                                /*
                                var arraySomething = calendarModel.getSomething(styleData.date)
                                var arraySomethingName = calendarModel.getSomethingVector();

                                //listModel.clear()

                                for(var i = 0; i < arraySomethingName.length; i++){
                                    listModel.append({"name": arraySomethingName[i], "qwe": (arraySomething.indexOf(i) !== -1)})
                                }

                                for(i = 0; i < arraySomething.length; i++){
                                    listSomething.itemAtIndex(arraySomething[i]).children[0].checked = true
                                }

                                for(i = 0; i < listSomething.count; i++){
                                    listSomething.itemAtIndex(i).children[0].checked = false
                                }
                                */

                                rectAdd.visible = true
                                timer.stop()
                            }
                            else {
                                timer.restart()
                            }

                        }
                    }


                    function calendarRefresh(){
                        var string = "";
                        if(calendarModel !== null){
                            var vec = calendarModel.getSomething(styleData.date);
                            for(var i = 0; i < vec.length; i++){

                                string += calendarModel.getSomethingName(vec[i]) + '\n'
                            }
                        }
                        txt.text = string
                    }
                }
            }
            function compareDate(lhs, rhs){
                return (lhs.getDate() === rhs.getDate() && lhs.getFullYear() === rhs.getFullYear() && lhs.getMonth() === rhs.getMonth())
            }
        }

    }


    FastBlur{
        radius: 8
        source: mainPage
        anchors.fill: mainPage
        visible: rectAdd.visible
    }

    Rectangle{
        id: rectAdd
        anchors.centerIn: parent
        visible: false
        width: 200
        height: 300
        color: "green"


        /*
        ListModel {
            id:listModel
        }
*/

        onVisibleChanged: {
            if(!visible){
                calendar.focus = true
            }
        }

        ListView{
            id:listSomething
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom:  btnAdd.top
            delegate: RowLayout{
                CheckBox{
                    checked: using
                }
                Text{
                    text: name
                }
            }

            model: badModel


        }

        Button{
            id:btnAdd
            anchors.bottom: btnAddCategory.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Обновить")
            onClicked: {
                var arraySomething = [];
                for(var i = 0; i < listSomething.count; i++){
                    if(listSomething.itemAtIndex(i).children[0].checked){
                        arraySomething.push(i)
                    }
                }
                calendarModel.addSomething(calendar.selectedDate, arraySomething)
                rectAdd.visible = false
            }
        }

        Button{
            id:btnAddCategory
            anchors.bottom: btnClose.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Добавить (не работает)")
            onClicked: {
                console.log(Theme.calendar.colorSelectedBackground)
            }
        }

        Button{
            id:btnClose
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Закрыть")
            onClicked: {
                rectAdd.visible = false
            }
        }
    }
}



//Заготовка для гифок

//AnimatedImage{
//    id:anima
//    z:100
//    anchors.fill: parent
//    visible: styleData.visibleMonth
//    source: "qrc:/res/images/gif/dog.gif"
//    onStatusChanged: playing = (status == AnimatedImage.Ready)
//    speed: styleData.date
//}




//Заготовка для картинок (возможно, уже не актуально)

//Image {
//    id: imgBurger
//    anchors.fill: parent
//    source: "qrc:/res/images/png/burger.png"
//    property var myModel: calendarModel
//    visible: {
//        if(calendarModel !== null){
//            for(var i = 0; i < calendarModel.datesBurger.length; i++){
//                if(calendar.compareDate(calendarModel.datesBurger[i], dateOnFocus)){
//                    return true
//                }
//            }
//        }

//        return false
//    }

//    Connections{
//        target: calendarModel

//        onDatesBurgerChanged:{
//            if(calendarModel !== null){
//                for(var i = 0; i < calendarModel.datesBurger.length; i++){
//                    if(calendar.compareDate(calendarModel.datesBurger[i], dateOnFocus)){
//                        imgBurger.visible = true
//                        return
//                    }
//                }
//            }

//            imgBurger.visible =  false
//        }
//    }
//}


