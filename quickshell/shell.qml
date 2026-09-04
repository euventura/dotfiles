//@ pragma UseQApplication

import QtQml
import Quickshell
import Quickshell.Io
import "modules"
import "overlay"

ShellRoot {
    id: shell

    // Uma barra por monitor (waybar rodava em todos).
    Variants {
        model: Quickshell.screens
        delegate: Component {
            Bar {
                required property var modelData
                screen: modelData
            }
        }
    }

    // Overlays — instância única, seguem o monitor com foco.
    Launcher {}
    PowerMenu {}
    ClipboardMenu {}
    AsusMenu {}

    // Gatilhos externos (keybinds do Hyprland): `qs ipc call <target> toggle`
    IpcHandler {
        target: "launcher"
        function toggle() { Ui.toggleLauncher() }
        function open() { Ui.closeAll(); Ui.launcherOpen = true }
        function close() { Ui.launcherOpen = false }
    }
    IpcHandler {
        target: "clipboard"
        function toggle() { Ui.toggleClipboard() }
    }
    IpcHandler {
        target: "power"
        function toggle() { Ui.togglePowerMenu() }
    }
    IpcHandler {
        target: "bar"
        function closeAll() { Ui.closeAll() }
    }
}
