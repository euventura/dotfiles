# quickshell

Barra + launcher em [Quickshell](https://quickshell.outfoxxed.me/), migrados da
`waybar/` e do `rofi/` (mantidos no repo como backup até validar).

## Rodar

```sh
qs            # usa ~/.config/quickshell -> este diretório (symlink)
qs -p ~/.config/quickshell/shell.qml   # modo avulso, útil p/ ver erros
```

O Hyprland já sobe com `qs` no autostart (`hypr/hyprland.lua`).

## Estrutura

| Arquivo | Substitui |
|---|---|
| `Theme.qml` | `waybar/rose-pine.css` + cores do `rofi/config.rasi` |
| `Sys.qml` | módulos `cpu` / `memory` / `temperature` (lê `/proc` e hwmon) |
| `Asus.qml` | `waybar/modules/asus_controls.sh` (`supergfxctl` / `asusctl`) |
| `Ui.qml` | estado dos overlays (aberto/fechado) |
| `modules/Bar.qml` | a waybar inteira (`waybar/config.jsonc`) |
| `modules/Workspaces.qml` | `hyprland/workspaces` (persistentes por monitor) |
| `modules/FocusedWindow.qml` | `hyprland/window` |
| `modules/Tray.qml` | `group/tray-expander` + `tray` |
| `modules/{Bluetooth,Network,Volume,Battery,Clock,Power}.qml` | módulos homônimos |
| `overlay/Launcher.qml` | `rofi -show run` (SUPER+SPACE) |
| `overlay/PowerMenu.qml` | `rofi -show p -modi p:rofi-power-menu` (ícone ⏻ na barra) |
| `overlay/ClipboardMenu.qml` | `cliphist list \| rofi -dmenu` (SUPER+V) |
| `overlay/AsusMenu.qml` | `waybar/modules/asus_control_menu.sh` (clique no módulo ASUS) |

## Gatilhos externos (keybinds do Hyprland)

```sh
qs ipc call launcher toggle
qs ipc call clipboard toggle
qs ipc call power toggle
```

## Rollback

```sh
rm ~/.config/quickshell
# hypr/hyprland.lua: hl.exec_cmd("qs")  -> hl.exec_cmd("waybar")
# hypr/keybind.lua:  menu = "rofi -show run"; V = cliphist ... | rofi -dmenu ...
```

## Dependências

`quickshell`, `nmcli` (NetworkManager), `cliphist`, `wl-clipboard`, `asusctl`,
`supergfxctl`, `hyprlock`. Fonte de ícones: uma *Nerd Font* (ajuste
`Theme.iconFont` — hoje `"Symbols Nerd Font"`).
