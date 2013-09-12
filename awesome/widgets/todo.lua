local todo = {}

local function create_menu(items)
    local entries = {}
    local head = ''

    for i,line in ipairs(items) do
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

local function files_in(dir)
    if dir == nil or dir == '' then return {} end

    local files = {}
    for name in io.popen('ls "' .. dir .. '"'):lines() do
        table.insert(files, name)
    end

    return files
end

local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function items_in(dir, file, args)
    local args = args or {}
    args.colors = args.colors or {}
    args.colors.head = args.colors.head or ''
    args.colors.tail = args.colors.tail or ''
    local items = {}
    local file = file or '/dev/null'
    local count = args.countstart or 1

    if file_exists(dir .. file) then
        for l in io.lines(dir .. file) do
            local item = string.format('<span %s>%s</span>: ', args.colors.head, file)
            if args.count then
                item = item .. count .. ': '
                count = count + 1
            end
            item = item .. string.format('<span %s>%s</span>', args.colors.tail, l)
            table.insert(items, item)
        end
    else
        return { 'Unable to read file ' .. file }
    end

    return items
end

function todo.new(args)
    local args = args or {}
    local widget = wibox.widget.textbox()

    widget.idx    = 0
    widget.fidx   = 0
    widget.items  = {}
    widget.files  = {}
    widget.colors = args.colors
    widget.count  = args.number
    widget.dir    = args.dir

    -- label.width = 100
    widget:set_align('right')

    widget:buttons(awful.button({}, 1, function() vicious.force{widget} end))
    widget:buttons(awful.button({}, 3,
                        function()
                            if widget.menu and widget.menu.wibox.visible then
                                widget.menu:hide()
                            else
                                create_menu(widget)
                                widget.menu:show()
                            end
                        end))

    return widget
end

local function append(dest, src)
    for i,v in ipairs(src) do
        table.insert(dest, v)
    end
end

-- Taken from <http://www.gammon.com.au/forum/?id=9908>
local function shuffle(t)
    local n = #t

    while n >= 2 do
        local k = math.random(n)
        t[n], t[k] = t[k], t[n]
        n = n - 1
    end

    return t
end

function todo.vicious_worker(format, warg)
    if #warg.items < 3 then
        local files = files_in(warg.dir)
        local items = {}
        for i,file in ipairs(files) do
            append(items, items_in(warg.dir, file, { colors = warg.colors,
                                                     count = warg.count }))
        end
        append(warg.items, shuffle(items))
    end
    local text = warg.items[1]
    table.remove(warg.items, 1)

    return text or 'fail'
end

return todo
