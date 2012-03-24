local awful = { widget = awful.widget, button = awful.button }
local beautiful = beautiful
local ipairs = ipairs
local string = { format = string.format }
local table = { getn = table.getn }
local vicious = { force = vicious.force }
local widget = widget

module('widgets.disk')

-- FIXME: This should be a part of the widget table
-- For some reason, storing it in the table doesn't work. After the first
-- update, the table seems to be...empty
local mounts = {}

local function cycle_idx(w)
    w.idx = w.idx + 1
    if w.idx > table.getn(mounts) then
        w.idx = w.idx % table.getn(mounts)
    end
end

function new(args)
    local args = args or {}
    local label = widget{ type = 'textbox' }
    local bar = awful.widget.progressbar{ height = 9 }
    mounts = args.mounts or { '/' }

    label.width = 100
    label.align = 'left'
    bar:set_background_color(beautiful.widget_bg)
    bar:set_color(beautiful.widget_fg)

    local widget = { bar, label, idx = 0, layout = awful.widget.layout.vertical.flex }
    -- I have no idea
    awful.widget.layout.margins[widget] = { right = -118 }

    for i,v in ipairs(widget) do
        local wid = v.widget or v
        wid:buttons(awful.button({}, 1, function() vicious.force{widget} end))
    end

    return widget
end

function vicious_format(widget, args)
    cycle_idx(widget)

    local mount = mounts[widget.idx] or '/'
    local used, size = args['{' .. mount .. ' used_gb}'] or 0,
                       args['{' .. mount .. ' size_gb}'] or 1
    widget[1]:set_value(used / size)
    widget[2].text = string.format('%s %0.1f/%0.1f', mount, used, size)
end
