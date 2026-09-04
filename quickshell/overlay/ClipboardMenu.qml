import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import ".."

// Substitui `cliphist list | rofi -dmenu | cliphist decode | wl-copy` (SUPER+V).
Popup {
    id: root

    active: Ui.clipboardOpen
    panelWidth: 680
    panelHeight: 480

    property var entries: []
    property string pending: ""

    onOverlayOpened: {
        search.text = "";
        listProc.running = true;
        search.forceActiveFocus();
    }

    readonly property var results: {
        const q = search.text.toLowerCase().trim();
        if (q === "")
            return entries;
        return entries.filter(e => e.toLowerCase().includes(q));
    }

    function paste(entry) {
        if (!entry)
            return;
        root.pending = entry;
        copyProc.running = true;
        Ui.closeAll();
    }

    Process {
        id: listProc
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: root.entries = text.split("\n").filter(l => l.trim() !== "")
        }
    }

    Process {
        id: copyProc
        command: ["sh", "-c", "cliphist decode | wl-copy"]
        stdinEnabled: true
        onStarted: {
            write(root.pending);
            stdinEnabled = false;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            Text {
                text: ""
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
                    text: "Histórico da área de transferência…"
                    color: Theme.muted
                    font: search.font
                }
                Keys.onDownPressed: list.incrementCurrentIndex()
                Keys.onUpPressed: list.decrementCurrentIndex()
                Keys.onEscapePressed: Ui.closeAll()
                Keys.onReturnPressed: root.paste(root.results[list.currentIndex])
                Keys.onEnterPressed: root.paste(root.results[list.currentIndex])
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
                height: 32
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: list.currentIndex = index
                onClicked: root.paste(modelData)

                Rectangle {
                    anchors.fill: parent
                    color: list.currentIndex === index ? Theme.overlay : "transparent"
                }
                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    text: modelData.replace(/^\d+\t/, "")
                    elide: Text.ElideRight
                    color: Theme.text
                    font.family: Theme.menuFont
                    font.pixelSize: 12
                }
            }
        }
    }
}
