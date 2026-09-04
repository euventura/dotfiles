import ".."

// Substitui "custom/asus_control" — clique abre o menu de perfil.
Pill {
    icon: Asus.graphicsIcon
    text: Asus.graphicsLabel + "  " + Asus.profileIcon(Asus.profile) + " " + Asus.profile
    color: Theme.gold
    onClicked: Ui.toggleAsusMenu()
}
