import QtQuick 2.9
import QtQuick.Controls 2.5
import assets 1.0
import components 1.0
import QtQuick.Controls.Universal 2.3

Item {


        id: root
        property bool isCollapsed: true
        state: "collapsed"
        anchors.fill: parent



    Connections {
        target: masterController.ui_navigationController
        onGoCreateClientView: {contentFrame.replace("CreateClientView.qml"); masterController.ui_newClient.ui_clearDecorators}
        onGoDashboardView: contentFrame.replace("DashboardView.qml")
        onGoEditClientView: contentFrame.replace("EditClientView.qml", {selectedClient: client})
        onGoFindClientView: contentFrame.replace("FindClientView.qml")
        onGoRssView:contentFrame.replace("RssView.qml")
    }




    Header {
       id: header
       onTriggerButton: {
           if (root.isCollapsed)
               root.state="expanded"
           else root.state="collapsed"

           if(darker.status==Loader.Null)
           {
               darker.sourceComponent=abc
               darker.item.forceActiveFocus()
           }

           else
           {

               darker.setSource("")
               contentFrame.forceActiveFocus()
           }

           root.isCollapsed = !root.isCollapsed


       }

    }








    StackView {
        id: contentFrame

        anchors {
            top: header.bottom
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }


        initialItem:"DashboardView.qml"
        clip: true

        onCurrentItemChanged: currentItem.forceActiveFocus()


        replaceEnter: Transition {
                  PropertyAnimation {
                      property: "opacity"
                      from: 0
                      to:1
                      duration: 10
                  }
              }
              replaceExit: Transition {
                  PropertyAnimation {
                      property: "opacity"
                      from: 1
                      to:0
                      duration: 10
                  }
              }



    }







    NavigationBar {
        id: navigationBar
        anchors.top: header.bottom
        onHasClicked: header.triggerButton()


    }


    Loader{
        id:darker
        anchors{
            left: navigationBar.right
            top: header.bottom
            bottom: parent.bottom
            right: parent.right
        }
    }

Component{
    id:abc
    Rectangle{
        anchors.fill: parent
        color: "black"
        SequentialAnimation on opacity {  NumberAnimation {  from: 0; to: 0.6; duration: 200; }   }

        MouseArea{
            anchors.fill: parent
            onClicked: header.triggerButton()
        }

        Keys.onBackPressed: header.triggerButton()


    }

}
    transitions: [
        Transition {
            from: "collapsed"
            to: "expanded"
                PropertyAnimation{
                    target: navigationBar
                    property: "width"
                    from: Style.widthNavigationBarCollapsed
                    to: Style.heightNavigationBarExpanded
                    duration: 200


                }

        },
        Transition {
            from: "expanded"
            to: "collapsed"
                PropertyAnimation{
                    target: navigationBar
                    property: "width"
                    from: Style.heightNavigationBarExpanded
                    to:  Style.widthNavigationBarCollapsed
                    duration: 200


                }

        }
    ]

    }




