file = file or ''

function conky_cursong()
    local info = {}
    for i,v in ipairs{'artist', 'album', 'title', 'track', 'file'} do
        info[v] = conky_parse('$mpd_' .. v)
    end

    if info['file'] ~= file then
        file = info['file']
        os.execute('notify-send ' .. string.format("'%s' '%s\n%s: %s'",
                info['artist'], info['album'], info['track'], info['title']))
    end

    return ''
end