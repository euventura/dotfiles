pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// Substitui waybar/modules/asus_controls.sh — lê supergfxctl e asusctl.
Singleton {
    id: root

    property string graphicsMode: "Unknown"   // Hybrid | Integrated | AsusMuxDgpu
    property string profile: "Balanced"       // Performance | Balanced | LowPower

    readonly property var profiles: ["Performance", "Balanced", "LowPower"]

    readonly property string graphicsIcon: ({
            "Hybrid": "󰈐",
            "Integrated": "󰢮",
            "AsusMuxDgpu": "󰢹"
        }[graphicsMode] || "󰢤")
    readonly property string graphicsLabel: ({
            "Hybrid": "Hybrid",
            "Integrated": "iGPU",
            "AsusMuxDgpu": "dGPU"
        }[graphicsMode] || "Unknown")

    function profileIcon(p) {
        return ({
                "Performance": "󰓅",
                "Balanced": "󰾅",
                "LowPower": "󰾆"
            }[p] || "󰓅");
    }

    function refresh() {
        gfxProc.running = true;
        profileProc.running = true;
    }

    function setProfile(p) {
        setProc.command = ["asusctl", "profile", "set", p];
        setProc.running = true;
    }

    Component.onCompleted: refresh()

    Timer {
        interval: 15000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Process {
        id: gfxProc
        command: ["supergfxctl", "-g"]
        stdout: StdioCollector {
            onStreamFinished: root.graphicsMode = text.trim()
        }
    }

    Process {
        id: profileProc
        command: ["asusctl", "profile", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                // saída: "Active profile: Balanced"
                const m = text.match(/Active profile:\s*(\w+)/);
                if (m)
                    root.profile = m[1];
            }
        }
    }

    Process {
        id: setProc
        onExited: root.refresh()
    }
}
