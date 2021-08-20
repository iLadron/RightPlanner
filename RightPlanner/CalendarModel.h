#ifndef CALENDARMODEL_H
#define CALENDARMODEL_H

#include <QObject>
#include <QDateTime>
#include <QVariantList>
#include <map>
#include <QQmlEngine>
#include <QtGlobal>


class CalendarModel : public QObject
{
    Q_OBJECT

public:

    enum Something {
        Burger,
        Cola,
        Other
    };

    Q_ENUMS(Something)

    CalendarModel();
    void declareEnumToQml();



public slots:
    std::vector<int> getSomething(const QDateTime& date) const;
signals:

private:

    std::map<QDate, std::vector<int>> m_calendar;
};

#endif // CALENDARMODEL_H
