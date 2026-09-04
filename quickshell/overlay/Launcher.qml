import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import ".."

// Substitui `rofi -show run` / `rofi -show drun` (keybind SUPER+SPACE).
Popup {
    id: root

    active: Ui.launcherOpen
    panelWidth: 640
    panelHeight: 460

    onOverlayOpened: {
        search.text = "";
        search.forceActiveFocus();
        list.currentIndex = 0;
    }

    readonly property var results: {
        const q = search.text.toLowerCase().trim();
        const all = DesktopEntries.applications.values.filter(a => !a.noDisplay);
        const matched = q === "" ? all : all.filter(a => {
            return a.name.toLowerCase().includes(q) || (a.genericName && a.genericName.toLowerCase().includes(q)) || (a.comment && a.comment.toLowerCase().includes(q));
        });
        return matched.sort((a, b) => a.name.localeCompare(b.name));
    }

    function run(entry) {
        if (!entry)
            return;
        entry.execute();
        Ui.closeAll();
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 10

        // inputbar
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                text: ""
                font.family: Theme.iconFont
                font.pixelSize: 16
                color: Theme.pine
            }

            TextInput {
                id: search
                Layout.fillWidth: true
                color: Theme.foam
                font.family: Theme.menuFont
                font.pixelSize: 15
                clip: true
                focus: true

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: search.text === ""
                    text: "Buscar aplicativos…"
                    color: Theme.muted
                    font: search.font
                }

                Keys.onDownPressed: list.incrementCurrentIndex()
                Keys.onUpPressed: list.decrementCurrentIndex()
                Keys.onEscapePressed: Ui.closeAll()
                Keys.onReturnPressed: root.run(root.results[list.currentIndex])
                Keys.onEnterPressed: root.run(root.results[list.currentIndex])
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Theme.highlightMed
        }

        ListView {
            id: list
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: root.results
            currentIndex: 0
            boundsBehavior: Flickable.StopAtBounds

            delegate: MouseArea {
                required property int index
                required property var modelData

                width: list.width
                height: 44
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: list.currentIndex = index
                onClicked: root.run(modelData)

                Rectangle {
                    anchors.fill: parent
                    color: list.currentIndex === index ? Theme.overlay : "transparent"
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 12

                    IconImage {
                        implicitSize: 28
                        source: modelData.icon ? Quickshell.iconPath(modelData.icon, true) : ""
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0
                        Text {
                            Layout.fillWidth: true
                            text: modelData.name
                            elide: Text.ElideRight
                            color: Theme.text
                            font.family: Theme.menuFont
                            font.pixelSize: 13
                        }
                        Text {
                            Layout.fillWidth: true
                            visible: !!modelData.comment
                            text: modelData.comment || ""
                            elide: Text.ElideRight
                            color: Theme.muted
                            font.family: Theme.menuFont
                            font.pixelSize: 10
                        }
                    }
                }
            }
        }
    }
}
