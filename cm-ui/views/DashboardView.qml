import QtQuick 2.9
import assets 1.0
import QtQuick.Controls 1.4
import CM 1.0

Item {

    Keys.onBackPressed: {
        exit.sourceComponent=closer
        exit.item.forceActiveFocus()
        exitTimer.start()

    }



    Rectangle {
        anchors.fill: parent
        color: "lightyellow"

        Text {
            id: welcome
            text: qsTr("Welcome To Flight Ghana")
            font.pixelSize:  0.7 * Style.fontSize
            color: "black"
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 0.5 * Style.fontSize2 * 2
        }


        Image {
            id: wallpaper
            source: "/assets/wallpaper"
            anchors.top: welcome.bottom
            anchors.horizontalCenter: welcome.horizontalCenter
            width: Math.min(parent.height, parent.width)*0.6
            height: Style.heightForWidth(width, sourceSize)
            antialiasing: true

        }

        Text {
            id:motto
            text: qsTr("Affordable Services You Can Trust!")
            anchors.top: wallpaper.bottom
            anchors.horizontalCenter: wallpaper.horizontalCenter
            font.bold: true
            font.pixelSize: 0.7 * Style.fontSize2
        }


        Rectangle{
            anchors{

                left: parent.left
                right: parent.right
                bottom: parent.bottom

                leftMargin: 0.05 * Style.widthWindow
                rightMargin: 0.05 * Style.widthWindow
                bottomMargin: 0.05 * Style.widthWindow
            }
            radius: 0.4 * Style.fontSize2
            border.color: "black"
            border.width: 0.15 * Style.fontSize2
            height: 0.5 * parent.height


            color: "lightyellow"


            Loader{
                id:exit
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0.4 * Style.fontSize2
                anchors.horizontalCenter: parent.horizontalCenter

            }

            Component{
                id:closer


                Text {
                    text: qsTr("press again to exit")
                    color: Style.colourDashboardBackground
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 0.5 * Style.fontSize2
                    font.bold : true
                    Keys.onBackPressed: Qt.quit()
                    SequentialAnimation on opacity {  NumberAnimation {  to: 0; duration: 2000; }}
                }
            }


            Timer {
                id: exitTimer
                interval: 2000
                onTriggered: exit.setSource("")
            }




            Text {
                id: aircrafts
                text: qsTr("Planes")
                font.pixelSize: 0.5 * Style.fontSize2
                font.bold: true
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 0.62 * Style.fontSize2
                anchors.topMargin: 0.5 * Style.fontSize2
                color: "black"
            }


            Text {
                id: plane1
                text: qsTr("Boeing 767")
                font.pixelSize: 0.45 * Style.fontSize2
                color: "black"
                anchors{
                    top: aircrafts.bottom
                    horizontalCenter: aircrafts.horizontalCenter
                    topMargin: 0.5 * Style.fontSize2 * 2

                }

            }


            Text {
                id: plane2
                text: qsTr("Airbus A380")
                font.pixelSize: 0.45 * Style.fontSize2
                color: "black"
                anchors{
                    top: plane1.bottom
                    horizontalCenter: aircrafts.horizontalCenter
                    topMargin: 0.5 * Style.fontSize2 * 2

                }

            }


            Text {
                id: plane3
                text: qsTr("Mil Mi-8")
                font.pixelSize: 0.45 * Style.fontSize2
                color: "black"
                anchors{
                    top: plane2.bottom
                    horizontalCenter: aircrafts.horizontalCenter
                    topMargin: 0.5 * Style.fontSize2 * 2

                }

            }



            Text {
                id:numbers
                text: qsTr("Passengers On Board")
                font.pixelSize: 0.5 * Style.fontSize2
                font.bold: true
                color: "black"
                anchors{
                    top: parent.top
                    right: parent.right
                    rightMargin: 0.6 * Style.fontSize2
                    topMargin: 0.5 * Style.fontSize2

                }
            }

            Text {
                id: value1
                text: masterController.ui_databaseController.ui_firstPlane.ui_firstplaneNumber + "  out of 25"
                font.pixelSize: 0.45 * Style.fontSize2
                anchors{
                    top: numbers.bottom
                    topMargin: 0.5 * Style.fontSize2 * 2
                    horizontalCenter: numbers.horizontalCenter
                }

            }



            Text {
                id: value2
                text: masterController.ui_databaseController.ui_secondPlane.ui_secondplaneNumber + "  out of 30"
                font.pixelSize: 0.45 * Style.fontSize2
                anchors{
                    top: value1.bottom
                    topMargin: 0.5 * Style.fontSize2 * 2
                    horizontalCenter: numbers.horizontalCenter
                }

            }



            Text {
                id: value3
                text: masterController.ui_databaseController.ui_thirdPlane.ui_thirdplaneNumber + "  out of 10"
                font.pixelSize: 0.45 * Style.fontSize2
                anchors{
                    top: value2.bottom
                    topMargin: 0.5 * Style.fontSize2 * 2
                    horizontalCenter: numbers.horizontalCenter
                }

            }
        }







    }
}
