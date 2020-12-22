import QtQuick 2.9
import QtQuick.Controls 1.5 as Old
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.5
import CM 1.0
import assets 1.0
import components 1.0



Item {

    Keys.onBackPressed: contentFrame.replace(Qt.resolvedUrl("qrc:/views/DashboardView.qml"))


    id:root
    property Client newClient: masterController.ui_newClient
    property string stringg



    Rectangle {
        id:shadow
        anchors.fill: parent
        z:0.5
        visible: false
    }




    Rectangle {
        anchors.fill: parent
        color: Style.colourBackground
    }




    ScrollView {
        id: scrollView
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: commandBar. top
            margins: Style.sizeScreenMargin
        }
        clip: true


        Column {
            id:column
            spacing: Style.sizeScreenMargin
            width: scrollView.width

            Panel {
                headerText: "Passenger Details"
                contentComponent:
                    Column {
                    spacing: Style.sizeControlSpacing
                    StringEditorSingleLine {
                        stringDecorator: newClient.ui_reference
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                    }
                    StringEditorSingleLine {
                        stringDecorator: newClient.ui_name
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                    }


                }
            }
            AddressEditor {
                address: newClient.ui_supplyAddress
                headerText: "Residence"
            }


            Panel {
                id:panel
                headerText: "Flight Details"
                contentComponent:
                    Column {
                    spacing: Style.sizeControlSpacing

                    PlaneStringEditorSingleLine{
                        stringDecorator: newClient.ui_planeId
                        anchors{
                            left: parent.left
                            right: parent.right
                        }

                    }

                    PlaneStringEditorSingleLine{
                        stringDecorator: newClient.ui_seatNumber
                        anchors{
                            left: parent.left
                            right: parent.right
                        }
                    }

                    DepartureEditor{
                        id:departure
                        stringDecorator: newClient.ui_departure
                        value: stringg
                        anchors{
                            left: parent.left
                            right: parent.right
                        }
                        onDepartureButtonClicked:{

                            calendar.sourceComponent = containCalendar
                            dark.visible=true
                            doo.enabled=true


                        }



                    }



                    LocationEditor{
                        stringDecorator: newClient.ui_from
                        anchors{
                            left: parent.left
                            right: parent.right
                        }

                    }

                    LocationEditor{
                        stringDecorator: newClient.ui_to
                        anchors{
                            left: parent.left
                            right: parent.right
                        }

                    }






                }
            }

            PaymentEditor {
                width: scrollView.width
                client: newClient
                headerText: "Payment Mode"
            }
        }
    }



    CommandBar {
        id: commandBar
        commandList: masterController.ui_commandController.ui_createClientViewContextCommands
    }

    Rectangle{
        id: dark
        anchors.fill: parent
        color: "black"
        opacity: 0.7
        visible: false

    }


    Loader{
        id:calendar
        anchors.centerIn: root
        z:1
        height: parent.height * 0.6
        width: parent.width * 0.6
    }

    Component{
        id:containCalendar



        Old.Calendar{
            minimumDate: new Date();
            frameVisible: false

            onClicked:{
                root.stringg= root.date(selectedDate);
                dark.visible=false
                doo.enabled=false
                calendar.setSource("")
            }

            style: CalendarStyle{
                gridVisible: false

                dayDelegate:Rectangle{

                    Label {
                        text: styleData.date.getDate()
                        font.pixelSize: 15
                        anchors.centerIn: parent
                        color: styleData.valid ? Style.colourDashboardBackground : "grey"
                    }

                    Rectangle {
                        radius: 5
                        width: parent.width
                        height: 1
                        color: "#111"
                        anchors.bottom: parent.bottom
                    }

                    Rectangle {
                        radius: 5
                        width: 1
                        color: "#111"
                        height: parent.height
                        anchors.right: parent.right
                    }
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "white" : "aliceblue");
                        }
                    }


                }

            }


        }


    }

    function date(selected)
    {
        var today = selected
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0');
        var yyyy = today.getFullYear();

        today = dd + '/' + mm + '/' + yyyy;

        return today;
    }

    Connections{
        target: masterController.ui_commandController
        onViewPlanesExecuted:{

            appLoader.setSource(Qt.resolvedUrl("qrc:/views/PlaneMasterView.qml"));
            appLoader.z=1
            doo.enabled=true
            shadow.visible=true


        }

    }

    Connections{
        target: masterController.ui_databaseController.ui_firstPlane
        onValidate : {

            appLoader.setSource("");
            doo.enabled= false
            shadow.visible=false

        }

    }

    Connections{
        target: masterController.ui_databaseController.ui_secondPlane
        onValidate : {

            appLoader.setSource("");
            doo.enabled= false
            shadow.visible=false

        }

    }

    Connections{
        target: masterController.ui_databaseController.ui_thirdPlane
        onValidate : {

            appLoader.setSource("");
            doo.enabled= false
            shadow.visible=false


        }

    }

    Loader {
        id: appLoader
        anchors.fill: parent
        visible: true
        asynchronous: true

    }

    MouseArea {
        id:doo
        anchors.fill: parent
        enabled: false


    }

    Connections{
        target: masterController.ui_commandController
        onFillAll:{

            validator.setSource("")
            validator.sourceComponent = dialogbox
            dialogTimer.restart()
        }
    }


    Connections{
        target: masterController.ui_commandController
        onCheckLocation: {

            checkLocation.setSource("")
            checkLocation.sourceComponent = checkLoceyshin
            dialogTimer.restart()

        }
    }


    Loader{
        id:validator
        anchors.bottom: commandBar.top
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

    }


    Loader{
        id:checkLocation
        anchors.bottom: commandBar.top
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

    }

    Component{
        id:dialogbox

        Text {
            id: name
            text: qsTr("Choose Plane")
            font.pixelSize: 0.6 * Style.fontSize2//18
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            color: Style.colourDashboardBackground
            SequentialAnimation on opacity {  NumberAnimation {  to: 0; duration: 2000; }   }
        }
    }


    Component{
        id:checkLoceyshin

        Text {
            id: name
            text: qsTr("check where you are going to")
            font.pixelSize: 0.5 * Style.fontSize2//16
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            color: Style.colourDashboardBackground
            SequentialAnimation on opacity {  NumberAnimation {  to: 0; duration: 2000; }   }
        }
    }


    Timer {
        id: dialogTimer
        interval: 2000
        onTriggered: {
            validator.setSource("")
            checkLocation.setSource("")

        }
    }




}
