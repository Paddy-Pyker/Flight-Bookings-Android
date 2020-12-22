#include "contact.h"

using namespace cm::data;

namespace cm {
namespace models {

std::map<int, QString> Contact::contactTypeMapper = std::map<int, QString> {
	{ Contact::eContactType::Unknown, "" }
    , { Contact::eContactType::Bank, "Bank" }
    , { Contact::eContactType::Paypal, "Paypal" }
    , { Contact::eContactType::Momo, "MTN Mobile Money" }
};

Contact::Contact(QObject* parent)
	: Entity(parent, "contact")
{
    contactType = static_cast<EnumeratorDecorator*>(addDataItem(new EnumeratorDecorator(this, "paymentType", "Payment Type", 0, contactTypeMapper)));
    address = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "details", "Payment Details")));
	contactTypeDropDown = new DropDown(this, contactTypeMapper);
}

Contact::Contact(QObject* parent, const QJsonObject& json)
	: Contact(parent)
{
	update(json);
}

}}
