import QtQuick 2.9
import assets 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3


Item {

    id: root
    anchors.fill: parent

    property bool appIsReady: false
    property bool splashIsReady: false

    property bool ready: appIsReady && splashIsReady
    onReadyChanged: if (ready) readyToGo();

    signal readyToGo()

    function appReady()
    {
        appIsReady = true
    }




    Rectangle{

        id:splash
        anchors.fill: parent
        color: "black"//"#413fff"





        ProgressBar{
            id:busy
            implicitWidth: 0.27 * Style.widthWindow
            indeterminate: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0.13 * Style.heightWindow
            Universal.accent: "light yellow"

        }




        Text {
            id: name
            font.family: Style.fontAwesome
            text: qsTr("\uf072")
            anchors.centerIn: parent

            color: "white"
            font.pixelSize: 1.7 * Style.fontSize2

            ColorAnimation on color { to: "lightyellow"; duration: 3000 }




        }





    }

    Timer {
        id: splashTimer
        interval: 3000
        onTriggered: splashIsReady = true

    }



    Component.onCompleted: {

        splashTimer.start()
    }
}

