local disk = {}

local function cycle_idx(w)
    w.idx = w.idx + 1
    if w.idx > table.getn(w.mounts) then
        w.idx = w.idx % table.getn(w.mounts)
    end
end

local function create_menu(widget)
    local entries = {}

    for i,data in ipairs(widget.menu_data) do
        table.insert(entries,
                     { string.format("%s\t%s/%s",
                                     widget.mounts[i], data.used, data.size),
                       function()
                           widget.idx = i - 1
                           vicious.force{widget}
                       end })
    end

    widget.menu = awful.menu({ items = entries })
end

function disk.new(args)
    local args = args or {}
    local widget = wibox.layout.flex.vertical()

    widget.label     = wibox.widget.textbox()
    widget.bar       = awful.widget.progressbar()
    widget.mounts    = args.mounts or { '/' }
    widget.idx       = 0
    widget.menu_data = {}

    -- label.width = 100
    widget.label:set_align('left')
    widget.bar:set_background_color(beautiful.widget_bg)
    widget.bar:set_color(beautiful.widget_fg)

    widget:add(widget.bar)
    widget:add(widget.label)

    for i,v in ipairs{widget.label, widget.bar} do
        local wid = v.widget or v
        wid:buttons(awful.button({}, 1, function() vicious.force{widget} end))
        wid:buttons(awful.button({}, 3,
                    function()
                        if widget.menu and widget.menu.wibox.visible then
                            widget.menu:hide()
                        else
                            create_menu(widget)
                            widget.menu:show()
                        end
                    end))
    end

    return widget
end

function disk.vicious_format(widget, args)
    cycle_idx(widget)

    local mount = widget.mounts[widget.idx] or '/'
    local used, size = args['{' .. mount .. ' used_gb}'] or 0,
                       args['{' .. mount .. ' size_gb}'] or 1

    widget.bar:set_value(used / size)
    widget.label:set_text(string.format('%s %0.1f/%0.1f', mount, used, size))

    for i,m in ipairs(widget.mounts) do
        widget.menu_data[i] = {}
        widget.menu_data[i].used = args['{' .. m .. ' used_gb}'] or 0
        widget.menu_data[i].size = args['{' .. m .. ' size_gb}'] or 1
    end
end

return disk
