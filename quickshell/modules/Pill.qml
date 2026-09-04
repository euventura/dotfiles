import QtQuick
import QtQuick.Layouts
import ".."

// Item genérico da barra: ícone + texto, hover e clique.
// Equivale a um "#module" do style.css da waybar.
MouseArea {
    id: root

    property string icon: ""
    property string text: ""
    property color color: Theme.gold
    property color iconColor: color
    property int spacing: 6
    property bool showBackgroundOnHover: true

    signal scrollUp
    signal scrollDown

    implicitWidth: layout.implicitWidth + Theme.pillPadding * 2
    implicitHeight: Theme.barHeight
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

    onWheel: event => {
        if (event.angleDelta.y > 0)
            root.scrollUp();
        else if (event.angleDelta.y < 0)
            root.scrollDown();
    }

    Rectangle {
        anchors.fill: parent
        visible: root.showBackgroundOnHover && root.containsMouse
        color: Theme.base
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: root.spacing

        Text {
            visible: root.icon !== ""
            text: root.icon
            color: root.iconColor
            font.family: Theme.iconFont
            font.pixelSize: 14
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            visible: root.text !== ""
            text: root.text
            color: root.color
            font.family: Theme.barFont
            font.pixelSize: 12
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
