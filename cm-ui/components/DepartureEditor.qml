import QtQuick 2.9
import CM 1.0
import assets 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3



Item {

    id:roott
    property StringDecorator stringDecorator
    signal departureButtonClicked()
    property alias value:textValue.text

    height:  Style.heightDataControls

    Flow {
        anchors.fill: parent

        Rectangle {
            id:leaveder
            width: Style.widthDataControls * 0.5
            height: Style.heightDataControls
            color: Style.colourFormButtonBackground
            radius: 0.0082 * Style.heightWindow


            Text {
                id: textLabel
                anchors {
                    fill: parent
                    margins: Style.heightDataControls / 4
                }
                text: stringDecorator.ui_label
                color: Style.colourDataControlsFont
                font.pixelSize: 0.5 * Style.pixelSizeDataControls
                font.bold: true
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: leaveder.state = "hover"
                onExited: leaveder.state = ""
                onClicked: departureButtonClicked()
            }

            states: [
                State {
                    name: "hover"
                    PropertyChanges {
                        target: leaveder
                        color: Qt.darker(Style.colourFormButtonBackground)
                    }
                }
            ]

        }


        Rectangle {
            id:emptyBox
            width: Style.widthDataControls * 0.5
            height: Style.heightDataControls
            color: "white"
        }



        Rectangle {
            id: background
            width: Style.widthDataControls
            height: Style.heightDataControls
            color: Style.colourDataControlsBackground

            TextField {
                id: textValue
                anchors {
                    fill: parent
                }
                text: stringDecorator.ui_value
                Universal.accent: Style.colourDashboardBackground
                font.pixelSize: Style.pixelSizeDataControls
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                readOnly: true


            }


        }

        Binding {
            target: stringDecorator
            property: "ui_value"
            value: textValue.text
        }


    }


}

