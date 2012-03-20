local awful = { widget = awful.widget }
local beautiful = beautiful

module('widgets.memory')

function new(args)
    local args = args or {}
    local ram = awful.widget.progressbar{ height = 9 }
    local swap = awful.widget.progressbar{ height = 9 }

    ram:set_background_color(beautiful.widget_bg)
    ram:set_color(beautiful.widget_fg)
    ram:set_max_value(100)
    swap:set_background_color(beautiful.widget_bg)
    swap:set_color(beautiful.widget_fg)
    swap:set_max_value(100)

    local widget = { ram, swap, layout = awful.widget.layout.vertical.flex }
    -- I'm not sure why this is needed, but without it the widget takes up more
    -- than it needs.
    awful.widget.layout.margins[widget] = { right = -100 }

    return widget
end

function vicious_format(widget, args)
    widget[1]:set_value(args[1]) -- Set RAM value
    widget[2]:set_value(args[5]) -- Set swap value
    return 1
end
