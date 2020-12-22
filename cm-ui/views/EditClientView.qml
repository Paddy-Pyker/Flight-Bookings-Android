import QtQuick 2.9
import QtQuick.Controls 2.5
import CM 1.0
import assets 1.0
import components 1.0



Item {

    Keys.onBackPressed: contentFrame.replace(Qt.resolvedUrl("qrc:/views/FindClientView.qml"))


    property Client selectedClient

    Component.onCompleted: masterController.ui_commandController.setSelectedClient(selectedClient)


    Rectangle {
        anchors.fill: parent
        color: Style.colourBackground
    }

    EditorViewContent {
        id: scrollView
    }

    CommandBar {
        id: commandBar
        commandList: masterController.ui_commandController.ui_editClientViewContextCommands
    }





}
