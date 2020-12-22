#include "database-controller.h"

#include <QDebug>
#include <QJsonDocument>
#include <QSqlDatabase>
#include <QSqlQuery>



using namespace cm::data;

namespace cm {
namespace controllers {

class DatabaseController::Implementation
{
public:
    Implementation(DatabaseController* _databaseController)
        : databaseController(_databaseController)
    {
        firstPlane= new FirstPlane;   // Initialisation of Planes
        secondPlane= new SecondPlane;
        thirdPlane= new ThirdPlane;


        if (initialise()) {
            qDebug() << "Database created using Sqlite version: " + sqliteVersion();
            if (createTables()) {
                qDebug() << "Database tables created";
            } else {
                qDebug() << "ERROR: Unable to create database tables";
            }
        } else {
            qDebug() << "ERROR: Unable to open database";
        }
    }

    DatabaseController* databaseController{nullptr};
    QSqlDatabase database;
    FirstPlane* firstPlane{nullptr};
    SecondPlane* secondPlane{nullptr};
    ThirdPlane* thirdPlane{nullptr};


private:
    bool initialise()
    {
        database = QSqlDatabase::addDatabase("QSQLITE");
        database.setDatabaseName( "fb.db" );



#if defined(Q_OS_ANDROID)


        QFile exportfile(":/assets/fb.db");
        QString destinationFile = QStandardPaths::writableLocation(QStandardPaths::HomeLocation).append("/fb.db");

        if(!QFile::exists(destinationFile))
        {
            exportfile.copy(destinationFile);
            QFile::setPermissions(destinationFile,QFile::WriteOwner | QFile::ReadOwner);
        }

        database.setDatabaseName(destinationFile);


#endif

        return database.open();

    }

    bool createTables()
    {
        return createJsonTable( "client" );
    }

    bool createJsonTable(const QString& tableName) const
    {
        QSqlQuery query(database);
        QString sqlStatement = "CREATE TABLE IF NOT EXISTS " + tableName + " (id text primary key, name text, json text not null)";

        if (!query.prepare(sqlStatement)) return false;

        return query.exec();
    }

    QString sqliteVersion() const
    {
        QSqlQuery query(database);

        query.exec("SELECT sqlite_version()");

        if (query.next()) return query.value(0).toString();

        return QString::number(-1);
    }
};
}

namespace controllers {

DatabaseController::DatabaseController(QObject* parent)
    : IDatabaseController(parent)
{
    implementation.reset(new Implementation(this));
}

DatabaseController::~DatabaseController()
{
}

bool DatabaseController::createRow(const QString& tableName, const QString& fullname, const QString& id, const QJsonObject& jsonObject) const
{
    if (tableName.isEmpty()) return false;
    if (id.isEmpty()) return false;
    if (jsonObject.isEmpty()) return false;

    QSqlQuery query(implementation->database);

    QString sqlStatement = "INSERT OR REPLACE INTO " + tableName + " (id, name, json) VALUES (:id, :fullname, :json)";

    if (!query.prepare(sqlStatement)) return false;

    query.bindValue(":id", QVariant(id));
    query.bindValue(":fullname", QVariant(fullname));
    query.bindValue(":json", QVariant(QJsonDocument(jsonObject).toJson(QJsonDocument::Compact)));

    if(!query.exec()) return false;

    return query.numRowsAffected() > 0;
}

bool DatabaseController::deleteRow(const QString& tableName, const QString& id) const
{
    if (tableName.isEmpty()) return false;
    if (id.isEmpty()) return false;

    qDebug()<<id;

    QSqlQuery query(implementation->database);

    QString sqlStatement = "DELETE FROM " + tableName + " WHERE id=:id";

    if (!query.prepare(sqlStatement)) return false;

    query.bindValue(":id", QVariant(id));

    if(!query.exec()) return false;

    return query.numRowsAffected() > 0;
}

QJsonArray DatabaseController::find(const QString& tableName, const QString& searchText) const
{
    if (tableName.isEmpty()) return {};
    if (searchText.isEmpty()) return {};

    QSqlQuery query(implementation->database);

    QString sqlStatement = "SELECT json FROM " + tableName + " where lower(json) like :searchText";

    if (!query.prepare(sqlStatement)) return {};

    query.bindValue(":searchText", QVariant("%" + searchText.toLower() + "%"));

    if (!query.exec()) return {};

    QJsonArray returnValue;

    while ( query.next() ) {
        auto json = query.value(0).toByteArray();
        auto jsonDocument = QJsonDocument::fromJson(json);
        if (jsonDocument.isObject()) {
            returnValue.append(jsonDocument.object());
        }
    }

    return returnValue;
}

QJsonObject DatabaseController::readRow(const QString& tableName, const QString& id) const
{
    if (tableName.isEmpty()) return {};
    if (id.isEmpty()) return {};

    QSqlQuery query(implementation->database);

    QString sqlStatement = "SELECT json FROM " + tableName + " WHERE id=:id";

    if (!query.prepare(sqlStatement)) return {};

    query.bindValue(":id", QVariant(id));

    if (!query.exec()) return {};

    if (!query.first()) return {};

    auto json = query.value(0).toByteArray();
    auto jsonDocument = QJsonDocument::fromJson(json);

    if (!jsonDocument.isObject()) return {};

    return jsonDocument.object();
}


QJsonArray DatabaseController::viewClients() const
{


    QSqlQuery query(implementation->database);

    QString sqlStatement = "SELECT json FROM client ORDER BY lower(name)";

    if (!query.prepare(sqlStatement)) return {};


    if (!query.exec()) return {};

    QJsonArray returnValue;

    while ( query.next() ) {
        auto json = query.value(0).toByteArray();
        auto jsonDocument = QJsonDocument::fromJson(json);
        if (jsonDocument.isObject()) {
            returnValue.append(jsonDocument.object());
        }
    }

    return returnValue;
}



bool DatabaseController::updateRow(const QString& tableName, const QString& id, const QJsonObject& jsonObject) const
{
    if (tableName.isEmpty()) return false;
    if (id.isEmpty()) return false;
    if (jsonObject.isEmpty()) return false;

    QSqlQuery query(implementation->database);

    QString sqlStatement = "UPDATE " + tableName + " SET json=:json WHERE id=:id";

    if (!query.prepare(sqlStatement)) return false;

    query.bindValue(":id", QVariant(id));
    query.bindValue(":json", QVariant(QJsonDocument(jsonObject).toJson(QJsonDocument::Compact)));

    if(!query.exec()) return false;

    return query.numRowsAffected() > 0;
}

FirstPlane* DatabaseController::firstPlane() const
{
    return implementation->firstPlane;
}

SecondPlane* DatabaseController::secondPlane() const
{
    return implementation->secondPlane;
}

ThirdPlane* DatabaseController::thirdPlane() const
{
    return implementation->thirdPlane;
}


void DatabaseController::delSeat(const QString& plane,const QString& value)
{
    if(plane == "Boeing 767")
        implementation->firstPlane->removeSA(value);

    else if (plane == "Airbus A380")
        implementation->secondPlane->removeSA(value);

    else  implementation->thirdPlane->removeSA(value);

}


void DatabaseController::addSeat(const QString& plane,const QString& value)
{
    if(plane == "Boeing 767")
        implementation->firstPlane->addSA(value);

    else if (plane == "Airbus A380")
        implementation->secondPlane->addSA(value);

    else  implementation->thirdPlane->addSA(value);


}

}}
