import QtQuick 2.9
import assets 1.0

Item {

    height: parent.height

    property alias description:textDescription.text
    signal planeNavbuttonClicked()

    Rectangle{
        id:background
        anchors.fill:parent


        Text {
            id: textDescription
           anchors.fill: parent
            text: qsTr("text")
            color: "Black"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize:0.35 * Style.fontSize
            clip: true

        }

        states: [
            State {
                name: "hover"
                PropertyChanges {
                    target: background
                    color: Qt.darker("whitesmoke")
                }

                   }
        ]

        //        MouseArea {                                 *SHOULD BE ENABLED FOR PC*
        //            anchors.fill: parent
        //            cursorShape: Qt.PointingHandCursor
        //            hoverEnabled: true
        //            onEntered: background.state = "hover"
        //            onExited: background.state = ""
        //            onClicked: {
        //                planeNavbuttonClicked();
        //            }
        //        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: false
            onPressed: background.state = "hover"
            onReleased:{
                 background.state = ""
                planeNavbuttonClicked()

            }
        }



    }

}
