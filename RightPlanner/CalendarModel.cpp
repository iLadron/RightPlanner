#include "CalendarModel.h"

CalendarModel::CalendarModel()
{
    time_t date1 = 1629279744;
    time_t date2 = 1627638144;
    time_t date3 = 1629452544;

    m_calendar.insert({QDateTime::fromTime_t(date1).date(), {Something::Burger}});
    m_calendar.insert({QDateTime::fromTime_t(date2).date(), {Something::Burger, Something::Cola}});
    m_calendar.insert({QDateTime::fromTime_t(date3).date(), {Something::Cola}});

}

void CalendarModel::declareEnumToQml()
{
    qmlRegisterType<CalendarModel>("MyQmlEnums", 1, 1, "Something");
}

std::vector<int> CalendarModel::getSomething(const QDateTime &date) const
{
    if(m_calendar.find(date.date()) != m_calendar.end()){
        return m_calendar.at(date.date());
    }
    return {};
}
