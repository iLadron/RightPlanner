#include "CalendarModel.h"

CalendarModel::CalendarModel()
{
    time_t date1 = 1629279744;
    time_t date2 = 1627638144;
    time_t date3 = 1629452544;
    QVariantList dates;
    dates.append(QDateTime::fromTime_t(date1));
    dates.append(QDateTime::fromTime_t(date2));
    dates.append(QDateTime::fromTime_t(date3));

    setDatesBurger(dates);
}

QVariantList CalendarModel::datesBurger() const
{
    return m_datesBurger;
}

void CalendarModel::setDatesBurger(QVariantList datesBurger)
{
    if (m_datesBurger == datesBurger)
        return;

    m_datesBurger = datesBurger;
    emit datesBurgerChanged(m_datesBurger);
}
