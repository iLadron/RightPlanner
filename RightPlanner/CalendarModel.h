#ifndef CALENDARMODEL_H
#define CALENDARMODEL_H

#include <QObject>
#include <QDateTime>
#include <QVariantList>

class CalendarModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList datesBurger READ datesBurger WRITE setDatesBurger NOTIFY datesBurgerChanged)
public:
    CalendarModel();    

    QVariantList datesBurger() const;

public slots:
    void setDatesBurger(QVariantList datesBurger);

signals:
    void datesBurgerChanged(QVariantList datesBurger);

private:

    QVariantList m_datesBurger;
};

#endif // CALENDARMODEL_H
