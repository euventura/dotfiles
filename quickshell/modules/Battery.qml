import QtQuick
import Quickshell.Services.UPower
import ".."

// Substitui o módulo "battery".
Pill {
    id: root

    readonly property var dev: UPower.displayDevice
    // UPowerDevice.percentage é fracionário (0.0-1.0), não 0-100.
    readonly property int pct: dev ? Math.round(dev.percentage * 100) : 0
    readonly property bool charging: dev && dev.state === UPowerDeviceState.Charging
    readonly property bool plugged: dev && dev.state === UPowerDeviceState.FullyCharged

    // waybar states: good 95 / warning 30 / critical 15
    readonly property bool critical: !charging && pct <= 15
    readonly property bool warning: !charging && pct <= 30

    visible: dev && dev.isLaptopBattery
    // format-icons: ["", "", "", "", ""]
    icon: charging ? "" : ["", "", "", "", ""][Math.min(4, Math.floor(pct / 20))]
    text: pct + "%"
    color: critical ? Theme.surface : (charging || plugged ? Theme.muted : (warning ? Theme.love : Theme.gold))

    Rectangle {
        anchors.fill: parent
        z: -1
        visible: root.critical
        color: Theme.pine
        SequentialAnimation on opacity {
            running: root.critical
            loops: Animation.Infinite
            NumberAnimation { from: 1; to: 0.3; duration: 500 }
            NumberAnimation { from: 0.3; to: 1; duration: 500 }
        }
    }
}
