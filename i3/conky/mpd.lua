file = file or ''

function conky_cursong()
    local info = {}

    for i,v in ipairs{'artist', 'album', 'title', 'track', 'file'} do
        info[v] = conky_parse('$mpd_' .. v)
    end

    if info['file'] ~= file then
        file = info['file']
        os.execute(pango_escape(string.format("notify-send '%s' '%s\n%s: %s'",
                info['artist'], info['album'], info['track'], info['title'])))
    end

    return ''
end

function pango_escape(str)
    return str:gsub('&', '&amp;')
end
