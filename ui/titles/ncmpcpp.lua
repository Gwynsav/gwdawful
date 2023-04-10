-----------------------
-- custom ncmpcpp ui --
-----------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local ruled     = require('ruled')
local gears     = require('gears')
local wibox     = require('wibox')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local playerctl = require('modules.bling').signal.playerctl.lib()

-- Widgets
----------
-- Draggable progressbar
local is_prog_hovered = false
local song_prog = wibox.widget {
    bar_color        = beautiful.lbg,
    bar_active_color = beautiful.cya,
    handle_color     = beautiful.cya_d,
    handle_shape     = helpers.mkroundedrect(),
    bar_shape        = helpers.mkroundedrect(),
    handle_width     = dpi(6),
    forced_height    = dpi(6),
    minimum          = 0,
    widget           = wibox.widget.slider,
}
-- This implementation makes it so that the current song progress 
-- will only be updated when the user hovers the progressbar.
song_prog:connect_signal('mouse::enter', function()
    is_prog_hovered = true
end)
song_prog:connect_signal('mouse::leave', function()
    is_prog_hovered = false
end)
song_prog:connect_signal('property::value', function(_, value)
    if is_prog_hovered then
        playerctl:set_position(value)
    end
end)

-- Album cover art
local cover_art = wibox.widget {
    image      = helpers.crop_surface(1, gears.surface.load_uncached(beautiful.player_bg)),
    clip_shape = helpers.mkroundedrect(),
    resize     = true,
    align      = "center",
    vertical_fit_policy   = "fit",
    horizontal_fit_policy = "fit",
    widget     = wibox.widget.imagebox
}

-- Song title and artist
local function infoline(default, size, color)
    return wibox.widget {
        {
            id     = 'text_role',
            markup = default,
            font   = beautiful.ui_font .. dpi(size),
            widget = wibox.widget.textbox
        },
        fg       = color,
        widget   = wibox.container.background,
        set_markup = function(self, content)
            self:get_children_by_id('text_role')[1].markup = content
        end
    }
end
local song_title  = infoline("<b>Nothing Playing</b>", 10, beautiful.nfg)
local song_artist = infoline("Unknown",                8,  beautiful.dfg)

-- Control buttons
local function ctrlbtn(icon, run)
    local ctrl_button = wibox.widget {
        {
            {
                id     = "text_role",
                text   = icon,
                font   = beautiful.ic_font .. dpi(13),
                widget = wibox.widget.textbox
            },
            margins = dpi(4),
            widget  = wibox.container.margin
        },
        fg      = beautiful.nfg,
        bg      = beautiful.titlebar_bg_focus,
        shape   = helpers.mkroundedrect(),
        widget  = wibox.container.background,
        buttons = {
            awful.button({}, 1, run)
        },
        set_text = function(self, content)
            self:get_children_by_id('text_role')[1].text = content
        end
    }
    helpers.add_hover(ctrl_button, beautiful.titlebar_bg_focus, beautiful.titlebar_fg_focus)
    return ctrl_button
end
local prev_btn = ctrlbtn("", function() playerctl:previous()          end)
local play_btn = ctrlbtn("", function() playerctl:play_pause()        end)
local next_btn = ctrlbtn("", function() playerctl:next()              end)
local shff_btn = ctrlbtn("", function() playerctl:cycle_shuffle()     end)
local loop_btn = ctrlbtn("", function() playerctl:cycle_loop_status() end)

-- Volume control
local is_vol_hovered = false
local vol_bar = wibox.widget {
    {
        {
            text   = "",
            align  = "center",
            font   = beautiful.ic_font .. dpi(13),
            widget = wibox.widget.textbox
        },
        fg     = beautiful.grn,
        widget = wibox.container.background
    },
    {
        {
            id                  = 'slider_role',
            bar_shape           = helpers.mkroundedrect(),
            bar_color           = beautiful.gry,
            bar_active_color    = beautiful.grn,
            handle_color        = beautiful.grn,
            handle_shape        = helpers.mkroundedrect(),
            minimum             = 0,
            maximum             = 100,
            handle_width        = dpi(10),
            bar_height          = dpi(6),
            forced_height       = dpi(10),
            forced_width        = dpi(6),
            widget              = wibox.widget.slider
        },
        top    = dpi(15),
        bottom = dpi(15),
        right  = dpi(15),
        widget = wibox.container.margin
    },
    spacing = dpi(8),
    layout  = wibox.layout.fixed.horizontal,
    get_slider = function(self)
        return self:get_children_by_id('slider_role')[1]
    end,
    set_value  = function(self, val)
        self.slider.value = val * 100
    end
}
vol_bar.slider:connect_signal('property::value', function(_, value)
    playerctl:set_volume(value / 100)
end)
vol_bar:connect_signal('mouse::enter', function()
    is_vol_hovered = true
end)
vol_bar:connect_signal('mouse::leave', function()
    is_vol_hovered = false
end)

-- Decorations
--------------
local top = function(c)
    awful.titlebar(c, { position = "top", 
                        size     = dpi(beautiful.titles_size), 
                        bg       = beautiful.titlebar_bg_focus }):setup {
        nil,
        nil,
        nil,
        buttons = {
            awful.button({}, 1, function()
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
            end),
            awful.button({}, 3, function()
                client.focus = c
                c:raise()
                awful.mouse.client.resize(c)
            end)
        },
        layout = wibox.layout.align.horizontal
    }
end

local bottom = function(c)
    awful.titlebar(c, { position = "bottom", 
                        size     = dpi(66), 
                        bg       = beautiful.titlebar_bg_focus }):setup {
        song_prog,
        {
            {
                {
                    cover_art,
                    {
                        {
                            song_title,
                            song_artist,
                            layout = wibox.layout.fixed.vertical
                        },
                        valign = "center",
                        widget = wibox.container.place
                    },
                    spacing = dpi(10),
                    layout  = wibox.layout.fixed.horizontal
                },
                {
                    {
                        loop_btn,
                        prev_btn,
                        play_btn,
                        next_btn,
                        shff_btn,
                        spacing = dpi(5),
                        layout  = wibox.layout.fixed.horizontal
                    },
                    margins = dpi(6),
                    widget  = wibox.container.margin
                },
                vol_bar,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(10),
            widget  = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical
    }
end

-- Signals
----------
-- Song progress.
playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    if player_name == "mpd" and interval_sec > 0 then
        song_prog.maximum = length_sec
        song_prog.value   = interval_sec
    end
end)
-- Song cover, title and artist.
playerctl:connect_signal("metadata", function(_, title, artist, album_path, _, _, player_name)
    if player_name == "mpd" then
        song_title.markup  = title:match('%w')  and "<b>" .. title .. "</b>" or "<b>Nothing Playing</b>"
        song_artist.markup = artist:match('%w') and artist                   or "Unknown"
        cover_art.image    = album_path:match('/') and 
                             helpers.crop_surface(1, gears.surface.load_uncached(album_path))
                             or helpers.crop_surface(1, gears.surface.load_uncached(beautiful.player_bg))
    end
end)
-- Playback status
playerctl:connect_signal("playback_status", function(_, playing, player_name)
    if player_name == "mpd" then
        play_btn.text = playing and "" or ""
    end
end)
-- Shuffle and Loop status colors
playerctl:connect_signal("shuffle", function(_, shuffle)
        shff_btn.fg = shuffle and beautiful.ylw or beautiful.fg_normal
end)
playerctl:connect_signal("loop_status", function(_, loop_status)
    if loop_status:match('none') then
        loop_btn.fg = beautiful.nfg
    elseif loop_status:match('track') then
        loop_btn.fg = beautiful.ylw
    else
        loop_btn.fg = beautiful.grn
    end
end)
-- Volume level
playerctl:connect_signal("volume", function(_, volume, player_name)
    if player_name == "mpd" then
        vol_bar.value  = not is_vol_hovered and volume
    end
end)

-- Apply
--------
local ncmpcpp_ui = function(c)
    -- Unbind default titlebar
    awful.titlebar.hide(c, beautiful.titles_position)

    -- Bind custom titlebars
    bottom(c)
    top(c)
end

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule({
        id       = "music",
        rule     = terminal == "tym" and { role  = "ncmpcpp" } 
                   or { class = "ncmpcpp" }, 
        callback = ncmpcpp_ui
    })
end)
