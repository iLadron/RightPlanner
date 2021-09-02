#ifndef CALENDARMODEL_H
#define CALENDARMODEL_H

#include <QObject>
#include <QDateTime>
#include <QVariantList>
#include <map>
#include <string>
#include <QQmlEngine>
#include <QtGlobal>


class CalendarModel : public QObject
{
    Q_OBJECT

public:
/*
    enum Something {
        Burger,
        Cola,
        Other
    };

    Q_ENUMS(Something)

    void declareEnumToQml();

*/
    CalendarModel();

public slots:
    std::vector<int> getSomething(const QDateTime& date) const;
    void addSomething(const QDateTime& date, std::vector<int> data);
    QString getSomethingName(int index) const;
    QStringList getSomethingVector() const;

signals:
    void calendarChanged();

private:

    std::map<QDate, std::vector<int>> m_calendar;
    std::vector<std::string> m_something;
};

#endif // CALENDARMODEL_H
