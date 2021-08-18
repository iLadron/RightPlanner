#include "mainwindow.h"

MainWindow::MainWindow() {
    setSource(QUrl("qrc:/res/forms/Calendar.qml"));
    setResizeMode(QQuickView::SizeRootObjectToView);
    setMinimumSize(QSize(800,600));
    setMaximumSize(QSize(1200,800));
}

MainWindow::~MainWindow() {

}

