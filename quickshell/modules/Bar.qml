import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import ".."

// Substitui a waybar. Layout de waybar/config.jsonc:
//   left:   workspaces | memory | cpu | temperature
//   center: window
//   right:  tray | asus | bluetooth | network | volume | battery | clock | power
PanelWindow {
    id: bar

    // "screen" já existe em PanelWindow — não redeclarar, senão as
    // instâncias do Variants (uma por monitor) caem todas no mesmo monitor.

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Theme.barHeight
    color: Theme.surface

    // fecha overlays ao clicar fora
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: event => event.accepted = false
    }

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0

        Workspaces {
            screen: bar.screen
        }
        Item {
            implicitWidth: 4
        }
        Memory {}
        Cpu {}
        Temperature {}
    }

    FocusedWindow {
        anchors.centerIn: parent
        width: Math.min(implicitWidth, parent.width * 0.4)
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0

        Tray {}
        Item {
            implicitWidth: 8
        }
        AsusControl {}
        Bluetooth {}
        Network {}
        Volume {}
        Battery {}
        Clock {}
        Power {}
    }
}
