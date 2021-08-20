#include "mainwindow.h"

MainWindow::MainWindow() {

    setResizeMode(QQuickView::SizeRootObjectToView);
    setMinimumSize(QSize(800,600));
    setMaximumSize(QSize(1200,800));

    m_calendarModel = std::shared_ptr<CalendarModel>(new (std::nothrow) CalendarModel);
    m_calendarModel->declareEnumToQml();

    rootContext()->setContextProperty("calendarModel", m_calendarModel.get());
    setSource(QUrl("qrc:/res/forms/Calendar.qml"));

}

MainWindow::~MainWindow() {

}

