import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import ".."

// Substitui o módulo "pulseaudio" — clique abre wiremix, scroll ajusta volume.
Pill {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property real vol: sink && sink.audio ? sink.audio.volume : 0

    // mantém o objeto vivo p/ ligar as props de áudio
    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    // format-icons: muted "", default ["", "", ""]
    icon: muted ? "" : (vol <= 0.01 ? "" : (vol < 0.34 ? "" : (vol < 0.67 ? "" : "")))
    color: muted ? Theme.rose : Theme.gold
    onClicked: Quickshell.execDetached(["kitty", "-e", "wiremix"])
    onScrollUp: if (sink && sink.audio) sink.audio.volume = Math.min(1, vol + 0.05)
    onScrollDown: if (sink && sink.audio) sink.audio.volume = Math.max(0, vol - 0.05)
}
