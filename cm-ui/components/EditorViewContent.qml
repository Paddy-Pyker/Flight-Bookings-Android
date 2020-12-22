import QtQuick 2.9
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
                CustomStringEditorSingleLine {
                    stringDecorator: selectedClient.ui_reference
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }
                CustomStringEditorSingleLine {
                    stringDecorator: selectedClient.ui_name
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }
                
                CustomStringEditorSingleLine {
                    stringDecorator: selectedClient.ui_mobile
                    noEdit: true
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }
                
                
            }
        }
        AddressEditor2 {
            address: selectedClient.ui_supplyAddress
            headerText: "Residence"
        }
        
        
        Panel {
            id:panel
            headerText: "Flight Details"
            contentComponent:
                Column {
                spacing: Style.sizeControlSpacing
                
                PlaneStringEditorSingleLine{
                    stringDecorator: selectedClient.ui_planeId
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    
                }
                
                PlaneStringEditorSingleLine{
                    stringDecorator: selectedClient.ui_seatNumber
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                }
                
                DepartureEditor2{
                    id:departure
                    stringDecorator: selectedClient.ui_departure
                    
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    
                    
                }
                
                DepartureEditor2{
                    id:from
                    stringDecorator: selectedClient.ui_from
                    
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    
                    
                }
                
                DepartureEditor2{
                    id:to
                    stringDecorator: selectedClient.ui_to
                    
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    
                    
                }
                
                
            }
        }
        
        PaymentEditor {
            width: scrollView.width
            client: selectedClient
            headerText: "Payment Mode"
        }
    }
}
