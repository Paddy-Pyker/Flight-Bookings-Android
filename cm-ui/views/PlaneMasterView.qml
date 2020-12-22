import QtQuick 2.9
import QtQuick.Controls 2.5
import assets 1.0
import components 1.0

Item {


          StackView {
              id: contentFrame
              anchors.top:navigation.bottom
              anchors.topMargin: 0.048 * Style.heightWindow
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.bottom: parent.bottom
              initialItem:  Qt.resolvedUrl("qrc:/views/Plane1View.qml");
              clip: true



              onCurrentItemChanged: {
                      currentItem.forceActiveFocus()
              }


              replaceEnter: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 0
                            to:1
                            duration: 400
                        }
                    }
                    replaceExit: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 1
                            to:0
                            duration: 400
                        }
                    }


      }


          PlaneNaviBar{
              id:navigation
              width1: 1/3 * (contentFrame.width - 2 * ts)
              width2: width1
              width3: width2
              onFirstButtonClicked: contentFrame.replace(Qt.resolvedUrl("qrc:/views/Plane1View.qml"))
              onSecondButtonClicked: contentFrame.replace(Qt.resolvedUrl("qrc:/views/Plane2View.qml"))
              onThirdButtonClicked: contentFrame.replace(Qt.resolvedUrl("qrc:/views/Plane3View.qml"))

          }



}
