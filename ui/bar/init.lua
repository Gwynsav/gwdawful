-----------------------
-- bar configuration --
-----------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local gettags   = require('ui.bar.modules.tags')
local gettasks  = require('ui.bar.modules.tasks')
local getlayout = require('ui.bar.modules.layout')
local launcher  = require('ui.app_launcher')

local bar_size  = 40
local icon_size = 13
local font_size = 11

-- Bar Widgets
--------------
-- Awesome launcher button
local bar_dash = wibox.widget { 
    {
        {
            {
                image      = beautiful.awesome_icon,
                clip_shape = helpers.mkroundedrect(0), 
                widget     = wibox.widget.imagebox 
            },
            margins = dpi(6),
            widget  = wibox.container.margin
        },
        align  = "center",
        widget = wibox.container.place
    },
    bg     = beautiful.lbg,
    shape  = helpers.mkroundedrect(),
    forced_height = dpi(bar_size),
    forced_width  = dpi(bar_size),
    widget = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            awesome.emit_signal('widget::dashboard')
        end)
    },
}
helpers.add_hover(bar_dash, beautiful.lbg, beautiful.blk)

-- Application Launcher
local bar_launcher = wibox.widget {
    {
        {
            text    = "",
            font    = beautiful.ic_font .. dpi(icon_size),
            align   = "center",
            widget  = wibox.widget.textbox
        },
        margins = dpi(5),
        widget  = wibox.container.margin
    },
    bg      = beautiful.lbg,
    shape   = helpers.mkroundedrect(),
    forced_height = dpi(bar_size),
    forced_width  = dpi(bar_size),
    widget  = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            launcher:toggle()
        end)
    }
}
helpers.add_hover(bar_launcher, beautiful.lbg, beautiful.blk)

-- Status icons
local function status_widget(button)
    local status = wibox.widget {
        {
            {
                id      = "text_role",
                font    = beautiful.ic_font .. dpi(icon_size),
                align   = "center",
                widget  = wibox.widget.textbox,
            },
            margins = dpi(3),
            widget  = wibox.container.margin
        },
        bg     = beautiful.nbg,
        shape  = helpers.mkroundedrect(),
        widget = wibox.container.background,
        buttons = {
            awful.button({}, 1, button)
        },
        set_text = function(self, content)
            self:get_children_by_id('text_role')[1].text = content
        end
    }
    helpers.add_hover(status, beautiful.nbg, beautiful.lbg)
    return status
end

local bar_btn_sound = status_widget(function() awesome.emit_signal("volume::mute") end) 
local bar_btn_net   = status_widget() 
local bar_btn_blue  = status_widget(function() awesome.emit_signal("bluetooth::toggle") end) 

-- Battery bar
local bar_battery_prog = wibox.widget {
    max_value        = 100,
    forced_width     = dpi(50),
    clip             = true,
    shape            = helpers.mkroundedrect(),
    bar_shape        = helpers.mkroundedrect(),
    background_color = beautiful.bg_focus,
    border_color     = beautiful.bg_focus,
    border_width     = dpi(4),
    color            = {
       type  = "linear",
       from  = { dpi(bar_size), 0 },
       to    = { 0, 0 },
       stops = { { 0, beautiful.grn }, { 1, beautiful.grn_d } }
    },
    widget           = wibox.widget.progressbar
}
local flipped_battery = wibox.widget {
    bar_battery_prog,
    direction = "east",
    widget    = wibox.container.rotate
}
local bar_battery_text = wibox.widget {
    {
        id      = "text_role",
        font    = beautiful.ic_font .. dpi(icon_size),
        align   = "center",
        widget  = wibox.widget.textbox,
    },
    margins = dpi(3),
    widget  = wibox.container.margin,
    set_text = function(self, content)
        self:get_children_by_id('text_role')[1].text = content
    end
}

-- The actual systray
local systray     = wibox.widget {
    {
        horizontal  = beautiful.bar_type == "horizontal",
        base_size   = dpi(20),
        widget      = wibox.widget.systray
    },
    align   = "center",
    visible = false,
    layout  = wibox.container.place
}
local systray_btn = wibox.widget { 
    {
        {
            text    = "",
            font    = beautiful.ic_font .. dpi(16),
            align   = "center",
            widget  = wibox.widget.textbox,
        },
        direction   = beautiful.bar_type == "vertical" and "east" or "south",
        widget      = wibox.container.rotate
    },
    bg     = beautiful.nbg,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            systray.visible = not systray.visible
        end)
    }
}
helpers.add_hover(systray_btn, beautiful.nbg, beautiful.lbg)

-- Create a textclock widget
local vbar_clock = {
    {
        {
            {
                format = '<b>%H</b>',
                font   = beautiful.mn_font .. dpi(font_size),
                halign = "center",
                widget = wibox.widget.textclock
            },
            {
                {
                    format = '<b>%M</b>',
                    font   = beautiful.mn_font .. dpi(font_size),
                    halign = "center",
                    widget = wibox.widget.textclock
                },
                fg     = beautiful.dfg,
                widget = wibox.container.background
            },
            layout  = wibox.layout.fixed.vertical
        },
        margins = dpi(5),
        widget  = wibox.container.margin
    },
    bg     = beautiful.lbg,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background
}
local hbar_clock = {
    {
        {
            format = '<b>%H:%M</b>',
            font   = beautiful.mn_font .. dpi(font_size),
            valign = "center",
            widget = wibox.widget.textclock
        },
        left   = dpi(8),
        right  = dpi(8),
        bottom = dpi(5), 
        top    = dpi(5), 
        widget = wibox.container.margin
    },
    bg     = beautiful.lbg,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background
}

-- Awesome Bar
--------------
-- Bar length handling to switch between gapped and non-gapped modes.
local bar_length = beautiful.bar_type == "horizontal" and dpi(1920)
                                                      or dpi(1080)

-- The actual bar itself
screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])

    local taglist_v = wibox.widget {
        {
            gettags(s),
            margins = dpi(font_size),
            widget  = wibox.container.margin
        },
        shape   = helpers.mkroundedrect(),
        bg      = beautiful.lbg,
        widget  = wibox.container.background
    }
    local taglist_h = wibox.widget {
        taglist_v,
        direction   = "east",
        widget      = wibox.container.rotate
    }
    s.mywibox = awful.wibar {
        visible  = beautiful.bar_enabled,
        position = beautiful.bar_position,
        screen   = s,
        width    = beautiful.bar_type == "horizontal" and dpi(bar_length) or dpi(bar_size),
        height   = beautiful.bar_type == "horizontal" and dpi(bar_size) or dpi(bar_length),
        widget   = {
            {
                { -- Top Widgets
                    bar_dash,
                    beautiful.bar_type == "horizontal" and taglist_h or taglist_v,
                    spacing = dpi(5),
                    layout  = beautiful.bar_type == "horizontal" and wibox.layout.fixed.horizontal
                                                                 or wibox.layout.fixed.vertical,
                },
                { -- Middle Widgets
                    gettasks(s),
                    align  = "center",
                    widget = wibox.container.place
                },
                { -- Bottom Widgets
                    systray, 
                    systray_btn,
                    bar_launcher,
                    {
                        beautiful.bar_type == "horizontal" and bar_battery_prog or flipped_battery,
                        {
                            bar_battery_text,
                            fg     = beautiful.bg_normal,
                            widget = wibox.container.background
                        },
                        visible = beautiful.battery_enabled,
                        layout = wibox.layout.stack
                    },
                    beautiful.bar_type == "horizontal" and hbar_clock or vbar_clock,
                    {
                        bar_btn_sound,
                        {
                            bar_btn_blue,
                            visible = beautiful.bluetooth_enabled,
                            widget  = wibox.container.background
                        },
                        bar_btn_net,
                        layout  = beautiful.bar_type == "horizontal" and wibox.layout.fixed.horizontal
                                                                     or wibox.layout.fixed.vertical
                    },
                    {
                        {
                            getlayout(s),
                            margins = dpi(6),
                            widget  = wibox.container.margin
                        },
                        bg      = beautiful.lbg,
                        shape   = helpers.mkroundedrect(),
                        widget  = wibox.container.background
                    },
                    spacing = dpi(5),
                    layout  = beautiful.bar_type == "horizontal" and wibox.layout.fixed.horizontal
                                                                 or wibox.layout.fixed.vertical,
                },
                layout = beautiful.bar_type == "horizontal" and wibox.layout.align.horizontal
                                                            or wibox.layout.align.vertical
            },
            left    = beautiful.bar_type == "horizontal" and dpi(font_size)
                                                         or dpi(6),
            right   = beautiful.bar_type == "horizontal" and dpi(font_size)
                                                         or dpi(6),
            top     = beautiful.bar_type == "horizontal" and dpi(6)
                                                         or dpi(font_size),
            bottom  = beautiful.bar_type == "horizontal" and dpi(6)
                                                         or dpi(font_size),
            widget  = wibox.container.margin
        }
    }
end)

-- Signal Connections
---------------------
-- Toggle bar
awesome.connect_signal("widget::bar", function()
    local s = awful.screen.focused()
    s.mywibox.visible = not s.mywibox.visible
end)

-- Battery signal
if beautiful.battery_enabled then
    awesome.connect_signal("signal::battery", function(level, state, _, _, _)
        bar_battery_prog.value  = level
        -- 2 stands for discharging. For more information refer to:
        -- https://lazka.github.io/pgi-docs/UPowerGlib-1.0/enums.html#UPowerGlib.DeviceState
        if state ~= 2 then
            bar_battery_text.text = ""
            bar_battery_text.font = beautiful.ic_font .. dpi(icon_size)
        else
            bar_battery_text.text = level
            bar_battery_text.font = beautiful.ui_font .. "Bold " .. dpi(icon_size)
        end
    end)
end

-- Sound signal
awesome.connect_signal("signal::volume", function(volume, muted)
    if muted then
        bar_btn_sound.text    = ""
        bar_btn_sound.visible = true
    else
        bar_btn_sound.visible = false
    end
end)
-- Networking signals
if beautiful.bluetooth_enabled then
    awesome.connect_signal("signal::bluetooth", function(is_enabled)
        if is_enabled then
            bar_btn_blue.text   = ""
            bar_btn_blue.visible = true
        else
            bar_btn_blue.visible = false
        end
    end)
end
awesome.connect_signal("signal::network", function(is_enabled)
    bar_btn_net.text   = is_enabled and "" or ""
end)
