local battery = {}

function battery.new(args)
    local args = args or {}
    local widget = wibox.layout.fixed.horizontal()
    widget.bar = awful.widget.progressbar()
    widget.label = wibox.widget.textbox()
    widget.time = ''

    widget.bar:set_color(beautiful.widget_fg)
    widget.bar:set_background_color(beautiful.widget_bg)
    widget.bar:set_vertical(true)
    widget.bar:set_width(5)
    widget.bar:set_max_value(100)

    widget:add(widget.label)
    widget:add(widget.bar)

    for i,v in ipairs(widget) do
        local wid = v.widget or v
        wid:buttons(awful.button({}, 1, function() naughty.notify{ text = widget.time } end))
    end

    return widget
end

local labels = {
    ["↯"] = "F ",
    ["⌁"] = "U ",
    ["+"] = "C ",
    ["-"] = "D "
}

function battery.vicious_format(widget, args)
    local percentage = args[2]

    widget.label:set_text(labels[args[1]])
    widget.bar:set_value(percentage)
    widget.time = args[3]

    if percentage < 10 then
        widget.bar:set_background_color('#ff0000')
    else
        widget.bar:set_background_color(beautiful.widget_bg)
    end
end

return battery
