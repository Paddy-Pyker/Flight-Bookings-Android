QT += qml quick xml quickcontrols2 sql


TEMPLATE = app


CONFIG += c++14


INCLUDEPATH += source \
    ../cm-lib/source


DEPENDPATH += source \
    ../cm-lib/source


SOURCES += source/main.cpp



RESOURCES += views.qrc \
    assets.qrc \
    components.qrc



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD



unix: LIBS += -L$$OUT_PWD/../cm-lib/ -lcm-lib

else:win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../cm-lib/release/ -lcm-lib

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml


contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android


    ANDROID_EXTRA_LIBS = \
        $$[QT_INSTALL_LIBS]/libQt5Sql.so
}




