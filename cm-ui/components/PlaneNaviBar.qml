import QtQuick 2.9
import QtQuick.Controls 2.5
import assets 1.0

Item {

    property alias width1:b1.width
    property alias width2:b2.width
    property alias width3:b3.width
    property alias ts:separator.implicitWidth


    signal firstButtonClicked();
    signal secondButtonClicked();
    signal thirdButtonClicked();

    id:root
    anchors{
        top: parent.top
        left: parent.left
        right: parent.right

    }

    height: 0.08 * Style.heightWindow

Rectangle{

    anchors.fill: parent

    clip: true



    Row{

        PlaneNaviButton{
            id:b1
            description: "Boeing 767"
            onPlaneNavbuttonClicked: firstButtonClicked()
        }

        ToolSeparator{}



        PlaneNaviButton{
            id:b2
            description: "Airbus A380"
            onPlaneNavbuttonClicked: secondButtonClicked()
        }

        ToolSeparator{
        id:separator
        }

        PlaneNaviButton{
            id:b3
            description: "Mil Mi-8"
            onPlaneNavbuttonClicked: thirdButtonClicked()
        }
    }


}

}
