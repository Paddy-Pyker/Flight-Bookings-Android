import QtQuick 2.9
import CM 1.0
import assets 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3



Item {


    property StringDecorator stringDecorator
    height:  Style.heightDataControls

    Flow {
        anchors.fill: parent

        Rectangle {
            id:leaveder
            width: Style.widthDataControls
            height: Style.heightDataControls
            color: "white"
            radius: 0.0082 * Style.heightWindow


            Text {
                id: textLabel
                anchors {
                    fill: parent
                    margins: Style.heightDataControls / 4
                }
                text: stringDecorator.ui_label
                color: Style.colourDataControlsFont
                font.pixelSize:Style.pixelSizeDataControls
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
                text: stringDecorator.ui_value
                Universal.accent: Style.colourDashboardBackground
                font.pixelSize: Style.pixelSizeDataControls
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                readOnly: true


            }


        }




    }


}

