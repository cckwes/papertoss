#include <QApplication>
#include <QtDeclarative>
#include <QUrl>
#include "throwsettings.h"

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    ThrowSettings ts;
    view.rootContext()->setContextProperty("tSettings", &ts);
    view.setSource(QUrl("qrc:///PaperTossDesk.qml"));
    view.show();
    return app.exec();
}
