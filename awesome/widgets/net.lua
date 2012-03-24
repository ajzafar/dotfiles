local awful = { widget = awful.widget }
local beautiful = beautiful
local string = { format = string.format }
local widget = widget

module('widgets.net')

function new(args)
    local args = args or {}
    local down = { widget{ type = 'textbox' }, awful.widget.graph{ height = 9 },
                   layout = awful.widget.layout.horizontal.leftright }
    local up = { widget{ type = 'textbox' }, awful.widget.graph{ height = 9 },
                 layout = awful.widget.layout.horizontal.leftright }
    local iface = 'eth0'

    down[2]:set_background_color(beautiful.widget_bg)
    down[2]:set_color(beautiful.widget_fg)
    down[2]:set_scale(true)
    down[1].text = 'D 0 '
    up[2]:set_background_color(beautiful.widget_bg)
    up[2]:set_color(beautiful.widget_fg)
    up[2]:set_scale(true)
    up[1].text = 'U 0 '

    local widget = { down, up, layout = awful.widget.layout.vertical.flex }
    -- I'm not sure why this is needed, but without it the next widget overlaps
    -- this one.
    awful.widget.layout.margins[widget] = { right = 30 }
    return widget
end

function vicious_format(widget, args)
    widget[1][1].text = string.format('D %04d ', args['{eth0 down_kb}'])
    widget[1][2]:add_value(args['{eth0 down_kb}'])
    widget[2][1].text = string.format('U %04d ', args['{eth0 up_kb}'])
    widget[2][2]:add_value(args['{eth0 up_kb}'])

    return 1
end
