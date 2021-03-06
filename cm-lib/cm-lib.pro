QT += sql network xml
QT -= gui

#TARGET = fm-lib
TEMPLATE = lib

CONFIG += c++14

DEFINES += CMLIB_LIBRARY


INCLUDEPATH += source

SOURCES += source/models/client.cpp \
    source/controllers/master-controller.cpp \
    source/data/custom-stringdecorator.cpp \
    source/data/second-plane.cpp \
    source/data/third-plane.cpp \
    source/framework/command.cpp \
    source/controllers/command-controller.cpp \
    source/data/data-decorator.cpp \
    source/data/string-decorator.cpp \
    source/data/int-decorator.cpp \
    source/data/datetime-decorator.cpp \
    source/data/enumerator-decorator.cpp \
    source/data/entity.cpp \
    source/data/first-plane.cpp \
    source/data/planes.cpp \
    source/models/address.cpp \
    source/models/appointment.cpp \
    source/models/contact.cpp \
    source/controllers/database-controller.cpp \
    source/models/client-search.cpp \
    source/networking/network-access-manager.cpp \
    source/networking/web-request.cpp \
    source/utilities/xml-helper.cpp \
    source/rss/rss-channel.cpp \
    source/rss/rss-image.cpp \
    source/rss/rss-item.cpp \
    source/framework/object-factory.cpp \
    source/data/dropdown-value.cpp \
    source/data/dropdown.cpp

HEADERS += source/cm-lib_global.h \
    source/data/custom-stringdecorator.h \
    source/data/first-plane.h \
    source/data/planes.h \
    source/data/second-plane.h \
    source/data/third-plane.h \
    source/models/client.h \
    source/controllers/master-controller.h \
    source/controllers/navigation-controller.h \
    source/framework/command.h \
    source/controllers/command-controller.h \
    source/data/data-decorator.h \
    source/data/string-decorator.h \
    source/data/int-decorator.h \
    source/data/datetime-decorator.h \
    source/data/enumerator-decorator.h \
    source/data/entity.h \
    source/data/entity-collection.h \
    source/models/address.h \
    source/models/appointment.h \
    source/models/contact.h \
    source/controllers/i-database-controller.h \
    source/controllers/database-controller.h \
    source/models/client-search.h \
    source/networking/i-network-access-manager.h \
    source/networking/network-access-manager.h \
    source/networking/i-web-request.h \
    source/networking/web-request.h \
    source/utilities/xml-helper.h \
    source/rss/rss-channel.h \
    source/rss/rss-image.h \
    source/rss/rss-item.h \
    source/framework/i-object-factory.h \
    source/controllers/i-command-controller.h \
    source/controllers/i-navigation-controller.h \
    source/framework/object-factory.h \
    source/data/dropdown-value.h \
    source/data/dropdown.h



#DESTDIR = $$PWD/../binaries/

