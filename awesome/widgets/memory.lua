local memory = {}

function memory.new(args)
    local args   = args or {}
    local widget = wibox.layout.flex.vertical()
    widget.ram   = awful.widget.progressbar()
    widget.swap  = awful.widget.progressbar()

    widget.ram:set_background_color(beautiful.widget_bg)
    widget.ram:set_color(beautiful.widget_fg)
    widget.ram:set_max_value(100)
    widget.swap:set_background_color(beautiful.widget_bg)
    widget.swap:set_color(beautiful.widget_fg)
    widget.swap:set_max_value(100)

    widget:add(widget.ram)
    widget:add(widget.swap)

    return widget
end

function memory.vicious_format(widget, args)
    widget.ram:set_value(args[1])
    widget.swap:set_value(args[5])
end

return memory
