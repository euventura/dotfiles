-- ~/.config/hypr/decoration.lua
-- Look & feel: general, decoration and animations.
-- Required by hyprland.lua. Migrated from decoration.conf.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

----------------
---- COLORS ----
----------------
-- Rosé Pine palette (legacy 0xAARRGGBB color literals).
local base          = 0xff191724
local surface       = 0xff1f1d2e
local overlay       = 0xff26233a
local muted         = 0xff6e6a86
local subtle        = 0xff908caa
local text          = 0xffe0def4
local love          = 0xffeb6f92
local gold          = 0xfff6c177
local rose          = 0xffebbcba
local pine          = 0xff31748f
local foam          = 0xff9ccfd8
local iris          = 0xffc4a7e7
local highlightLow  = 0xff21202e
local highlightMed  = 0xff403d52
local highlightHigh = 0xff524f67

-----------------------------------
---- GENERAL / DECORATION ----------
-----------------------------------

hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 3,
        border_size = 1,

        col = {
            active_border   = { colors = { love, love },         angle = 45 },
            inactive_border = { colors = { highlightLow, pine }, angle = 45 },
        },

        resize_on_border = false,
        layout           = "master",
        -- The old config set allow_tearing twice (false then true); true wins.
        allow_tearing    = true,
    },

    decoration = {
        rounding       = 1,
        rounding_power = 1,
        dim_inactive   = true,
        dim_strength   = 0.1,

        -- Transparency of focused / unfocused windows.
        active_opacity   = 1.0,
        inactive_opacity = 0.95,
    },

    animations = {
        enabled = true,
    },
})

--------------------
---- ANIMATIONS ----
--------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

-- Curves (beziers)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })

-- Animation leaves
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })
