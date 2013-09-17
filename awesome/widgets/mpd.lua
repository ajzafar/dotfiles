local wmpd = {}

-- This is a very ugly, rudimentary MPD widget. At some point it'll be pretty.

local function add_onclick(w, func)
end

local function seconds_to_string(sec)
    local t = os.date("*t", sec)
    return string.format("%d:%02d", t.min, t.sec)
end

function wmpd.new(args)
    local args      = args or {}
    local widget    = wibox.layout.align.horizontal()
    widget.time     = wibox.widget.textbox()
    widget.flags    = wibox.widget.textbox()
    widget.progress = awful.widget.progressbar()
    widget.volume   = awful.widget.progressbar()
    widget.bottom   = wibox.layout.fixed.horizontal()
    widget.vertical = wibox.layout.flex.vertical()

    widget.time:set_align('left')
    widget.time:set_text('[0:00/0:00]')

    widget.flags:set_align('left')
    widget.flags:set_text('|')

    widget.progress:set_background_color(beautiful.widget_bg)
    widget.progress:set_color(beautiful.widget_fg)

    widget.volume:set_background_color(beautiful.widget_bg)
    widget.volume:set_color(beautiful.widget_fg)
    widget.volume:set_vertical(true)
    widget.volume:set_width(5)
    widget.volume:set_max_value(100)

    widget.bottom:add(widget.time)
    widget.bottom:add(widget.flags)
    widget.vertical:add(widget.progress)
    widget.vertical:add(widget.bottom)
    widget:set_middle(widget.vertical)
    widget:set_right(widget.volume)

    function widget.notify(updated)
        if not updated then
            vicious.force{widget}
        end
        args.notify()
    end
    widget.songid = -1

    for i,v in ipairs{ widget.time, widget.progress, widget.flags, widget.volume } do
        local wid = v.widget or v
        wid:buttons(awful.button({}, 1, widget.notify))
    end

    return widget
end

function wmpd.vicious_format(widget, args)
    local s = args.status or {}
    local elapsed, total = string.match(s.time or '0:0', '([%d]+):([%d]+)')

    widget.time:set_text(string.format('[%s/%s] ', args.elapsed, args.total_time))
    widget.progress:set_value(elapsed / (total == 0 and 1 or total))
    widget.volume:set_value(s['volume'])
    widget.flags:set_text(string.format('%s %s%s%s%s',
                          s['state'] == 'play' and '⟩' or '|',
                          s['repeat']  == '1' and 'r' or '',
                          s['random']  == '1' and 'z' or '',
                          s['single']  == '1' and 's' or '',
                          s['consume'] == '1' and 'c' or ''))

    if widget.songid ~= s['songid'] then
        widget.songid = s['songid'] or -1
        widget.notify(true)
    end
end

function wmpd.vicious_worker(format, warg)
    local warg = warg or {}
    local mcon = warg.connection or mpd.new{warg}

    local data = { status = mcon:send('status'), song = mcon:send('currentsong') }

    data.elapsed = seconds_to_string(string.match(data.status.time or '0:0', '([%d]+):[%d]+') or 0)
    data.total_time = seconds_to_string(data.song.time or 0)

    return data
end

return wmpd
