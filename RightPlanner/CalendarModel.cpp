#include "CalendarModel.h"

CalendarModel::CalendarModel()
{
    time_t date1 = 1629279744;
    time_t date2 = 1627638144;
    time_t date3 = 1629452544;

    m_calendar.insert({QDateTime::fromTime_t(date1).date(), {0}});
    m_calendar.insert({QDateTime::fromTime_t(date2).date(), {0, 1}});
    m_calendar.insert({QDateTime::fromTime_t(date3).date(), {1}});

    m_users = DataBase::get()->getUsers();
    changeUser(0);

    m_badModel = std::shared_ptr<BadModel>(new (std::nothrow) BadModel);
    m_badModel.get()->setCalendar(m_calendar);

    qmlRegisterSingletonType(QUrl("qrc:/res/components/Theme.qml"), "Theme", 1, 0, "Theme");
}

BadModel *CalendarModel::getBadModel()
{
    return m_badModel.get();
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
    m_badModel.get()->setCalendar(m_calendar);
    DataBase::get()->addSomething(m_users.at(m_currentUserIndex).id, date, data);
    emit calendarChanged();
}

QStringList CalendarModel::getUsersNames() const
{
    QStringList names;
    for(const auto& user : m_users){
        names.push_back(user.name);
    }

    return names;
}

void CalendarModel::changeUser(int index)
{
    m_calendar = DataBase::get()->getUsersSomething(m_users.at(index).id);
    if(m_badModel != nullptr){
        m_badModel.get()->setCalendar(m_calendar);
    }
    m_currentUserIndex = index;
    emit calendarChanged();
}

void CalendarModel::changeDate(const QDateTime &date)
{
    m_badModel.get()->setCurrentDate(date.date());
}

BadModel::BadModel()
{
    m_something.push_back("Burger");
    m_something.push_back("Cola");
    m_something.push_back("Other");

}

int BadModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_something.size();
}

int BadModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 2;
}

QVariant BadModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return QString("nan");

    switch (role) {
        case E_NameRole:{
            return QString::fromStdString(m_something.at(index.row()));
        }
        case E_IsUsedRole:{
            return true;
        }
        default:{
            return QString("nan");
        }
    }
}

QHash<int, QByteArray> BadModel::roleNames() const
{
    QHash<int, QByteArray> res;

    res[E_NameRole]   = "name";
    res[E_IsUsedRole] = "using";

    return res;
}

const QDate &BadModel::currentDate() const
{
    return m_currentDate;
}

void BadModel::setCurrentDate(const QDate &newCurrentDate)
{
    m_currentDate = newCurrentDate;
}

void BadModel::setCalendar(const std::map<QDate, std::vector<int> > &newCalendar)
{
    m_calendar = newCalendar;
}
