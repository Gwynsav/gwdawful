------------------------
-- Client Decorations --
------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local gears     = require('gears')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

local title_size = 25
local spacing    = 6

-- Buttons
----------
local mkbutton = function (width, color, onclick)
  return function(c)
    local button = wibox.widget {
      wibox.widget.textbox(),
      forced_width  = dpi(width),
      forced_height = dpi(title_size),
      bg            = beautiful.titlebar_bg_normal,
      shape         = helpers.mkroundedrect(0),
      widget        = wibox.container.background
    }

    local color_transition = helpers.apply_transition {
      element   = button,
      prop      = 'bg',
      bg        = beautiful.titlebar_bg_normal,
      hbg       = beautiful.titlebar_fg_normal,
    }

    client.connect_signal("property::active", function()
      if c.active then
        color_transition.off()
      else
        color_transition.on()
      end
    end)

    button:add_button(awful.button({}, 1, function()
      if onclick then
        onclick(c)
      end
    end))

    return button
  end
end

local close = mkbutton(33, beautiful.red, function(c)
    c:kill()
end)

local maximize = mkbutton(7, beautiful.ylw, function(c)
    c.maximized = not c.maximized
end)

local minimize = mkbutton(7, beautiful.ylw, function(c)
    gears.timer.delayed_call(function()
        c.minimized = not c.minimized
    end)
end)

local sticky = mkbutton(7, beautiful.grn, function(c)
    c.sticky = not c.sticky
end)

-- Titlebars
------------
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

    if c.requests_no_titlebar then
        return
    end
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    local n_titlebar = awful.titlebar(c, {
        size     = title_size,
        position = beautiful.titles_position,
    })
    n_titlebar.widget = {
        {
            {
                { -- Start
                    close(c),
                    maximize(c),
                    minimize(c),
                    spacing = dpi(spacing),
                    layout  = wibox.layout.fixed.horizontal
                },
                { -- Middle
                    buttons = buttons,
                    layout  = wibox.layout.fixed.horizontal
                },
                { -- End
                    sticky(c),
                    spacing = dpi(spacing),
                    layout  = wibox.layout.fixed.horizontal
                },
                spacing = dpi(spacing),
                layout  = wibox.layout.align.horizontal
            },
            direction =
               (beautiful.titles_inverted and beautiful.titles_type == "vertical")     and "west"  or
               (not beautiful.titles_inverted and beautiful.titles_type == "vertical") and "east"  or
               (beautiful.titles_inverted and beautiful.titles_type == "horizontal")   and "south" or
               "north",
            widget    = wibox.container.rotate
        },
        margins = dpi(9),
        widget  = wibox.container.margin
    }
end)
