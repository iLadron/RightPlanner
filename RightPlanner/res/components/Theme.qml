pragma Singleton
import QtQuick 2.0
import QtQuick.Controls.Styles 1.4

Item {

    property int theme: -1
    property alias calendar: calendar


    onThemeChanged: {
        switch(theme){
            case 0:

                calendar.colorAnotherMonthText       = ""
                calendar.colorSelectedText           = ""
                calendar.colorCommonText             = "red"
                calendar.colorHeadText               = ""
                calendar.colorDayOfWeekText          = ""

                calendar.colorBackground             = ""
                calendar.colorSelectedBackground     = "blue"
                calendar.colorBetweenBackground      = ""
                calendar.colorDayOfWeekBackground    = ""
                calendar.colorBorder                 = ""
                calendar.colorNowDateBackground      = ""

                calendar.colorBottomMenuBackground   = ""
                calendar.colorBottomMenuDateText     = ""
                calendar.colorBottomMenuButtonText   = ""
                break
            case 1:
                calendar.colorAnotherMonthText       = ""
                calendar.colorSelectedText           = ""
                calendar.colorCommonText             = "green"
                calendar.colorHeadText               = ""
                calendar.colorDayOfWeekText          = ""

                calendar.colorBackground             = ""
                calendar.colorSelectedBackground     = "grey"
                calendar.colorBetweenBackground      = ""
                calendar.colorDayOfWeekBackground    = ""
                calendar.colorBorder                 = ""
                calendar.colorNowDateBackground      = ""

                calendar.colorBottomMenuBackground   = ""
                calendar.colorBottomMenuDateText     = ""
                calendar.colorBottomMenuButtonText   = ""
                break
            default:
                break

        }
    }

    Item {
        id: calendar
        property color colorAnotherMonthText
        property color colorSelectedText
        property color colorCommonText
        property color colorHeadText
        property color colorDayOfWeekText

        property color colorBackground
        property color colorSelectedBackground
        property color colorBetweenBackground
        property color colorDayOfWeekBackground
        property color colorBorder
        property color colorNowDateBackground

        property color colorBottomMenuBackground
        property color colorBottomMenuDateText
        property color colorBottomMenuButtonText
    }


}
