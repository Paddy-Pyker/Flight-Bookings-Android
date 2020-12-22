import QtQuick 2.9
import CM 1.0
import assets 1.0

Item {
    property alias iconCharacter: textIcon.text
    property alias description: textDescription.text
    property alias setColor: background.color

    signal formButtonClicked()
    width: Style.widthFormButton
    height: Style.heightFormButton

    Rectangle {
        id: background
        anchors.fill: parent
        color: Style.colourFormButtonBackground
        radius: Style.sizeFormButtonRadius

        Text {
            id: textIcon
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                margins: Style.heightFormButton / 4
            }
            font {
                family: Style.fontAwesome
                pixelSize: Style.pixelSizeFormButtonIcon
            }
            color: "black"//Style.colourFormButtonFont
            text: "\uf11a"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: textDescription
            anchors {
                left: textIcon.left
                bottom: parent.bottom
                top: parent.top
                right: parent.right
            }
            font.pixelSize: Style.pixelSizeFormButtonText
            color: "black"//Style.colourFormButtonFont
            text: "SET ME!!"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

//        MouseArea {
//            id:cursor
//            anchors.fill: parent
//            hoverEnabled: false
//            onEntered: background.state = "hover"
//            onExited: background.state = ""
//            onClicked: formButtonClicked()
//        }


        MouseArea {
            id:cursor
            anchors.fill: parent
            onPressed: background.state = "hover"
            onReleased: { background.state = "";formButtonClicked()}
        }

        states: [
            State {
                name: "hover"
                PropertyChanges {
                    target: background
                    color: Qt.darker(Style.colourFormButtonBackground)
                }
            }
        ]
    }
}
