import QtQuick 2.9
import assets 1.0
import QtQuick.Controls 2.5
import CM 1.0
import QtQuick.Controls.Universal 2.3

Item {


    Keys.onBackPressed: {
        masterController.ui_newClient.ui_clearDecorators
        plane.validate()
    }


    property FirstPlane plane: masterController.ui_databaseController.ui_firstPlane
    property CustomStringDecorator string1: plane.ui_description
    property CustomStringDecorator string2: plane.ui_selectedSeat

    property Client client: masterController.ui_newClient
    property StringDecorator planeName:client.ui_planeId     /// return values to CreateClientView
    property StringDecorator seatNumber:client.ui_seatNumber  /// return values to CreateClientView





    function valu()
    {
        return (textValue.text != 0) ?  parseInt(textValue.text , 10) : ""
    }

    Rectangle {
        anchors.fill: parent




        Rectangle{

            id:basegroup

            //           border.color: "black"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: reserved.left
            anchors.margins: 0.0082 * Style.heightWindow
            anchors.bottomMargin: 0.162 * Style.heightWindow//100
            height: 0.162 * Style.heightWindow//100

            clip: true



            Rectangle {
                id:rec1
                width: 0.34 * Style.widthWindow//130
                height: Style.heightDataControls
                //s color: "lightyellow"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 0.0082 * Style.heightWindow
                anchors.leftMargin: 0.0082 * Style.heightWindow

                Text {
                    id: textLabel
                    anchors {
                        fill: parent
                        margins: Style.heightDataControls / 4
                    }
                    text: string2.ui_label + " :"
                    color: Style.colourDataControlsFont
                    font.pixelSize: 0.35 * Style.fontSize
                    verticalAlignment: Qt.AlignVCenter

                }
            }

            Rectangle {
                id: rec2
                width: 0.14 * Style.widthWindow// 70
                height: Style.heightDataControls
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 0.052 * Style.widthWindow//30
                anchors.topMargin: 0.0082 * Style.heightWindow

                clip: true





                TextField {
                    id: textValue
                    anchors {
                        fill: parent

                    }


                    Universal.accent: Style.colourDashboardBackground

                    font.pixelSize: 0.35 * Style.fontSize
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    validator: IntValidator{
                        bottom: 1; top: 25;
                    }



                    Keys.onPressed: {
                        if ( event.key === Qt.Key_Enter  || event.key === Qt.Key_Return  )
                            b.clicked()
                    }




                }

            }

            Binding {
                target: string2
                property: "ui_value"
                value: textValue.text
            }


            Binding {
                target: seatNumber
                property: "ui_value"
                value: valu() //textValue.text
            }







            Button{
                id:b
                anchors.bottom: parent.bottom
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.bottomMargin: 0.0082 * Style.heightWindow
                text: "OK"
                onClicked:{

                    if (masterController.ui_databaseController.ui_firstPlane.ui_checkSA)
                    {
                        planeName.ui_value="Boeing 767"
                        plane.validate();  //closes the plane page
                    }

                    else {
                        masterController.ui_newClient.ui_clearDecorators
                        dialo.setSource("")
                        dialo.sourceComponent = dialogbox ;
                        dialogTimer.start();
                    }


                }


            }

            function listSort(originalModel)
            {
                var tempModel = []

                for(var i= 0; i<originalModel.length;i++)
                {
                    tempModel[i] = parseInt(originalModel[i])
                }

                engine(tempModel,tempModel.length)

                return tempModel


            }


            function engine(array,numElement)
            {
                var i,j,temp,swapped = 0;

                for (i = 0; i < numElement - 1; i ++)
                {
                    swapped = 0;

                    for(j = 0; j < numElement - i - 1; j++)
                    {
                        if (array[j] > array[j+1])
                        {
                            temp = array[j]
                            array[j] = array[j+1]
                            array[j+1] = temp
                            swapped = 1
                        }
                    }

                    if(!swapped)
                        break;
                }

            }

        }








        Image {
            id: plane1
            source: "/assets/plane1"
            anchors.left: parent.left
            anchors.leftMargin: 0.026 * Style.widthWindow
            anchors.top: parent.top
            width: Math.min(parent.height, parent.width)*0.5
            height: Style.heightForWidth(width, sourceSize)
            antialiasing: true
        }




        Rectangle{
            id:reserved
            anchors{
                left: plane1.right
                right: parent.right
                bottom: parent.bottom
                top: available.bottom
                margins: 0.0082 * Style.heightWindow

            }
            color: parent.color

            Text {
                id: header1
                width: parent.width
                height: 0.024 * Style.heightWindow
                text: qsTr("Reserved Seats")
                font.pixelSize: 0.35 * Style.fontSize//15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold:true


            }
            GridView{
                id:fi

                anchors{
                    top:header1.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: 0.0082 * Style.heightWindow

                }
                model: basegroup.listSort(masterController.ui_databaseController.ui_firstPlane.ui_RESERVED)
                delegate: Text {
                    width: 0.079 * Style.widthWindow//30
                    height: 0.041 * Style.heightWindow//25
                    text: modelData
                    color: "Black"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 0.45 * Style.fontSize2//12
                    clip: true
                }


                cellHeight: 0.049 * Style.heightWindow //* 30
                cellWidth: 0.065 * Style.widthWindow//25


            }
        }

        Rectangle{
            id:available
            anchors{
                left: plane1.right
                right: parent.right
                top: parent.top
                margins: 0.0082 * Style.heightWindow


            }
            color: parent.color
            height: parent.height * 0.5


            Text {
                id: header2
                width: parent.width
                height: 0.024 * Style.heightWindow
                text: qsTr("Available Seats")
                font.pixelSize: 0.35 * Style.fontSize
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true


            }

            GridView{
                id:fi2


                anchors{
                    top:header2.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: 0.0082 * Style.heightWindow


                }
                model: basegroup.listSort(masterController.ui_databaseController.ui_firstPlane.ui_AVAILABLE)
                delegate:
                    Text {
                    width: 0.079 * Style.widthWindow
                    height: 0.041 * Style.heightWindow
                    text: modelData
                    color: "Black"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 0.45 * Style.fontSize2
                    clip: true
                }


                cellHeight: 0.049 * Style.heightWindow
                cellWidth: 0.065 * Style.widthWindow


            }

        }




        Component{
            id:dialogbox

            Text {
                id: name
                text: qsTr("Seat Not Available")
                font.pixelSize: 0.9 * Style.fontSize2
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                color: Style.colourDashboardBackground
                SequentialAnimation on opacity {  NumberAnimation {  to: 0; duration: 2000; }   }
            }
        }

        Rectangle{
            anchors{
                top: plane1.bottom
                bottom: basegroup.top
                left: parent.left
                right: reserved.left

            }


            Loader{
                id:dialo
                anchors.centerIn: parent
            }
        }


        Timer {
            id: dialogTimer
            interval: 2000
            onTriggered: dialo.setSource("")
        }





    }


}
