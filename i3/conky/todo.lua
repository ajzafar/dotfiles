todo = {}
todo.idx = 0
todo.fidx = 0
todo.items = {}
todo.dir = os.getenv('HOME') .. '/Dropbox/todo/'

function files_in(dir)
    if dir == nil or dir == '' then return {} end

    local files = {}
    for name in io.popen('ls "' .. dir .. '"'):lines() do
        table.insert(files, name)
    end

    return files
end

function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function items_in(dir, file)
    local items = {}
    local file = file or '/dev/null'

    if file_exists(dir .. file) then
        for l in io.lines(dir .. file) do
            local item = string.format(file .. ': ')
            item = item .. l
            table.insert(items, item)
        end
    else
        return { 'Unable to read file ' .. file }
    end

    return items
end

function append(dest, src)
    for i,v in ipairs(src) do
        table.insert(dest, v)
    end
end

-- Taken from <http://www.gammon.com.au/forum/?id=9908>
function shuffle(t)
    local n = #t

    while n >= 2 do
        local k = math.random(n)
        t[n], t[k] = t[k], t[n]
        n = n - 1
    end

    return t
end

function conky_todo()
    if #todo.items < 3 then
        local files = files_in(todo.dir)
        local items = {}
        for i,file in ipairs(files) do
            append(items, items_in(todo.dir, file))
        end
        append(todo.items, shuffle(items))
    end

    if todo.current == nil or conky_parse('${updates}') % 13 == 0 then
        todo.current = todo.items[1]
        table.remove(todo.items, 1)
    end

    return todo.current or 'fail'
end
