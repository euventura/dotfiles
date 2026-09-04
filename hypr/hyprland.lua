-- ~/.config/hypr/hyprland.lua
-- Migrated from the old hyprlang format (hyprland.conf) to the Lua config
-- format introduced in Hyprland 0.55.
-- Docs: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "HDMI-A-3", mode = "1920x1080@60",  position = "0x0",    scale = 1 })
hl.monitor({ output = "eDP-1",    mode = "2560x1600@240", position = "1920x0", scale = 1.6 })

-- hl.env("HYPRCURSOR_THEME", "nordic")
-- hl.env("HYPRCURSOR_SIZE", "20")

-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.exec_cmd spawns async processes, so trailing "&" is no longer needed.

hl.on("hyprland.start", function()
    hl.exec_cmd("qs")  -- era "waybar" (migrado p/ Quickshell)
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("dunst")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprctl setcursor nordic 20")
    hl.exec_cmd("rog-control-center")

end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
----- PERMISSIONS -----
-----------------------
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- general / decoration / animations are defined in decoration.lua
require("decoration")

hl.config({
    xwayland = {
        force_zero_scaling   = true,
        use_nearest_neighbor = true,
    },

    dwindle = {
        force_split                  = 0,
        preserve_split               = true,
        smart_split                  = true,
        smart_resizing               = true,
        permanent_direction_override = false,
        special_scale_factor         = 1,
        split_width_multiplier       = 1.0,
        use_active_for_splits        = true,
        default_split_ratio          = 1.0,
        split_bias                   = 0,
        precise_mouse_move           = false,
    },

    master = {
        new_status = "slave",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "br",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse  = 2,
        sensitivity   = 0, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Per-device config (replaces the old `device {}` block).
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = 1,
})

---------------------
---- KEYBINDINGS ----
---------------------
require("keybind")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
--     https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })

hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-3" })

-- hl.window_rule({
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })

hl.window_rule({ match = { class = "Godot$" },         tile = true, focus_on_activate = true })
hl.window_rule({ match = { class = "(.*)(DEBUG)" },    tile = true, focus_on_activate = true })
hl.window_rule({ match = { title = "(.*)(DEBUG)" },    tile = true, focus_on_activate = true })
hl.window_rule({ match = { class = "steam_app_(.*)" }, fullscreen = true, workspace = "6", focus_on_activate = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" },       float = true, focus_on_activate = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true, focus_on_activate = true })
hl.window_rule({ match = { class = "blueberry.py" },               float = true, focus_on_activate = true })

-- hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true, center = true })
