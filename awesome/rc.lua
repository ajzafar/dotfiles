-- Like my zsh config, I keep my Awesome config modular. Organizationally,
-- I find this easier to work with. Additionally this makes errors in my config
-- easier to debug as I don't have to keep switching to console to see the
-- message. Lastly, I can modify one file and, in most cases, simply rerun
-- awefile('thefile.lua') for the changes to take effect.

require('awful')
require('awful.autofocus')
require('awful.rules')
require('beautiful')
require('naughty')

require('vicious')
require('lib.mpd')

confdir            = awful.util.getdir('config')
terminal           = "urxvtc"
editor_cmd         = terminal .. " -e " .. os.getenv("EDITOR")
modkey             = "Mod4"
mpd_cover_size     = 300
host               = awful.util.pread('hostname'):match('%S*')
mpd_pass, mpd_host = string.match(os.getenv('MPD_HOST'), '(.+)@(.+)')
mpd_con            = mpd.new{ hostname = mpd_host, password = mpd_pass, retry = 20 }

function load_theme(name)
    beautiful.init(string.format('%s/themes/%s/theme.lua', confdir, name))
end
load_theme('dsblue')

function mpd_notify()
    local song = mpd_con:send('currentsong')
    if song.errormsg then return end
    local t = string.format("%s\n%s\n%s: %s", song.artist, song.album,
                                              song.track, song.title):gsub('&', '&amp;')
    local cover = '/mnt/music/' .. song.file:gsub('[^/]+$', 'cover.jpg')
    naughty.notify{ text      = t,
                    icon      = cover,
                    icon_size = mpd_cover_size }
end

function awefile(file)
    local status, err =
        pcall(function() dofile(confdir .. '/' .. file) end)

    if not status then
        naughty.notify{ text = 'Unable to load ' .. file .. '\nError: ' .. err,
                        presets = naughty.config.presets.critical,
                        timeout = 0 }
    end

    return status
end

for i,v in ipairs{ 'tags.lua', 'menu.lua', 'wibox.lua',
                   'keys.lua', 'rules.lua', 'signals.lua' } do
    awefile(v)
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}
