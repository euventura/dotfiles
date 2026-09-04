import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import ".."

// Substitui `rofi -show p -modi p:rofi-power-menu`.
Popup {
    id: root

    active: Ui.powerMenuOpen
    panelWidth: 520
    panelHeight: 200

    readonly property var actions: [
        {
            "icon": "",
            "label": "Bloquear",
            "cmd": ["hyprlock"]
        },
        {
            "icon": "",
            "label": "Sair",
            "cmd": ["hyprctl", "dispatch", "exit"]
        },
        {
            "icon": "",
            "label": "Suspender",
            "cmd": ["systemctl", "suspend"]
        },
        {
            "icon": "",
            "label": "Hibernar",
            "cmd": ["systemctl", "hibernate"]
        },
        {
            "icon": "",
            "label": "Reiniciar",
            "cmd": ["systemctl", "reboot"]
        },
        {
            "icon": "",
            "label": "Desligar",
            "cmd": ["systemctl", "poweroff"]
        }
    ]

    onOverlayOpened: grid.forceActiveFocus()

    function trigger(a) {
        Ui.closeAll();
        Quickshell.execDetached(a.cmd);
    }

    GridView {
        id: grid
        anchors.fill: parent
        anchors.margins: 16
        cellWidth: width / 3
        cellHeight: height / 2
        model: root.actions
        focus: true
        interactive: false

        Keys.onEscapePressed: Ui.closeAll()
        Keys.onReturnPressed: root.trigger(root.actions[currentIndex])
        Keys.onEnterPressed: root.trigger(root.actions[currentIndex])

        delegate: MouseArea {
            required property int index
            required property var modelData

            width: grid.cellWidth
            height: grid.cellHeight
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: grid.currentIndex = index
            onClicked: root.trigger(modelData)

            Rectangle {
                anchors.fill: parent
                anchors.margins: 6
                radius: Theme.radius
                color: grid.currentIndex === index ? Theme.overlay : Theme.surface
                border.width: grid.currentIndex === index ? 2 : 0
                border.color: Theme.rose

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 6
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: modelData.icon
                        font.family: Theme.iconFont
                        font.pixelSize: 22
                        color: Theme.love
                    }
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: modelData.label
                        font.family: Theme.menuFont
                        font.pixelSize: 12
                        color: Theme.text
                    }
                }
            }
        }
    }
}
