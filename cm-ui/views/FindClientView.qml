import QtQuick 2.9
import assets 1.0
import CM 1.0
import components 1.0

Item {

     Keys.onBackPressed: contentFrame.replace(Qt.resolvedUrl("qrc:/views/DashboardView.qml"))

    property ClientSearch clientSearch: masterController.ui_clientSearch
    property Command command: masterController.ui_commandController.ui_findClientViewContextCommands[1]

    Rectangle {
        anchors.fill: parent
        color: Style.colourBackground

        Panel {
            id: searchPanel
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: Style.sizeScreenMargin
            }
            headerText: "Find Passengers"
            contentComponent:
                StringEditorSingleLine {
                    stringDecorator: clientSearch.ui_searchText
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    Keys.onPressed: {
                        if ( event.key === Qt.Key_Enter  || event.key === Qt.Key_Return  )
                            command.executed();
                }
        }
        }

        ListView {
            id: itemsView
            anchors {
                top: searchPanel.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: Style.sizeScreenMargin
            }
            clip: true
            model: clientSearch.ui_searchResults
            delegate:
                SearchResultDelegate {
                    client: modelData
                }
        }
    }

    CommandBar {
        commandList: masterController.ui_commandController.ui_findClientViewContextCommands
    }
}
