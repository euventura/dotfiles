pragma Singleton

import QtQuick
import Quickshell

// Estado compartilhado dos overlays (launcher, power menu, etc.).
// Mexido tanto pelos widgets da barra quanto pelo IpcHandler em shell.qml.
Singleton {
    id: root

    property bool launcherOpen: false
    property bool powerMenuOpen: false
    property bool clipboardOpen: false
    property bool asusMenuOpen: false

    function closeAll() {
        launcherOpen = false;
        powerMenuOpen = false;
        clipboardOpen = false;
        asusMenuOpen = false;
    }

    function toggleLauncher() {
        const v = !launcherOpen;
        closeAll();
        launcherOpen = v;
    }
    function togglePowerMenu() {
        const v = !powerMenuOpen;
        closeAll();
        powerMenuOpen = v;
    }
    function toggleClipboard() {
        const v = !clipboardOpen;
        closeAll();
        clipboardOpen = v;
    }
    function toggleAsusMenu() {
        const v = !asusMenuOpen;
        closeAll();
        asusMenuOpen = v;
    }
}
