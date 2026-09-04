pragma Singleton

import QtQuick
import Quickshell

// Paleta Rosé Pine — migrada de waybar/rose-pine.css e rofi/config.rasi
Singleton {
    id: root

    // base
    readonly property color base: "#191724"
    readonly property color surface: "#1f1d2e"
    readonly property color overlay: "#26233a"

    readonly property color muted: "#6e6a86"
    readonly property color subtle: "#908caa"
    readonly property color text: "#e0def4"

    readonly property color love: "#eb6f92"
    readonly property color gold: "#f6c177"
    readonly property color rose: "#ebbcba"
    readonly property color pine: "#31748f"
    readonly property color foam: "#9ccfd8"
    readonly property color iris: "#c4a7e7"

    readonly property color highlightLow: "#21202e"
    readonly property color highlightMed: "#403d52"
    readonly property color highlightHigh: "#524f67"

    // Tipografia
    readonly property string barFont: "DM Mono"          // era waybar/style.css
    readonly property string menuFont: "Cartograph CF"   // era rofi/config.rasi
    // "Symbols Nerd Font" não está instalada aqui — qualquer fonte Nerd Font
    // patcheada já embute os glifos; MesloLGS é a que está disponível no sistema.
    readonly property string iconFont: "MesloLGS Nerd Font Mono"

    // Métricas da barra (waybar: height 30, spacing 0)
    readonly property int barHeight: 30
    readonly property int pillPadding: 10
    readonly property int radius: 6
}
