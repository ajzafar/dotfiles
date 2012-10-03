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
local vicious = { force = vicious.force }

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
    local label = widget{ type = 'textbox' }
    local timebar = awful.widget.progressbar{ height = 9 }
    local volbar = awful.widget.progressbar()

    label.width = 125
    label.align = 'left'
    timebar:set_background_color(beautiful.widget_bg)
    timebar:set_color(beautiful.widget_fg)
    timebar:set_width(125)
    volbar:set_background_color(beautiful.widget_bg)
    volbar:set_color(beautiful.widget_fg)
    volbar:set_vertical(true)
    volbar:set_width(5)
    volbar:set_max_value(100)

    local widget = { { timebar, label,
                       layout = awful.widget.layout.vertical.flex },
                       volbar, layout = awful.widget.layout.horizontal.leftright, }
    -- I don't know.
    awful.widget.layout.margins[widget[1]] = { right = -120 }

    function widget.notify(updated)
        if not updated then
            vicious.force{widget}
        end
        args.notify()
    end
    widget.songid = -1

    if type(args.notify) == 'function' then
        add_onclick(widget, widget.notify)
    end

    return widget
end

function vicious_format(widget, args)
    local s = args.status or {}
    local elapsed, total = string.match(s.time or '0:0', '([%d]+):([%d]+)')

    widget[1][1]:set_value(elapsed / (total == 0 and 1 or total))

    widget[1][2].text = string.format('[%s/%s] ', args.elapsed, args.total_time)
    widget[1][2].text = widget[1][2].text .. (s['state'] == 'play' and '⟩' or '|') .. ' '
    widget[1][2].text = widget[1][2].text .. (s['repeat']  == '1' and 'r' or '')
    widget[1][2].text = widget[1][2].text .. (s['random']  == '1' and 'z' or '')
    widget[1][2].text = widget[1][2].text .. (s['single']  == '1' and 's' or '')
    widget[1][2].text = widget[1][2].text .. (s['consume'] == '1' and 'c' or '')

    widget[2]:set_value(s['volume'])

    if widget.songid ~= s['songid'] then
        widget.songid = s['songid'] or -1
        widget.notify(true)
    end
end

function vicious_worker(format, warg)
    local warg = warg or {}
    local mcon = warg.connection or mpd.new{warg}

    local data = { status = mcon:send('status'), song = mcon:send('currentsong') }

    data.elapsed = seconds_to_string(string.match(data.status.time or '0:0', '([%d]+):[%d]+') or 0)
    data.total_time = seconds_to_string(data.song.time or 0)

    return data
end
