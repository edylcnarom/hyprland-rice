-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

require("modules.monitors")



---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local browser     = "firefox"
local scriptsDir  = "~/Projects/hyprland-rice/dotfiles/.config/scripts/"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

 hl.on("hyprland.start", function () 
   hl.exec_cmd("awww-daemon")
   hl.exec_cmd("swaync")
   hl.exec_cmd("hypridle")
   hl.exec_cmd("~/.config/waybar/launch.sh")
   hl.exec_cmd("net.audiorelay.AudioRelay")
   hl.exec_cmd("wl-paste --type text --watch cliphist store")
   hl.exec_cmd("wl-paste --type image --watch cliphist store")
   
 end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

require("modules.env-variables")

-----------------------
----- PERMISSIONS -----
-----------------------

require("modules.permissions")

-----------------------
---- LOOK AND FEEL ----
-----------------------

require("modules.look-and-feel")

---------------
---- INPUT ----
---------------

require("modules.input")

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

----- MISC -----

hl.bind(" + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + 0", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(scriptsDir .. "theme-switcher.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(scriptsDir .. "wallpaper-picker.sh"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))

----- DISPLAY -----
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd('hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep \'float:\' | awk \'{print $2}\') + 0.5}")'))
hl.bind(mainMod .. " + SHIFT +  mouse_up",   hl.dsp.exec_cmd('hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep \'float:\' | awk \'{print $2}\') - 0.5}")'))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1"))

----- APPLICATIONS -----
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + space",          hl.dsp.exec_cmd(menu))


----- WINDOWS -----
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Resize Windows with mainmod SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + right", function() hl.dispatch(hl.dsp.window.resize({ x = 30, y = 0, relative = true })) end, { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  function() hl.dispatch(hl.dsp.window.resize({ x = -30, y = 0, relative = true })) end, { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  function() hl.dispatch(hl.dsp.window.resize({ x = 0, y = 30, relative = true })) end, { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    function() hl.dispatch(hl.dsp.window.resize({ x = 0, y = -30, relative = true })) end, { repeating = true })

-- Swap Windows with mainMod ALT + arrow keys
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.move({ direction = "left" })) -- Swap is handled via move in some Lua APIs
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.move({ direction = "down" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cycle between windows
--hl.bind("ALT + Tab", hl.dsp.focus({ cycle = true }), { repeating = true })
--hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ cycle = true, direction = "prev" }), { repeating = true })

----- WORKSPACES -----

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioStop",        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })


-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

require("modules.windows-and-workspaces")