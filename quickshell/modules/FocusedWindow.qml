import QtQuick
import Quickshell
import Quickshell.Wayland
import ".."

// Substitui "hyprland/window" com format "{class}".
Text {
    id: root

    readonly property Toplevel active: ToplevelManager.activeToplevel

    text: active ? (active.appId || active.title || "") : ""
    elide: Text.ElideRight
    color: Theme.text
    font.family: Theme.barFont
    font.pixelSize: 12
}
