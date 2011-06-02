-- Like my zsh config, I keep my Awesome config modular. Organizationally,
-- I find this easier to work with. Additionally this makes errors in my config
-- easier to debug as I don't have to keep switching to console to see the
-- message. Lastly, I can modify one file and, in most cases, simply rerun
-- awefile('thefile.lua') for the changes to take effect.

require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")

require("vicious")

confdir        = awful.util.getdir('config')
terminal       = "urxvtc"
editor_cmd     = terminal .. " -e " .. os.getenv("EDITOR")
modkey         = "Mod4"
mpd_cover_size = 200
host           = awful.util.pread('hostname')

function load_theme(name)
    beautiful.init(string.format('%s/themes/%s/theme.lua', confdir, name))
end
load_theme('dsblue')

function mpd_notify()
    local t = awful.util.pread("mpc current -f '%artist%\n%album%\n%track%: %title%'")
    t = t:gsub('&', '&amp;') -- sanitize for Pango
    local cover = '/mnt/music/' .. string.gsub(awful.util.pread('mpc current -f %file%'), '[^/]+$', 'cover.jpg')
    naughty.notify{ text = t,
                    icon = cover,
                    icon_size = mpd_cover_size }
end

function awefile(file)
    local status, err =
        pcall(function() dofile(confdir .. '/' .. file) end)

    if not status then
        naughty.notify{
            text = 'Unable to load ' .. file .. '\nError: ' .. err,
            timeout = 0}
    end

    return status
end

for i,v in ipairs{ 'tags.lua', 'menu.lua', 'widgets.lua',
                   'keys.lua', 'rules.lua', 'signals.lua' } do
    if not awefile(v) then
        error()
    end
end
