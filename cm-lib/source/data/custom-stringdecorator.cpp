#include "custom-stringdecorator.h"

using namespace cm::data;


class CustomStringDecorator::Implementation
{

public:
    Implementation(CustomStringDecorator* _string,const QString& _label, const QString& _value)
        : string(_string)
        ,label(_label)
        ,value(_value)


    {

    }

    CustomStringDecorator* string{nullptr};
    QString label;
    QString value;
};


CustomStringDecorator::CustomStringDecorator(Planes *parent,const QString& label, const QString& value)
    : QObject((QObject*)parent)
{

    implementation.reset(new Implementation(this,label,value));


}

CustomStringDecorator& CustomStringDecorator:: setValue(const QString& value)
{
    if ( (value != implementation->value))
    {
        // ...Validation here if required...
        implementation->value = QString::number(value.toInt()) ;
//        emit valueChanged();
    }
    return *this;
}

const QString& CustomStringDecorator::value() const
{
    return implementation->value;
}

const QString& CustomStringDecorator::label() const
{
    return implementation->label;
}


CustomStringDecorator::~CustomStringDecorator()
{

}
