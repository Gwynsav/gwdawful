------------------------
-- User Configuration --
------------------------
-- Main user configuration file. Here you may define your default
-- applications, UI scaling, and toggle features on/off.

-- Applications
---------------
-- These are mandatory, and therefore cannot be commented or deleted.
-- Define your default applications, mainly used in 'config/keys.lua'
terminal     = "xterm"
editor       = os.getenv("EDITOR")  or "emacs"
browser      = os.getenv("BROWSER") or "firefox"
top          = "htop"
files_cli    = "lf"
files_gui    = "nemo"

-- Options
----------
local user = {}

-- Settings
-----------
--- Mod4 is Super, Mod1 is Alt. Defaults to "Mod4". 
-- user.modkey       = "Mod4"
--- Use the CapsLock key as an additional super key. Defaults to false.
-- user.caps_super   = true
--- Should hovering a client with mouse focus it. Defaults to false.
-- user.hover_focus  = true
--- Keyboard layouts to switch between using `mod + u`. Comment `kb_layout2` 
--- to disable this behavior. If set, `kb_layout1` will be set as keyboard 
--- layout on startup.
-- user.kb_layout1   = "us"
-- user.kb_layout2   = "latam"

-- Features
-----------
--- Enable/disable battery metrics and specify device to be used.
--- The device name is provided by the lgi Upower interface, I
--- believe it follows the `battery_XXXX` pattern where XXXX is
--- the `/sys/class/power_supply/` device name, e.g. BAT0/BAT1.
--- Battery defaults to false and name to "battery_BAT0".
user.battery      = true
user.battery_name = "battery_BAT0"

--- Enable/disable brightness metrics and specify device to be used.
--- The device name is found in `/sys/class/backlight/`. Common examples
--- are "intel_backlight" and "amdgpu_bl0" for integrated graphics.
--- Brightness defaults to false and name to "intel_backlight".
-- user.brightness      = true
-- user.brightness_name = "intel_backlight"

--- Enable/disable bluetooth metrics. No need to specify device name.
--- Defaults to false.
-- user.bluetooth    = true

-- UI
-----
--- The '*_size' variables are screen height percentages.
--- So, dash_size being 66 means it'll take 66% of my monitor height.

--- Vertical Resolution of your monitor. Defaults to 1080.
-- user.resolution   = 1080
--- Your monitor's aspect ratio, commonly 16:9 or 16:10. Defaults to 16/9.
-- user.aspect_ratio = 16/9
--- Your monitor's dpi. May or may not be extremely breaking to the UI. 
--- Use it if you actually know what you're doing. Comment to use your 
--- monitor's default (recommended). These dots where built on dpi 96.
-- user.dpi          = 96

--- Bar 
--- Changes default state of the bar. Can still be brought up
--- by emitting the 'widget::bar' signal (mod + b) even if disabled.
--- Defaults to true.
-- user.bar_enabled  = true
--- System bar size (screen %). Defaults to 4.5.
-- user.bar_size     = 4.5
--- Can be 'top', 'bottom', 'right' or 'left'. Defaults to 'left'.
user.bar_pos      = "right"
--- Adds 'outer_gaps' to the bar. Defaults to false.
-- user.bar_gap      = false

--- Titles
--- Toggles titlebars. Defaults to true.
-- user.title_enable = true
--- Toggles inverted titlebar layout. Defaults to false.
-- user.title_invert = true
--- Titlebars size (screen %). Defaults to 3.
-- user.titles_size  = 3
--- Can be 'top', 'bottom', 'right' or 'left'. Defaults to 'top'.
-- user.titles_pos   = "right"

--- Dashboard
--- Dashboard size (screen %). Defaults to 75.
-- user.dash_size    = 75

--- Notifications
--- Notification size (screen %). Defaults to 9.
-- user.notif_size   = 9
--- Can be 'top_left', 'top_right', 'bottom_left' or 'bottom_right'. 
--- Avoids bar by default.
-- user.notif_pos    = "top_left"

--- Gaps. 
---   Inner gaps are common gaps. Default to 0.4.
---   Outer gaps are the gaps between the tag contents and the edge of the 
---   screen. Default to 3 times `inner_gaps`.
-- user.inner_gaps   = 0.4
-- user.outer_gaps   = user.inner_gaps * 3 -- Triple outer gap.

--- Borders
--- Size of borders used on windows and some widgets (screen %). Defaults to 0.
-- user.border_size  = 0.2 -- 2 pixel border on 1080p
--- Radius of borders used on windows and some widgets. Defaults to 0.8.
user.border_rad   = 0
--- Should clients/windows be rounded using `border_rad`. Defaults to false.
-- user.round_client = false

-- Theming
----------
--- Supported themes:
---  dark:
---    'everblush', 'everforest', 'tokyonight', 'mar' 
---  light:
---    'gruvbox', 'solarized', 'plata'
--- More themes can be added at `themes/palettes`. DOES NOT have a default.
user.clr_palette  = "plata"
--- GTK icon pack to use, comment for Papirus or name.
-- user.icon_pack    = "Papirus"
--- Fonts to be used.
--- Default to 'IBM Plex Sans', 'Material Icons' and 'IBM Plex Mono' respectively.
-- user.ui_font      = "IBM Plex Sans"
-- user.ic_font      = "Material Icons"
-- user.mn_font      = "IBM Plex Mono"

--- Lua doesn't take '~' for home, use os.getenv('HOME').
--- Your *amazing* profile picture. Path or comment for default.
-- user.avatar       = os.getenv("HOME") .. "/Pictures/avatars/serasAlt.jpg"
--- Your wallpaper path. Path, or comment for colorscheme default.
-- user.wall         = os.getenv("HOME") .. "/Pictures/walls/everblush/Smily.jpg"
--- Music player fallback background. Path, or comment for colorscheme default.
-- user.player_bg    = os.getenv("HOME") .. "/Pictures/walls/landscape/Somewhere.png"
--- AwesomeWM icon to be used (comment for default awesome icon): 
---   'arch', 'debian', 'fedora', 'nix', 'ubuntu' or 'void'.
--- Can also be a path to an image.
-- user.awm_icon     = "debian"

-- Miscelaneous
---------------
--- Directory to save screenshots to (when prompted to do so).
--- Defaults to '~/Pictures/'
-- user.scrnshot_dir = os.getenv("HOME") .. "/Pictures/"

--- Terminal scratchpad. Brought up with `mod + Ctrl + Return`.
--- Horizontal screen percentage used as width. Defaults to 40.
-- user.scratch_wide = 40
--- Vertical screen percentage used as height. Defaults to 66.
-- user.scratch_high = 66

-- Autostart
------------
-- Using `spawn.once` only spawns items at the beginning of the running session, and
-- not on reloads. `spawn` does actually run not running items on reload. 
local awful = require('awful')

-- awful.spawn.once("picom")
-- awful.spawn.once("mpd")
-- awful.spawn.once("mpDris2")

-- EOF
------
return user
