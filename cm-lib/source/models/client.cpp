#include "client.h"
#include <QDebug>
#include <QUuid>



using namespace cm::data;

namespace cm {
namespace models {

Client::Client(QObject* parent)
    : Entity(parent, "client")
{

    reference = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "name", "Name")));
    name = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "age", "Age")));
    mobile = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "id", "ID","")));
    planeId = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "planeId", "Plane ID","")));
    seatNumber = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "seatNumber", "Seat Number","")));
    departure = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "departure", "Departure Date")));
    from = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "from", "From")));
    to = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "to", "To")));
    supplyAddress = static_cast<Address*>(addChild(new Address(this), "residence"));
    appointments = static_cast<EntityCollection<Appointment>*>(addChildCollection(new EntityCollection<Appointment>(this, "appointments")));
    contacts = static_cast<EntityCollection<Contact>*>(addChildCollection(new EntityCollection<Contact>(this, "contacts")));
    contacts->addEntity(new Contact(this));



    mobile->setValue(QUuid::createUuid().toString());
    setPrimaryKey(mobile);


}




Client::Client(QObject* parent, const QJsonObject& json)
    : Client(parent)
{
    update(json);

}

QQmlListProperty<Appointment> Client::ui_appointments()
{
    return QQmlListProperty<Appointment>(this, appointments->derivedEntities());
}

QQmlListProperty<Contact> Client::ui_contacts()
{
    return QQmlListProperty<Contact>(this, contacts->derivedEntities());
}




void Client::addContact()
{
    contacts->addEntity(new Contact(this));

    emit contactsChanged();
}

void Client::removeContact()

{

    contacts->removeEntity();
    emit contactsChanged();
}


QString Client::details() const
{
    return planeId->value() + " :: " + seatNumber->value() + "\n" + mobile->value() + "\n" + departure->value();
}


bool Client::clearDecorators()
{

   planeId->setValue("");
   seatNumber->setValue("");
   mobile->setValue(QUuid::createUuid().toString());
   setPrimaryKey(mobile);
   contacts->clear();
   contacts->addEntity(new Contact(this));

    qDebug()<<"clearing decorators";
    return true;

}

bool Client::validate() const
{

        return (planeId->value() == "" || seatNumber->value() == "" ) ? true : false ;
}

bool Client::validateLocation() const
{
    return (from->value() == to->value()) ? true : false;
}


}}
