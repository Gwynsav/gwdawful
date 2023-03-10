-----------------------------
-- playerctl notifications --
-----------------------------

-- Imports
----------
local naughty   = require('naughty')
local beautiful = require('beautiful')
local bling     = require('modules.bling')
local playerctl = bling.signal.playerctl.lib()

-- Notifications
----------------
-- Sends a notification every time the playerctl song changes.
local timeout    = 3
local info_first = true
playerctl:connect_signal("metadata",
                       function(_, title, artist, album_path, album, new, player_name)
    if info_first then
        info_first = false
    else
        local info_notif = naughty.notify({
            title   = title:match('.+') or "Nothing Playing", 
            text    = "by " .. artist:match('.+') or "Unknown", 
            image   = album_path:match('/') and album_path or beautiful.player_bg,
            timeout = timeout
        }, info_notif)
    end
end)
