pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// Métricas de sistema — substitui os módulos cpu / memory / temperature da waybar.
Singleton {
    id: root

    // Percentuais 0-100
    property int cpu: 0
    property int memory: 0
    property int tempC: 0

    // waybar: "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input"
    property string hwmonPath: "/sys/class/hwmon/hwmon2/temp1_input"
    readonly property int tempCritical: 80

    property var _prevCpu: null

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            statFile.reload();
            memFile.reload();
            tempFile.reload();
        }
    }

    FileView {
        id: statFile
        path: "/proc/stat"
        onLoaded: {
            const line = text().split("\n")[0].trim().split(/\s+/);
            if (line[0] !== "cpu")
                return;
            const nums = line.slice(1).map(Number);
            const idle = nums[3] + (nums[4] || 0);
            const total = nums.reduce((a, b) => a + b, 0);
            if (root._prevCpu) {
                const dTotal = total - root._prevCpu.total;
                const dIdle = idle - root._prevCpu.idle;
                if (dTotal > 0)
                    root.cpu = Math.round(100 * (dTotal - dIdle) / dTotal);
            }
            root._prevCpu = {
                "total": total,
                "idle": idle
            };
        }
    }

    FileView {
        id: memFile
        path: "/proc/meminfo"
        onLoaded: {
            const info = {};
            for (const l of text().split("\n")) {
                const m = l.match(/^(\w+):\s+(\d+)/);
                if (m)
                    info[m[1]] = parseInt(m[2]);
            }
            if (info.MemTotal) {
                const used = info.MemTotal - (info.MemAvailable !== undefined ? info.MemAvailable : info.MemFree);
                root.memory = Math.round(100 * used / info.MemTotal);
            }
        }
    }

    FileView {
        id: tempFile
        path: root.hwmonPath
        onLoaded: {
            const v = parseInt(text().trim());
            if (!isNaN(v))
                root.tempC = Math.round(v / 1000);
        }
    }
}
