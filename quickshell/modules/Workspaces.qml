import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import ".."

// Substitui "hyprland/workspaces" — workspaces persistentes por monitor.
Row {
    id: root

    required property ShellScreen screen

    // waybar: "persistent-workspaces" { "HDMI-A-3": [5,6,7,8], "eDP-1": [1,2,3,4] }
    readonly property var persistent: ({
            "eDP-1": [1, 2, 3, 4],
            "HDMI-A-3": [5, 6, 7, 8]
        })
    readonly property var wsIds: persistent[screen.name] || [1, 2, 3, 4, 5]

    spacing: 0

    Repeater {
        model: root.wsIds

        MouseArea {
            id: wsBtn
            required property int modelData

            readonly property HyprlandWorkspace ws: {
                const list = Hyprland.workspaces.values;
                for (var i = 0; i < list.length; i++)
                    if (list[i].id === modelData)
                        return list[i];
                return null;
            }
            readonly property bool active: ws && ws.active
            readonly property bool occupied: ws !== null

            width: Theme.barHeight
            height: Theme.barHeight
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: Hyprland.dispatch("workspace " + modelData)

            Rectangle {
                anchors.fill: parent
                color: wsBtn.active ? Theme.overlay : (wsBtn.containsMouse ? Theme.base : "transparent")

                Text {
                    anchors.centerIn: parent
                    text: wsBtn.modelData
                    font.family: Theme.barFont
                    font.pixelSize: 12
                    font.weight: wsBtn.active ? Font.Black : Font.Normal
                    color: wsBtn.active ? Theme.pine : (wsBtn.containsMouse ? Theme.pine : (wsBtn.occupied ? Theme.text : Theme.muted))
                }
            }
        }
    }
}
