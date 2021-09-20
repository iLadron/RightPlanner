#ifndef CALENDARMODEL_H
#define CALENDARMODEL_H

#include <QObject>
#include <QDateTime>
#include <QVariantList>
#include <map>
#include <string>
#include <QQmlEngine>
#include <QtGlobal>

#include "database.h"


class CalendarModel : public QObject
{
    Q_OBJECT

public:

    CalendarModel();

public slots:
    std::vector<int> getSomething(const QDateTime& date) const;         //Получить вредность за выбранный день
    void addSomething(const QDateTime& date, std::vector<int> data);    //Добавить вредность на выбранный день
    QString getSomethingName(int index) const;                          //Получить наименование вредностей
    QStringList getSomethingVector() const;                             //Получить вектор вредностей (вызов из QML)
    QStringList getUsersNames() const;                                  //Получить список пользователей
    void changeUser(int index);                                            //Сменить пользователя

signals:
    void calendarChanged();

private:

    std::map<QDate, std::vector<int>> m_calendar; //День + вредности
    std::vector<std::string> m_something; //Вектор вредностей
    std::vector<User> m_users; //Пользователи
};

#endif // CALENDARMODEL_H
