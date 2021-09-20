#include "database.h"

DataBase* DataBase::m_dataBase = nullptr;

DataBase *DataBase::get(){
    if(m_dataBase == nullptr){
        m_dataBase = new DataBase();
    }
    return m_dataBase;
}

std::vector<User> DataBase::getUsers()
{
    return m_users;
}

std::map<QDate, std::vector<int> > DataBase::getUsersSomething(int id) const
{
    if(id == 1){
        return m_calendarLika;
    }
    else {
        return m_calendarAndrey;
    }
}

DataBase::DataBase()
{
    User tempUser;
    tempUser.id = 1;
    tempUser.name = "Лика";
    m_users.push_back(tempUser);

    tempUser.id = 2;
    tempUser.name = "Андрей";
    m_users.push_back(tempUser);

    time_t date1 = 1629279744;
    time_t date2 = 1627638144;
    time_t date3 = 1629452544;
    time_t date4 = 1632489895;


    m_calendarAndrey.insert({QDateTime::fromTime_t(date1).date(), {0}});
    m_calendarAndrey.insert({QDateTime::fromTime_t(date2).date(), {0, 1}});
    m_calendarAndrey.insert({QDateTime::fromTime_t(date3).date(), {1}});
    m_calendarAndrey.insert({QDateTime::fromTime_t(date4).date(), {0, 1, 2}});


    date1 = 1632144296;
    date2 = 1632317095;
    date3 = 1634909095;

    m_calendarLika.insert({QDateTime::fromTime_t(date1).date(), {1}});
    m_calendarLika.insert({QDateTime::fromTime_t(date2).date(), {0, 1, 2}});
    m_calendarLika.insert({QDateTime::fromTime_t(date3).date(), {2}});

}
