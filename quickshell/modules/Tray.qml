import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import ".."

// Substitui "group/tray-expander" + "tray" — chevron expande os ícones.
RowLayout {
    id: root
    spacing: 12

    property bool expanded: false

    MouseArea {
        implicitWidth: Theme.barHeight
        implicitHeight: Theme.barHeight
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: root.expanded = !root.expanded

        Text {
            anchors.centerIn: parent
            text: root.expanded ? "" : ""
            font.family: Theme.iconFont
            font.pixelSize: 13
            color: parent.containsMouse ? Theme.pine : Theme.gold
        }
    }

    Repeater {
        model: root.expanded ? SystemTray.items : null

        delegate: MouseArea {
            required property SystemTrayItem modelData

            Layout.alignment: Qt.AlignVCenter
            implicitWidth: 18
            implicitHeight: Theme.barHeight
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onClicked: mouse => {
                if (mouse.button === Qt.LeftButton)
                    modelData.activate();
                else if (mouse.button === Qt.MiddleButton)
                    modelData.secondaryActivate();
                else if (mouse.button === Qt.RightButton && modelData.hasMenu)
                    menuAnchor.open();
            }

            QsMenuAnchor {
                id: menuAnchor
                menu: modelData.menu
                anchor.window: root.QsWindow.window
                anchor.rect.x: parent.x
                anchor.rect.y: Theme.barHeight
            }

            IconImage {
                anchors.centerIn: parent
                implicitSize: 14
                source: modelData.icon
            }
        }
    }
}
