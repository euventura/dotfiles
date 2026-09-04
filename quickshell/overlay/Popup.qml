import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import ".."

// Base dos overlays que substituem o rofi: janela cheia, fundo escurecido,
// foco de teclado, ESC / clique-fora fecham.
PanelWindow {
    id: root

    property bool active: false
    default property alias content: container.data
    property int panelWidth: 600
    property int panelHeight: 400
    property alias panel: container

    signal overlayOpened
    signal overlayClosed

    visible: active
    // segue o monitor com foco (equivale ao rofi abrir no monitor ativo)
    screen: {
        const m = Hyprland.focusedMonitor;
        const screens = Quickshell.screens;
        if (m)
            for (var i = 0; i < screens.length; i++)
                if (screens[i].name === m.name)
                    return screens[i];
        return screens.length > 0 ? screens[0] : null;
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: active ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    WlrLayershell.namespace: "quickshell-overlay"

    onActiveChanged: {
        console.log("[popup-debug] active=" + active + " screen=" + root.screen + " visible=" + root.visible + " focusedMonitor=" + (Hyprland.focusedMonitor ? Hyprland.focusedMonitor.name : "null"));
        if (active) {
            overlayOpened();
            focusScope.forceActiveFocus();
        } else {
            overlayClosed();
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: root.active ? 0.35 : 0
        Behavior on opacity {
            NumberAnimation { duration: 120 }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: Ui.closeAll()
        }
    }

    Rectangle {
        id: container
        anchors.centerIn: parent
        width: root.panelWidth
        height: root.panelHeight
        radius: Theme.radius
        color: Theme.base
        border.width: 2
        border.color: Theme.rose
        opacity: root.active ? 1 : 0
        scale: root.active ? 1 : 0.96
        Behavior on opacity {
            NumberAnimation { duration: 120 }
        }
        Behavior on scale {
            NumberAnimation { duration: 120 }
        }

        // impede que cliques dentro do painel fechem o overlay
        MouseArea {
            anchors.fill: parent
        }
    }

    Item {
        id: focusScope
        anchors.fill: parent
        focus: true
        Keys.onEscapePressed: Ui.closeAll()
    }
}
