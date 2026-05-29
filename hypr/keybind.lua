-- ~/.config/hypr/keybind.lua
-- Keybindings. Required by hyprland.lua. Migrated from keybind.conf.
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mod = "SUPER"

-- Programs (was $terminal / $fileManager / $menu / $volume / $bright)
local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "rofi -show run"
local volume      = os.getenv("HOME") .. "/.config/hypr/scripts/volume.sh"
local bright      = os.getenv("HOME") .. "/.config/hypr/scripts/bright.sh"

-------------------------
---- WINDOW HANDLING ----
-------------------------
hl.bind(mod .. " + SPACE",     hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + RETURN",    hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exit()) -- consider hyprshutdown instead of exit
hl.bind(mod .. " + L",         hl.dsp.exec_cmd("hyprlock"))

hl.bind(mod .. " + W",         hl.dsp.window.fullscreen())
hl.bind(mod .. " + DOWN",      hl.dsp.focus({ direction = "d" }))
-- NOTE: SUPER + UP is bound twice in the original config (movefocus + orientationtop).
hl.bind(mod .. " + UP",        hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + M",         hl.dsp.layout("swapwithmaster master"))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.layout("mfact +0.1"))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.layout("mfact -0.1"))
-- NOTE: SUPER + TAB is bound twice in the original config (cyclenext + workspace +1).
hl.bind(mod .. " + TAB",       hl.dsp.layout("cyclenext"))
hl.bind(mod .. " + UP",        hl.dsp.layout("orientationtop"))
hl.bind(mod .. " + P",         hl.dsp.window.float({ action = "toggle" }))

------------------
---- PROGRAMS ----
------------------
hl.bind(mod .. " + SHIFT + F",           hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + SHIFT + Q",           hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + D",           hl.dsp.exec_cmd("code"))
hl.bind(mod .. " + SHIFT + T",           hl.dsp.exec_cmd("txt"))
hl.bind(mod .. " + SHIFT + M",           hl.dsp.exec_cmd("kitty -e micro"))
hl.bind(mod .. " + SHIFT + N",           hl.dsp.exec_cmd("nautilus"))
hl.bind(mod .. " + SHIFT + KP_Multiply", hl.dsp.exec_cmd("gnome-calculator"))

--------------------
---- WORKSPACES ----
--------------------
hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 8 }))

hl.bind(mod .. " + CTRL + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + CTRL + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + CTRL + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + CTRL + 4", hl.dsp.focus({ workspace = 4 }))

hl.bind(mod .. " + TAB",         hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "-1", follow = true }))

hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 5, follow = true }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 6, follow = true }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 7, follow = true }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 8, follow = true }))

hl.bind(mod .. " + CTRL + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true }))
hl.bind(mod .. " + CTRL + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true }))
hl.bind(mod .. " + CTRL + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true }))
hl.bind(mod .. " + CTRL + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = true }))

----------------------
---- SCREENSHOTS  ----
----------------------
hl.bind("PRINT",                hl.dsp.exec_cmd("grimblast -n -f copysave area"))
hl.bind(mod .. " + PRINT",      hl.dsp.exec_cmd("export GRIMBLAST_EDITOR=feh; grimblast -n edit area"))
hl.bind(mod .. " + SHIFT + F6", hl.dsp.exec_cmd("export GRIMBLAST_EDITOR=feh; grimblast -n edit area"))
hl.bind(mod .. " + F6",         hl.dsp.exec_cmd("grimblast -n -f copysave area"))

-----------------------------
---- LAYOUT / ORIENTATION ----
-----------------------------
hl.bind(mod .. " + mouse_down",    hl.dsp.layout("orientationcycle"))
hl.bind(mod .. " + SHIFT + LEFT",  hl.dsp.layout("orientationleft"))
hl.bind(mod .. " + SHIFT + UP",    hl.dsp.layout("orientationtop"))
hl.bind(mod .. " + SHIFT + DOWN",  hl.dsp.layout("mfact exact 1"))
hl.bind(mod .. " + SHIFT + RIGHT", hl.dsp.layout("mfact exact 0.55"))

----------------------
---- LAPTOP KEYS  ----
----------------------
-- "bindel" => repeating + locked
hl.bind(mod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd(volume .. " --inc"),    { repeating = true, locked = true })
hl.bind(mod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd(volume .. " --dec"),    { repeating = true, locked = true })
hl.bind(mod .. " + F1",                   hl.dsp.exec_cmd(volume .. " --toggle"), { repeating = true, locked = true })
hl.bind(mod .. " + F2",                   hl.dsp.exec_cmd(bright .. " --dec"),    { repeating = true, locked = true })
hl.bind(mod .. " + F3",                   hl.dsp.exec_cmd(bright .. " --inc"),    { repeating = true, locked = true })
hl.bind(mod .. " + F7",                   hl.dsp.exec_cmd("asusctl leds prev"),   { repeating = true, locked = true })
hl.bind(mod .. " + F8",                   hl.dsp.exec_cmd("asusctl leds next"),   { repeating = true, locked = true })

-------------------
---- PLAYERCTL ----
-------------------
-- "bindl" => locked
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"), { locked = true })

----------------------
---- VOLUME / AUDIO ----
----------------------
-- NOTE: the original config passed $volume (the volume.sh path) to `wpctl
-- set-volume`, which looks like a leftover bug. Kept faithfully for now --
-- you probably want e.g. `wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+`.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume " .. volume .. " --inc"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume " .. volume .. " --dec"), { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-------------------------
---- SCREEN BRIGHTNESS ----
-------------------------
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(bright .. " --inc"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(bright .. " --dec"), { locked = true })
hl.bind("XF86Launch1", hl.dsp.exec_cmd("asusctl profile next"), { locked = true })
hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl profile next"), { locked = true })
