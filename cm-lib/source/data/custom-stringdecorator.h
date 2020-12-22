#ifndef CUSTOMSTRINGDECORATOR_H
#define CUSTOMSTRINGDECORATOR_H

#include <QObject>
#include <QScopedPointer>
#include <cm-lib_global.h>




namespace cm {

namespace data {

class Planes;


class CMLIBSHARED_EXPORT CustomStringDecorator : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString ui_value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY( QString ui_label READ label CONSTANT )


public:
    explicit CustomStringDecorator( Planes *parent = nullptr,const QString& label = "", const QString& value = "");
    ~CustomStringDecorator();


    CustomStringDecorator& setValue(const QString& value);
    const QString& value() const;
    const QString& label() const;

signals:
    void valueChanged();

public:
    class Implementation;
    QScopedPointer<Implementation> implementation;


};
}}
#endif // CUSTOMSTRINGDECORATOR_H
