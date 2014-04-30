file = file or ''

function conky_cursong()
    local info = {}

    for i,v in ipairs{'artist', 'album', 'title', 'track', 'file'} do
        info[v] = conky_parse('$mpd_' .. v)
    end

    if info['file'] ~= '(null)' and info['file'] ~= file then
        file = info['file']
        os.execute(string.format([[notify-send '%s' '%s\n%s: %s']],
                escape_quote(info['artist']),
                escape_quote(info['album']),
                info['track'],
                escape_quote(info['title'])))
    end

    return ''
end

function pango_escape(str)
    return str:gsub('&', '&amp;')
end

function escape_quote(str)
    return str:gsub("'", "'\\''")
end
