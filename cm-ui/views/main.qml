import QtQuick 2.9
import QtQuick.Window 2.2
import assets 1.0


Window {
    id: wroot
    visible: true

    width: 383
    height:  616
    title: qsTr("Flight Bookings")



    Component.onCompleted: {
        Style.widthWindow = Qt.binding(function() {return width})
        Style.heightWindow = Qt.binding(function() {return height})
        console.log(width + " , " + height )
    }

    Loader {
        id: splashLoader
        anchors.fill: parent
        source: "SplashView.qml"
        asynchronous: false
        visible: true

        onStatusChanged: {
            if (status === Loader.Ready) {
                appLoader.setSource("MasterView.qml");


            }

        }
    }

    Connections {
        target: splashLoader.item
        onReadyToGo: {
            appLoader.visible = true
            splashLoader.visible = false
            splashLoader.setSource("")

        }
    }

    Loader {
        id: appLoader
        anchors.fill: parent
        visible: false
        asynchronous: true
        onStatusChanged: {
            if (status === Loader.Ready)
                splashLoader.item.appReady()

        }
    }




}



