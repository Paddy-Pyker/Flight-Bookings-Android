import QtQuick 2.9
import CM 1.0
import assets 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3

Item {
    property alias noEdit: textValue.readOnly
    property StringDecorator stringDecorator

    height:  Style.heightDataControls

    Flow {
        anchors.fill: parent

        Rectangle {
            width: Style.widthDataControls
            height: Style.heightDataControls
            color: Style.colourPanelBackground

            Text {
                id: textLabel
                anchors {
                    fill: parent
                    margins: Style.heightDataControls / 4
                }
                text: stringDecorator.ui_label
                color: Style.colourDataControlsFont
                font.pixelSize: Style.pixelSizeDataControls
                verticalAlignment: Qt.AlignVCenter
            }
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

                Universal.accent: Style.colourDashboardBackground
                font.pixelSize: Style.pixelSizeDataControls
                verticalAlignment: Qt.AlignVCenter
                text: stringDecorator.ui_value


            }


        }

        Binding {
            target: stringDecorator
            property: "ui_value"
            value: textValue.text
        }
    }
}
