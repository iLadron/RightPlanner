#ifndef DATABASE_H
#define DATABASE_H

#include <QString>
#include <vector>
#include <map>
#include <QDate>

#include "DataBase_global.h"

struct User{
    int id = -1;
    QString name = "";
};

class DATABASE_EXPORT DataBase
{
public:

    static DataBase *get();
    std::vector<User> getUsers();
    std::map<QDate, std::vector<int>> getUsersSomething(int id) const;

protected:
    DataBase();

    static DataBase *m_dataBase;

    //TEMP. Before SQL database
    std::vector<User> m_users;
    std::map<QDate, std::vector<int>> m_calendarLika; //День + вредности
    std::map<QDate, std::vector<int>> m_calendarAndrey; //День + вредности

};

#endif // DATABASE_H
