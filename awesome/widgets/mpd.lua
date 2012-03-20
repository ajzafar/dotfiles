require('lib.mpd')

local awful = { widget = awful.widget, button = awful.button }
local beautiful = beautiful
local ipairs = ipairs
local mpd = { new = mpd.new }
local os = { date = os.date }
local string = { match = string.match, format = string.format }
local timer = timer
local type = type
local widget = widget

module('widgets.mpd')

-- This is a very ugly, rudimentary MPD widget. At some point it'll be pretty.

local function add_onclick(widget, func)
    for i,v in ipairs(widget) do
        if type(v) == 'table' and not v.widget then
            add_onclick(v, func)
        else
            local wid = v.widget or v
            wid:buttons(awful.button({}, 1, func))
        end
    end
end

local function seconds_to_string(sec)
    local t = os.date("*t", sec)
    return string.format("%d:%02d", t.min, t.sec)
end

function new(args)
    local args = args or {}
    local mcon = args.connection or mpd.new(args)
    local label = widget{ type = 'textbox' }
    local timebar = awful.widget.progressbar{ height = 9 }
    local volbar = awful.widget.progressbar()

    label.width = 100
    label.align = 'left'
    timebar:set_background_color(beautiful.widget_bg)
    timebar:set_color(beautiful.widget_fg)
    volbar:set_background_color(beautiful.widget_bg)
    volbar:set_color(beautiful.widget_fg)
    volbar:set_vertical(true)
    volbar:set_width(5)
    volbar:set_max_value(100)

    local function update()
        local s = mcon:send('status')
        local elapsed, total = string.match(s.time or '0:0', '([%d]+):([%d]+)')
        label.text = string.format("[%s/%s] ", seconds_to_string(elapsed or 0),
                                               seconds_to_string(total or 0))

        timebar:set_value(elapsed / (total == 0 and 1 or total))

        label.text = label.text .. (s['state'] == 'play' and '⟩' or '|') .. ' '
        label.text = label.text .. (s['repeat']  == '1' and 'r' or '')
        label.text = label.text .. (s['random']  == '1' and 'z' or '')
        label.text = label.text .. (s['single']  == '1' and 's' or '')
        label.text = label.text .. (s['consume'] == '1' and 'c' or '')

        volbar:set_value(s['volume'])
    end

    local timer = timer{ timeout = 11 }
    timer:add_signal('timeout', update)
    timer:start()
    update()
    local widget = { { timebar, label,
                       layout = awful.widget.layout.vertical.flex },
                     volbar, layout = awful.widget.layout.horizontal.leftright }
    -- I don't know.
    awful.widget.layout.margins[widget[1]] = { right = -95 }

    if type(args.onclick) == 'function' then
        add_onclick(widget, args.onclick)
    end

    return widget
end
