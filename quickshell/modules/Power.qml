import ".."

// Substitui "custom/power" — abria `rofi -show p -modi p:rofi-power-menu`.
Pill {
    icon: "⏻"
    color: Theme.love
    onClicked: Ui.togglePowerMenu()
}
