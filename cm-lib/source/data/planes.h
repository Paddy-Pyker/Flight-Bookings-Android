#ifndef PLANES_H
#define PLANES_H

#include <QObject>
#include <QStandardPaths>
#include <cm-lib_global.h>

namespace cm {

namespace data {



class CMLIBSHARED_EXPORT Planes : public QObject
{
    Q_OBJECT
public:
    explicit Planes(QObject *parent = nullptr);
    virtual ~Planes();


};
}
}
#endif // PLANES_H
