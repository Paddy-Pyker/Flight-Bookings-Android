import QtQuick 2.9
import QtQuick.Controls 2.5
import assets 1.0
import components 1.0
import QtQuick.Controls.Universal 2.3



Rectangle{

    signal triggerButton()
    property alias target: naviIcon

    id:header
    height: 1.6 * Style.fontSize2//0.09 * Style.heightWindow
    width: parent.width
    anchors{
        top: parent.top
        left: parent.lefts
        right: parent.right
    }
    
    color: Qt.darker(Style.colourDashboardBackground)
    
    Rectangle{
        id:naviIcon
        property bool isCollapsed: true
        state: "collapsed"
        anchors{
            top: parent.top
            left: parent.left
            bottom: parent.bottom

        }
        width: 1.26 * parent.height
        color: Qt.darker(Style.colourDashboardBackground)
        Text {
            
            
            anchors.fill: parent
            color: "black"
            font {
                family: Style.fontAwesome
                pixelSize: 1.4 * Style.fontSize2
            }
            
            text: "\uf0c9"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            
        }


        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (naviIcon.isCollapsed)
                    naviIcon.state="expanded"
                else naviIcon.state="collapsed"

                naviIcon.isCollapsed = !naviIcon.isCollapsed
                triggerButton()
            }
    }



        transitions: [
            Transition {
                from: "collapsed"
                to: "expanded"

                RotationAnimator {
                    target: naviIcon
                    from: 0
                    to:180
                    duration: 200
                    direction: RotationAnimator.Counterclockwise




                }
            },
            Transition {
                from: "expanded"
                to: "collapsed"

                RotationAnimator{
                    target: naviIcon
                    from: 180
                    to:0
                    duration: 200
                    direction: RotationAnimator.Clockwise




                }
            }
        ]



    }
    
    Rectangle{
        id:title
        anchors{
            top: parent.top
            left: naviIcon.right
            right: parent.right
            bottom: parent.bottom
        }
        Text {
            
            text: qsTr("Flight Bookings")
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize:  Style.fontSize2
            font.bold: true
        }
        color: Qt.darker(Style.colourDashboardBackground)
        
    }







}

