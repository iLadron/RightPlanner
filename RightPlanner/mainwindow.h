#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QQuickView>
#include <QQmlContext>
#include <memory>

#include "CalendarModel.h"

class MainWindow : public QQuickView

{
    Q_OBJECT

public:
    MainWindow();
    ~MainWindow();

private:

     std::shared_ptr<CalendarModel> m_calendarModel;
};
#endif // MAINWINDOW_H
