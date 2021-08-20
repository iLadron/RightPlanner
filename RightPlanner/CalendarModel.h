#ifndef CALENDARMODEL_H
#define CALENDARMODEL_H

#include <QObject>
#include <QDateTime>
#include <QVariantList>
#include <map>

class CalendarModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList datesBurger READ datesBurger WRITE setDatesBurger NOTIFY datesBurgerChanged)
public:
    CalendarModel();    

    QVariantList datesBurger() const;

public slots:
    void setDatesBurger(QVariantList datesBurger);
    void addSomething(const QDateTime& date, const QVector<int>& checked);

signals:
    void datesBurgerChanged(QVariantList datesBurger);

private:

    QVariantList m_datesBurger;
    std::map<QDateTime, vector<int>> m_calendar;
};

#endif // CALENDARMODEL_H
