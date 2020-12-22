import QtQuick 2.9
import CM 1.0
import assets 1.0

Panel {
    property Client client
    id: contactsEditorRoot
    contentComponent:
        Column {
            id: column
            spacing: Style.sizeControlSpacing

            Repeater {
                id: contactsView
                model: client.ui_contacts
                delegate:
                    ContactDelegate {
                        width: contactsEditorRoot.width
                        contact: modelData
                    }
            }

            FormButton {
                iconCharacter: "\uf067"
                description: "Add Payment"
                onFormButtonClicked: {
                    client.addContact()
                }
            }

            FormButton {
                id: fff
                iconCharacter: ""
                description: "Remove Payment"
                onFormButtonClicked: {
                    client.removeContact()
                }
                anchors.right: parent.right



            }


        }
}
