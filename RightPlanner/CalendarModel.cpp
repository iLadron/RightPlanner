#include "CalendarModel.h"

CalendarModel::CalendarModel()
{
    time_t date1 = 1629279744;
    time_t date2 = 1627638144;
    time_t date3 = 1629452544;

    m_something.push_back("Burger");
    m_something.push_back("Cola");
    m_something.push_back("Other");


    m_calendar.insert({QDateTime::fromTime_t(date1).date(), {0}});
    m_calendar.insert({QDateTime::fromTime_t(date2).date(), {0, 1}});
    m_calendar.insert({QDateTime::fromTime_t(date3).date(), {1}});

}

//void CalendarModel::declareEnumToQml()
//{
//    qmlRegisterType<CalendarModel>("MyQmlEnums", 1, 1, "Something");
//}

std::vector<int> CalendarModel::getSomething(const QDateTime &date) const
{
    if(m_calendar.find(date.date()) != m_calendar.end()){
        return m_calendar.at(date.date());
    }
    return {};
}

void CalendarModel::addSomething(const QDateTime& date, std::vector<int> data)
{
    m_calendar[date.date()] = data;
    emit calendarChanged();
}

QString CalendarModel::getSomethingName(int index) const
{
    return QString::fromStdString( m_something.at( index));
}

QStringList CalendarModel::getSomethingVector() const
{
    QStringList res;
    for(const auto& el : m_something){
        res.append(QString::fromStdString(el));
    }
    return res;
}
