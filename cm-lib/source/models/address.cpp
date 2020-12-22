#include "address.h"

using namespace cm::data;

namespace cm {
namespace models {

Address::Address(QObject* parent)
		: Entity(parent, "address")
{
    building = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "home country", "Home Country")));
    street = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "city", "City")));
    city = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "town", "Town")));
    postcode = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "address", "Address")));
}

Address::Address(QObject* parent, const QJsonObject& json)
		: Address(parent)
{
	update(json);
}


}}
