local volume = {}

local function muted_channel(channel)
    local channel = channel or 'Master'

    local f = io.popen('amixer get ' .. channel .. ' 2> /dev/null')
    local mixer = f:read('*all') or ''
    f:close()

    return string.match(mixer, '%[([%l]*)%]') == 'off'
end

function volume.new(args)
    local args = args or {}
    local widget = wibox.layout.fixed.horizontal()
    widget.bar = awful.widget.progressbar()

    widget.bar:set_color(beautiful.widget_fg)
    widget.bar:set_background_color(beautiful.widget_bg)
    widget.bar:set_vertical(true)
    widget.bar:set_width(5)

    widget:add(widget.bar)

    function widget.set_value(w, val)
        w.bar:set_value(val)
        w.bar:set_color(muted_channel('Master') and '#365e92' or beautiful.widget_fg)
        w.bar:set_background_color(muted_channel('Speaker') and '#13326c' or beautiful.widget_bg)
    end

    return widget
end

return volume
