#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QQuickView>

class MainWindow : public QQuickView

{
    Q_OBJECT

public:
    MainWindow();
    ~MainWindow();
};
#endif // MAINWINDOW_H
