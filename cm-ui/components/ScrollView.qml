import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import CM 1.0
import assets 1.0
import components 1.0


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
                
                StringEditorSingleLine {
                    stringDecorator: newClient.ui_mobile
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
                        
                        calendar.visible=true
                        dark.visible=true
                        
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
