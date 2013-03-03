local net = {}

local function cycle_idx(w)
    w.idx = w.idx + 1
    if w.idx > table.getn(w.ifaces) then
        w.idx = w.idx % table.getn(w.ifaces)
    end
    naughty.notify{ text = w.ifaces[w.idx] }
end

function net.new(args)
    local args   = args or {}
    local widget = wibox.layout.flex.vertical()
    local down   = wibox.layout.fixed.horizontal()
    local up     = wibox.layout.fixed.horizontal()

    widget.down_label = wibox.widget.textbox()
    widget.down_bar   = awful.widget.graph()
    widget.up_label   = wibox.widget.textbox()
    widget.up_bar     = awful.widget.graph()
    widget.idx        = 1
    widget.ifaces     = args.ifaces or { 'eth0', 'wlan0' }

    widget.down_bar:set_background_color(beautiful.widget_bg)
    widget.down_bar:set_color(beautiful.widget_fg)
    widget.down_bar:set_scale(true)
    widget.down_label:set_text('D 0 ')
    widget.up_bar:set_background_color(beautiful.widget_bg)
    widget.up_bar:set_color(beautiful.widget_fg)
    widget.up_bar:set_scale(true)
    widget.up_label:set_text('U 0 ')

    down:add(widget.down_label)
    down:add(widget.down_bar)
    up:add(widget.up_label)
    up:add(widget.up_bar)

    widget:add(down)
    widget:add(up)

    for i_,v_ in ipairs(widget) do
        for i,v in ipairs(v_) do
            local wid = v.widget or v
            wid:buttons(awful.button({}, 1, function() cycle_idx(widget); vicious.force{widget} end))
        end
    end

    return widget
end

function net.vicious_format(widget, args)
    local iface = widget.ifaces[widget.idx] or 'eth0'

    widget.down_label:set_text(string.format('D %04d ', args['{' .. iface .. ' down_kb}'] or 0))
    widget.down_bar:add_value(args['{eth0 down_kb}'])
    widget.up_label:set_text(string.format('U %04d ', args['{' .. iface .. ' up_kb}'] or 0))
    widget.up_bar:add_value(args['{eth0 up_kb}'])
end

return net
