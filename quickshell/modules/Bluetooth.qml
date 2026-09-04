import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth
import ".."

// Substitui o módulo "bluetooth". Clique abre blueberry.
Pill {
    id: root

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool enabled: adapter && adapter.enabled
    readonly property int connectedCount: {
        if (!Bluetooth.devices)
            return 0;
        let n = 0;
        const list = Bluetooth.devices.values;
        for (var i = 0; i < list.length; i++)
            if (list[i].connected)
                n++;
        return n;
    }

    icon: !enabled ? "󰂲" : (connectedCount > 0 ? "󰂱" : "")
    color: Theme.gold
    onClicked: Quickshell.execDetached(["blueberry"])

    ToolTip.visible: containsMouse
    ToolTip.text: "Dispositivos conectados: " + connectedCount
    ToolTip.delay: 400
}
