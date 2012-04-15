local awful = { widget = awful.widget, button = awful.button }
local beautiful = beautiful
local string = { format = string.format }
local widget = widget
local ipairs = ipairs
local table = { getn = table.getn }
local vicious = { force = vicious.force }
local naughty = { notify = naughty.notify }

module('widgets.net')

local ifaces = {}

local function cycle_idx(w)
    w.idx = w.idx + 1
    if w.idx > table.getn(ifaces) then
        w.idx = w.idx % table.getn(ifaces)
    end
    naughty.notify{ text = ifaces[w.idx] }
end

function new(args)
    local args = args or {}
    local down = { widget{ type = 'textbox' }, awful.widget.graph{ height = 9 },
                   layout = awful.widget.layout.horizontal.leftright }
    local up = { widget{ type = 'textbox' }, awful.widget.graph{ height = 9 },
                 layout = awful.widget.layout.horizontal.leftright }
    ifaces = args.ifaces or { 'eth0', 'wlan0' }

    down[2]:set_background_color(beautiful.widget_bg)
    down[2]:set_color(beautiful.widget_fg)
    down[2]:set_scale(true)
    down[1].text = 'D 0 '
    up[2]:set_background_color(beautiful.widget_bg)
    up[2]:set_color(beautiful.widget_fg)
    up[2]:set_scale(true)
    up[1].text = 'U 0 '

    local widget = { down, up, idx = 1, layout = awful.widget.layout.vertical.flex }
    -- I'm not sure why this is needed, but without it the next widget overlaps
    -- this one.
    awful.widget.layout.margins[widget] = { right = 30 }

    for i_,v_ in ipairs(widget) do
        for i,v in ipairs(v_) do
            local wid = v.widget or v
            wid:buttons(awful.button({}, 1, function() cycle_idx(widget); vicious.force{widget} end))
        end
    end

    return widget
end

function vicious_format(widget, args)
    local iface = ifaces[widget.idx] or 'eth0'
    widget[1][1].text = string.format('D %04d ', args['{' .. iface .. ' down_kb}'])
    widget[1][2]:add_value(args['{eth0 down_kb}'])
    widget[2][1].text = string.format('U %04d ', args['{' .. iface .. ' up_kb}'])
    widget[2][2]:add_value(args['{eth0 up_kb}'])

    return 1
end
