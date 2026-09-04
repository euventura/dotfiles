import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import ".."

// Substitui o módulo "network" (via nmcli). Clique abre `kitty -e wlctl`.
Pill {
    id: root

    property string kind: "disconnected"   // wifi | ethernet | disconnected
    property int signal: 0                  // 0-100
    property string ssid: ""

    readonly property var wifiIcons: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]

    icon: {
        if (kind === "ethernet")
            return "󰀂";
        if (kind === "wifi")
            return wifiIcons[Math.min(4, Math.floor(signal / 20))];
        return "󰤮";
    }
    color: Theme.gold
    onClicked: Quickshell.execDetached(["kitty", "-e", "wlctl"])

    ToolTip.visible: containsMouse && root.kind !== "disconnected"
    ToolTip.text: root.kind === "wifi" ? (root.ssid + " · " + root.signal + "%") : "Ethernet"
    ToolTip.delay: 400

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: statusProc.running = true
    }

    Process {
        id: statusProc
        command: ["nmcli", "-t", "-f", "TYPE,STATE,CONNECTION,DEVICE", "device", "status"]
        stdout: StdioCollector {
            onStreamFinished: {
                let k = "disconnected";
                for (const line of text.trim().split("\n")) {
                    const f = line.split(":");
                    if (f[1] !== "connected")
                        continue;
                    if (f[0] === "ethernet") {
                        k = "ethernet";
                        break;
                    }
                    if (f[0] === "wifi")
                        k = "wifi";
                }
                root.kind = k;
                if (k === "wifi")
                    wifiProc.running = true;
            }
        }
    }

    Process {
        id: wifiProc
        command: ["nmcli", "-t", "-f", "IN-USE,SIGNAL,SSID", "device", "wifi"]
        stdout: StdioCollector {
            onStreamFinished: {
                for (const line of text.trim().split("\n")) {
                    if (!line.startsWith("*"))
                        continue;
                    const f = line.split(":");
                    root.signal = parseInt(f[1]) || 0;
                    root.ssid = f[2] || "";
                    break;
                }
            }
        }
    }
}
