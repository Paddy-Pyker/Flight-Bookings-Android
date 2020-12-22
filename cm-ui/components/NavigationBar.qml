import QtQuick 2.9
import assets 1.0

Item {

    id:root
     signal hasClicked()
    width:  Style.widthNavigationBarCollapsed
    
    anchors {
        bottom: parent.bottom
        left: parent.left
    }



    Rectangle {


        anchors.fill: parent
        color: Style.colourNavigationBarBackground
        clip: true



        Column {
            width: parent.width

            NavigationButton{
                iconCharacter: "\uf015"
                description: "Dashboard"
                hoverColour: "#dc8a00"
                onNavigationButtonClicked:{
                    hasClicked()

                    masterController.ui_navigationController.goDashboardView();

                }
            }

            NavigationButton{
                iconCharacter: "\uf234"
                description: "Book A Flight"
                hoverColour: "#dccd00"
                onNavigationButtonClicked:{

                    hasClicked()
                    masterController.ui_navigationController.goCreateClientView();

                }
            }

            NavigationButton{
                iconCharacter: "\uf002"
                description: "Find Passenger"
                hoverColour: "#8aef63"
                onNavigationButtonClicked: {

                    hasClicked()
                    masterController.ui_navigationController.goFindClientView();

                }
            }
			
			NavigationButton {
                iconCharacter: "\uf09e"
                description: "Current Affairs"
                hoverColour: "#8acece"
                onNavigationButtonClicked: {

                     hasClicked()
                    masterController.ui_navigationController.goRssView();

                }
            }





        }

    }


}

