import QtQuick
import QtQuick.Layouts
import ".."

// Substitui waybar/modules/asus_control_menu.sh (menu rofi de perfil ASUS).
Popup {
    id: root

    active: Ui.asusMenuOpen
    panelWidth: 400
    panelHeight: 210

    onOverlayOpened: {
        grid.forceActiveFocus();
        grid.currentIndex = Math.max(0, Asus.profiles.indexOf(Asus.profile));
    }

    function pick(p) {
        Asus.setProfile(p);
        Ui.closeAll();
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 6

        Text {
            text: "Perfil de desempenho ASUS"
            color: Theme.gold
            font.family: Theme.menuFont
            font.pixelSize: 13
        }
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Theme.highlightMed
        }

        ListView {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: Asus.profiles
            focus: true
            interactive: false
            currentIndex: 0

            Keys.onEscapePressed: Ui.closeAll()
            Keys.onDownPressed: incrementCurrentIndex()
            Keys.onUpPressed: decrementCurrentIndex()
            Keys.onReturnPressed: root.pick(Asus.profiles[currentIndex])
            Keys.onEnterPressed: root.pick(Asus.profiles[currentIndex])

            delegate: MouseArea {
                required property int index
                required property var modelData
                width: grid.width
                height: 40
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: grid.currentIndex = index
                onClicked: root.pick(modelData)

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    radius: Theme.radius
                    color: grid.currentIndex === index ? Theme.overlay : "transparent"
                }
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    spacing: 12
                    Text {
                        text: Asus.profileIcon(modelData)
                        font.family: Theme.iconFont
                        font.pixelSize: 16
                        color: Theme.gold
                    }
                    Text {
                        Layout.fillWidth: true
                        text: modelData + (modelData === Asus.profile ? "  ·  ativo" : "")
                        color: Theme.text
                        font.family: Theme.menuFont
                        font.pixelSize: 13
                    }
                }
            }
        }
    }
}
