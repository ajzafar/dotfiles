local awful = { widget = awful.widget,
                button = awful.button }
local beautiful = beautiful
local ipairs = ipairs
local naughty = { notify = naughty.notify }
local widget = widget

module('widgets.battery')

function new(args)
    local args = args or {}
    local b = awful.widget.progressbar()
    local t = widget{ type = 'textbox' }

    b:set_color(beautiful.widget_fg)
    b:set_background_color(beautiful.widget_bg)
    b:set_vertical(true)
    b:set_width(5)
    b:set_max_value(100)
    t.width = 12

    local widget = { t, b, layout = awful.widget.layout.horizontal.leftright, time = '' }

    for i,v in ipairs(widget) do
        local wid = v.widget or v
        wid:buttons(awful.button({}, 1, function() naughty.notify{ text = widget.time } end))
    end

    return widget
end

local labels = {
    ["↯"] = "F",
    ["⌁"] = "U",
    ["+"] = "C",
    ["-"] = "D"
}

function vicious_format(widget, args)
    local percentage = args[2]

    widget[1].text = labels[args[1]]
    widget[2]:set_value(percentage)
    widget.time = args[3]

    if percentage < 10 then
        widget[2]:set_background_color('#ff0000')
    else
        widget[2]:set_background_color(beautiful.widget_bg)
    end
end
