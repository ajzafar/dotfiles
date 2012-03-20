require('lib.mpd')

local awful = { widget = awful.widget, button = awful.button }
local beautiful = beautiful
local ipairs = ipairs
local mpd = { new = mpd.new }
local string = { match = string.match }
local timer = timer
local type = type
local widget = widget

module('widgets.mpd')

-- This is a very ugly, rudimentary MPD widget. At some point it'll be pretty.

function new(args)
    local args = args or {}
    local mcon = args.connection or mpd.new(args)
    local label = widget{ type = 'textbox' }
    local timebar = awful.widget.progressbar{ height = 9 }
    local volbar = awful.widget.progressbar()

    label.width = 35
    label.align = 'center'
    timebar:set_background_color(beautiful.widget_bg)
    timebar:set_color(beautiful.widget_fg)
    volbar:set_background_color(beautiful.widget_bg)
    volbar:set_color(beautiful.widget_fg)
    volbar:set_vertical(true)
    volbar:set_width(5)
    volbar:set_max_value(100)

    local function update()
        local s = mcon:send('status')

        label.text = s['state'] == 'play' and '>' or '|'
        label.text = label.text .. (s['random']  == '1' and 'z' or '-')
        label.text = label.text .. (s['repeat']  == '1' and 'r' or '-')
        label.text = label.text .. (s['single']  == '1' and 's' or '-')
        label.text = label.text .. (s['consume'] == '1' and 'c' or '-')

        if s.time then
            local elapsed, total = string.match(s.time, '([%d]+):([%d]+)')
            timebar:set_value(elapsed / total)
        else
            timebar:set_value(0)
        end

        volbar:set_value(s['volume'])
    end

    local timer = timer{ timeout = 11 }
    timer:add_signal('timeout', update)
    timer:start()
    update()
    local widget = { timebar, label, volbar, layout = awful.widget.layout.horizontal.leftright }

    if type(args.onclick) == 'function' then
        for i,v in ipairs(widget) do
            local wid = v.widget or v
            wid:buttons(awful.button({}, 1, args.onclick))
        end
    end

    return widget
end
