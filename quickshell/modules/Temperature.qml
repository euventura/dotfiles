import ".."

// Substitui o módulo "temperature" — format "{icon} {temperatureC}°C".
Pill {
    readonly property bool critical: Sys.tempC >= Sys.tempCritical
    // waybar format-icons: ["", "", ""]
    icon: Sys.tempC >= Sys.tempCritical ? "" : (Sys.tempC >= 60 ? "" : "")
    text: Sys.tempC + "°C"
    color: critical ? Theme.love : Theme.gold
}
