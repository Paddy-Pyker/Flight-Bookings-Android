#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QtQml/QQmlListProperty>

#include <cm-lib_global.h>
#include <data/string-decorator.h>
#include <data/entity.h>
#include <data/entity-collection.h>
#include <models/address.h>
#include <models/appointment.h>
#include <models/contact.h>


namespace cm {
namespace models {

class CMLIBSHARED_EXPORT Client : public data::Entity
{
    Q_OBJECT
    Q_PROPERTY( bool ui_clearDecorators READ clearDecorators )
    Q_PROPERTY( cm::data::StringDecorator* ui_reference MEMBER reference CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_name MEMBER name CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_mobile MEMBER mobile CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_planeId MEMBER planeId CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_seatNumber MEMBER seatNumber CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_departure MEMBER departure CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_from MEMBER from CONSTANT )
    Q_PROPERTY( cm::data::StringDecorator* ui_to MEMBER to CONSTANT )
    Q_PROPERTY( QString ui_details READ details CONSTANT)

    Q_PROPERTY( cm::models::Address* ui_supplyAddress MEMBER supplyAddress CONSTANT )

    Q_PROPERTY( QQmlListProperty<cm::models::Appointment> ui_appointments READ ui_appointments NOTIFY appointmentsChanged )
    Q_PROPERTY( QQmlListProperty<cm::models::Contact> ui_contacts READ ui_contacts NOTIFY contactsChanged )

public:
    explicit Client(QObject* parent = nullptr);
    Client(QObject* parent, const QJsonObject& json);


    data::StringDecorator* reference{nullptr};
    data::StringDecorator* name{nullptr};
    data::StringDecorator* mobile{nullptr};
    data::StringDecorator* planeId{nullptr};
    data::StringDecorator* seatNumber{nullptr};
    data::StringDecorator* departure{nullptr};
    data::StringDecorator* from{nullptr};
    data::StringDecorator* to{nullptr};


    QString details() const;
    bool clearDecorators();
    bool validate() const;
    bool validateLocation() const;



    Address* supplyAddress{nullptr};
    data::EntityCollection<Appointment>* appointments{nullptr};
    data::EntityCollection<Contact>* contacts{nullptr};

    QQmlListProperty<cm::models::Appointment> ui_appointments();
    QQmlListProperty<cm::models::Contact> ui_contacts();




public slots:
    void addContact();
    void removeContact();



signals:
    void appointmentsChanged();
    void contactsChanged();
    void CanClickChanged();

};

}}

#endif
