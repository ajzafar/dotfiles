local awful = { widget = awful.widget }
local beautiful = beautiful
local io = { popen = io.popen }
local string = { match = string.match }

module('widgets.volume')

local function muted_channel(channel)
    local channel = channel or 'Master'

    local f = io.popen('amixer get ' .. channel)
    local mixer = f:read('*all') or ''
    f:close()

    return string.match(mixer, '%[([%l]*)%]') == 'off'
end

function new(args)
    local args = args or {}
    local b = awful.widget.progressbar()

    b:set_color(beautiful.widget_fg)
    b:set_background_color(beautiful.widget_bg)
    b:set_vertical(true)
    b:set_width(5)
    local function setval(w, val)
        b:set_value(val)
        b:set_color(muted_channel('Master') and '#365e92' or beautiful.widget_fg)
        b:set_background_color(muted_channel('Speaker') and '#13326c' or beautiful.widget_bg)
    end

    return { i, b, layout = awful.widget.layout.horizontal.leftright, set_value = setval }
end
