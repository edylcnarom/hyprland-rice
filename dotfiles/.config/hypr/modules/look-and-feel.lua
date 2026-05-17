local theme = require("colors")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = (theme.primary),
            inactive_border = (theme.outline_variant),
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animation curves (Beziers)
hl.curve("myBezier",      { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("been",          { type = "bezier", points = { {0.24, 0.9},  {0.25, 0.91} } })
hl.curve("been2",         { type = "bezier", points = { {0, 0.94},    {0.5, 0.99}  } })
hl.curve("menu_decel",    { type = "bezier", points = { {0.1, 1},     {0, 1}       } })
hl.curve("linear",        { type = "bezier", points = { {0.0, 0.0},   {1.0, 1.0}   } })
hl.curve("wind",          { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("winIn",         { type = "bezier", points = { {0.1, 1.1},   {0.1, 1.1}   } })
hl.curve("winOut",        { type = "bezier", points = { {0.3, -0.3},  {0, 1}       } })
hl.curve("slow",          { type = "bezier", points = { {0, 0.85},    {0.3, 1}     } })
hl.curve("overshot",      { type = "bezier", points = { {0.7, 0.6},   {0.1, 1.1}   } })
hl.curve("bounce",        { type = "bezier", points = { {1.1, 1.6},   {0.1, 0.85}  } })
hl.curve("sligshot",      { type = "bezier", points = { {1, -1},      {0.15, 1.25} } })
hl.curve("nice",          { type = "bezier", points = { {0, 2},     {0.5, -1} } })

-- Animation configs
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 5, bezier = "slow",     style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "been",     style = "popin 70%" })
hl.animation({ leaf = "windowsMove",enabled = true, speed = 5, bezier = "wind",     style = "slide" })
hl.animation({ leaf = "border",     enabled = true, speed = 1, bezier = "linear" })
hl.animation({ leaf = "fade",       enabled = true, speed = 5, bezier = "overshot" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })
hl.animation({ leaf = "windows",    enabled = true, speed = 5, bezier = "bounce",   style = "popin" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
