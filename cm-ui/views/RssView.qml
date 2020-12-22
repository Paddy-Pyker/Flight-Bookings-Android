import QtQuick 2.9
import assets 1.0
import components 1.0

Item {

    Keys.onBackPressed: contentFrame.replace(Qt.resolvedUrl("qrc:/views/DashboardView.qml"))

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    function noNews()
    {
        name.visible = true
        errorImage.visible=true
        return 0
    }

    function yesNews()
    {
        name.visible = false
        errorImage.visible = false
        return masterController.ui_rssChannel.ui_items

    }

    ListView {
        id: itemsView
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: commandBar.top
            margins: Style.sizeHeaderMargin
        }

        clip: true

        model: masterController.ui_rssChannel ? yesNews() : noNews()

        delegate: RssItemDelegate {
            rssItem: modelData
        }
    }

    Text {
        id: name
        text: qsTr("No Internet")
        anchors.bottom: errorImage.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize:1.2* Style.fontSize
        z:1
        color: "lightblue"
        visible: false
    }

    Image {
        id: errorImage
        source: "/assets/error2"
        asynchronous: true
        opacity: 0.8
        width: Math.min(parent.height, parent.width)*0.5
        height: Style.heightForWidth(width, sourceSize)


        anchors.centerIn: parent

        visible: false

    }

    CommandBar {
        id: commandBar
        commandList: masterController.ui_commandController.ui_rssViewContextCommands
    }
}
