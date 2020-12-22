#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>
#include <QScopedPointer>

#include <controllers/i-database-controller.h>
#include <data/first-plane.h>
#include <data/second-plane.h>
#include <data/third-plane.h>

#include <cm-lib_global.h>

namespace cm {
namespace controllers {

class CMLIBSHARED_EXPORT DatabaseController : public IDatabaseController
{
    Q_OBJECT
    Q_PROPERTY( cm::data::FirstPlane* ui_firstPlane READ firstPlane CONSTANT )
    Q_PROPERTY( cm::data::SecondPlane* ui_secondPlane READ secondPlane CONSTANT )
    Q_PROPERTY( cm::data::ThirdPlane* ui_thirdPlane READ thirdPlane CONSTANT )


public:
    explicit DatabaseController(QObject* parent = nullptr);
    ~DatabaseController() override;

    bool createRow(const QString& tableName,const QString& fullname, const QString& id, const QJsonObject& jsonObject) const override;
    bool deleteRow(const QString& tableName, const QString& id) const override;
    QJsonArray find(const QString& tableName, const QString& searchText) const override;
    QJsonArray viewClients() const override;
    QJsonObject readRow(const QString& tableName, const QString& id) const override;
    bool updateRow(const QString& tableName, const QString& id, const QJsonObject& jsonObject) const override;


    data::FirstPlane * firstPlane() const;
    data::SecondPlane * secondPlane() const;
    data::ThirdPlane * thirdPlane() const;

    void delSeat(const QString& plane,const QString& value) override;
    void addSeat(const QString& plane,const QString& value) override;



private:
    class Implementation;
    QScopedPointer<Implementation> implementation;
};

}}

#endif
