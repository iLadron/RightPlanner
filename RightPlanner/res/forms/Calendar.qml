import QtQuick 2.14
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as V
import QtQuick.Controls.Styles 1.1
//import MyQmlEnums 1.1


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

        ComboBoxPlanner{
            Component.onCompleted: {
                model = calendarModel.getUsersNames()
            }

            onCurrentIndexChanged: {
                calendarModel.changeUser(currentIndex)
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
                            return "blue"
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
                        var arraySomething = calendarModel.getSomething(styleData.date)
                        var arraySomethingName = calendarModel.getSomethingVector();

                        listModel.clear()
                        for(var i = 0; i < arraySomethingName.length; i++){
                            console.log(arraySomething.indexOf(i))
                            listModel.append({"name": arraySomethingName[i], "qwe": (arraySomething.indexOf(i) === -1 ? false : true)})
                        }

                        //listSomething.forceLayout()

                        for(i = 0; i < arraySomething.length; i++){
                            listSomething.itemAtIndex(arraySomething[i]).children[0].checked = true
                        }

                        for(i = 0; i < listSomething.count; i++){
                            listSomething.itemAtIndex(i).children[0].checked = false
                        }

                        rectAdd.visible = true

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


    Rectangle{
        id: rectAdd
        anchors.centerIn: parent
        visible: false
        width: 200
        height: 300
        color: "green"

        ListModel {
            id:listModel
        }


        ListView{
            id:listSomething
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom:  btnAdd.top
            delegate: RowLayout{
                CheckBox{
                    checked: qwe
                }
                Text{
                    text: name
                }
            }

            model: listModel


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
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            text: qsTr("Добавить")
            onClicked: {
listSomething.itemAtIndex(0).children[0].checked = !listSomething.itemAtIndex(0).children[0].checked
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


