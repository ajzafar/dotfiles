local awful = { widget = awful.widget }
local beautiful = beautiful

module('widgets.cpu')

function new(args)
    local args = args or {}
    local bar = awful.widget.graph()

    bar:set_background_color(beautiful.widget_bg)
    bar:set_color(beautiful.widget_fg)

    local function addval(widget, val)
        widget[1]:add_value(val)
    end

    return { bar, add_value = addval, layout = awful.widget.layout.horizontal.leftright }
end
