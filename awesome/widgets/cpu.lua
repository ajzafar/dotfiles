local cpu = {}

function cpu.new(args)
    local args = args or {}
    local widget = wibox.layout.mirror()
    widget.graph = awful.widget.graph()

    widget:set_reflection{ vertical = true }
    widget.graph:set_background_color(beautiful.widget_bg)
    widget.graph:set_color(beautiful.widget_fg)

    function widget.add_value(widget, val)
        widget.graph:add_value(val)
    end

    widget:set_widget(widget.graph)

    return widget
end

return cpu
