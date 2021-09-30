#ifndef CALENDARMODEL_H
#define CALENDARMODEL_H

#include <QObject>
#include <QDateTime>
#include <QVariantList>
#include <map>
#include <string>
#include <QQmlEngine>
#include <QtGlobal>
#include <QAbstractTableModel>
#include <memory>
#include <algorithm>

#include "database.h"


class BadModel : public QAbstractTableModel {

    Q_OBJECT

public:
    BadModel();

    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;


    const QDate &currentDate() const;
    void setCurrentDate(const QDate &newCurrentDate);

    void setCalendar(const std::map<QDate, std::vector<int> > &newCalendar);


public slots:
    QString getSomethingName(int i);

private:
    std::vector<std::string> m_something; //Вектор вредностей
    std::map<QDate, std::vector<int>> m_calendar; //День + вредности
    QDate m_currentDate;
    enum BadRoles {
        E_IsUsedRole = Qt::UserRole + 1,
        E_NameRole
    };

};




class CalendarModel : public QObject
{
    Q_OBJECT

public:

    CalendarModel();
    BadModel* getBadModel ();

public slots:
    std::vector<int> getSomething(const QDateTime& date) const;         //Получить вредность за выбранный день
    void addSomething(const QDateTime& date, std::vector<int> data);    //Добавить вредность на выбранный день
    QStringList getUsersNames() const;                                  //Получить список пользователей
    void changeUser(int index);                                         //Сменить пользователя
    void changeDate(const QDateTime& date);

signals:
    void calendarChanged();

private:

    std::map<QDate, std::vector<int>> m_calendar; //День + вредности
    std::vector<User> m_users; //Пользователи
    int m_currentUserIndex = -1;
    std::shared_ptr<BadModel> m_badModel;
};



#endif // CALENDARMODEL_H
