#ifndef FIRSTPLANE_H
#define FIRSTPLANE_H


#include <QObject>
#include <QScopedPointer>
#include <cm-lib_global.h>
#include <data/planes.h>
#include <data/custom-stringdecorator.h>
#include <QList>
#include <QtQml/QQmlListProperty>
#include <QFile>
#include <QDataStream>


namespace cm {

namespace data {


class CMLIBSHARED_EXPORT FirstPlane : public Planes
{
    Q_OBJECT
    Q_PROPERTY( bool ui_checkSA READ checkSA )
    Q_PROPERTY( cm::data::CustomStringDecorator* ui_description MEMBER description CONSTANT )
    Q_PROPERTY( cm::data::CustomStringDecorator* ui_selectedSeat MEMBER selectedSeat CONSTANT )
    Q_PROPERTY( QStringList ui_AVAILABLE READ AVAILABLE CONSTANT )
    Q_PROPERTY( QStringList  ui_RESERVED READ RESERVED CONSTANT )
    Q_PROPERTY( QString  ui_firstplaneNumber READ firstplaneNumber CONSTANT )




public:
    explicit FirstPlane(QObject *parent = nullptr , Planes* _parent = nullptr);
    ~FirstPlane();

    CustomStringDecorator* description{nullptr};
    CustomStringDecorator* selectedSeat{nullptr};

    QStringList AVAILABLE();
    QStringList RESERVED();

    bool checkSA();

    QString firstplaneNumber();

    void removeSA(const QString& value);
    void addSA(const QString& value);


signals:
    void validate(); /// JUST closes the plane page


private:
    QStringList available = { "1", "2", "3","4","5","6","7","8","9","10","11","12","13","14",
                              "15","16","17","18","19","20","21","22","23","24","25"};
    QStringList reserved;








};
}}

#endif // FIRSTPLANE_H
