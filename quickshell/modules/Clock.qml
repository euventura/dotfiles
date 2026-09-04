import QtQuick
import QtQuick.Controls
import Quickshell
import ".."

// Substitui o módulo "clock" — format "{:L%H:%M}", clique abre merkuro-calendar.
Pill {
    id: root

    readonly property var now: clock.date

    icon: ""
    text: Qt.formatDateTime(now, "HH:mm")
    color: Theme.gold
    onClicked: Quickshell.execDetached(["merkuro-calendar"])

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    ToolTip.visible: containsMouse
    ToolTip.text: Qt.formatDateTime(now, "dddd, dd MMMM yyyy")
    ToolTip.delay: 400
}
