#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "QQuickStyle"

#include <controllers/master-controller.h>
#include <controllers/command-controller.h>
#include <controllers/navigation-controller.h>
#include <data/datetime-decorator.h>
#include <data/enumerator-decorator.h>
#include <data/int-decorator.h>
#include <data/string-decorator.h>
#include <data/dropdown.h>
#include <data/dropdown-value.h>
#include <framework/command.h>
#include <framework/object-factory.h>
#include <models/address.h>
#include <models/appointment.h>
#include <models/client.h>
#include <models/client-search.h>
#include <models/contact.h>
#include <rss/rss-channel.h>
#include <rss/rss-image.h>
#include <rss/rss-item.h>
#include <data/first-plane.h>
#include <data/second-plane.h>
#include <data/third-plane.h>

int main(int argc, char *argv[])
{


    QQuickStyle::setStyle("Universal");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


    QGuiApplication app(argc, argv);


    qmlRegisterType<cm::controllers::MasterController>("CM", 1, 0, "MasterController");
    qmlRegisterType<cm::data::Planes>("CM", 1, 0, "Planes");
    qmlRegisterType<cm::data::FirstPlane>("CM", 1 , 0, "FirstPlane");
    qmlRegisterType<cm::data::SecondPlane>("CM", 1 , 0, "SecondPlane");
    qmlRegisterType<cm::data::ThirdPlane>("CM", 1 , 0, "ThirdPlane");
    qmlRegisterType<cm::data::CustomStringDecorator>("CM", 1, 0, "CustomStringDecorator");

    qmlRegisterUncreatableType<cm::controllers::INavigationController>("CM", 1, 0, "INavigationController", "Interface");
    qmlRegisterUncreatableType<cm::controllers::ICommandController>("CM", 1, 0, "ICommandController", "Interface");

    qmlRegisterType<cm::data::DateTimeDecorator>("CM", 1, 0, "DateTimeDecorator");
    qmlRegisterType<cm::data::EnumeratorDecorator>("CM", 1, 0, "EnumeratorDecorator");
    qmlRegisterType<cm::data::IntDecorator>("CM", 1, 0, "IntDecorator");
    qmlRegisterType<cm::data::StringDecorator>("CM", 1, 0, "StringDecorator");
    qmlRegisterType<cm::data::DropDown>("CM", 1, 0, "DropDown");
    qmlRegisterType<cm::data::DropDownValue>("CM", 1, 0, "DropDownValue");

    qmlRegisterType<cm::models::Address>("CM", 1, 0, "Address");
    qmlRegisterType<cm::models::Appointment>("CM", 1, 0, "Appointment");
    qmlRegisterType<cm::models::Client>("CM", 1, 0, "Client");
    qmlRegisterType<cm::models::ClientSearch>("CM", 1, 0, "ClientSearch");
    qmlRegisterType<cm::models::Contact>("CM", 1, 0, "Contact");

    qmlRegisterType<cm::framework::Command>("CM", 1, 0, "Command");

    qmlRegisterType<cm::rss::RssChannel>("CM", 1, 0, "RssChannel");
    qmlRegisterType<cm::rss::RssImage>("CM", 1, 0, "RssImage");
    qmlRegisterType<cm::rss::RssItem>("CM", 1, 0, "RssItem");


    cm::framework::ObjectFactory objectFactory;
    cm::controllers::MasterController masterController(nullptr, &objectFactory);


    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    engine.rootContext()->setContextProperty("masterController", &masterController);
    engine.load(QUrl(QStringLiteral("qrc:/views/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
