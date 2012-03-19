require('widgets')

-- {{{ Widget creation
-- Create a textclock widget
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
mytextclock = awful.widget.textclock({ align = "right" }, "%A %x %k:%M:%S", 1)
mytextclock:buttons(awful.button({ }, 1, function() naughty.notify{ text = awful.util.pread("date +'%s'") } end ))
separate = widget({ type = "textbox" })
separate.text = ' <span color="black">|</span> '

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

mpdwid = widgets.mpd.new{ connection = mpd_con, onclick = mpd_notify }
cpuwid = widgets.cpu.new()
vicious.register(cpuwid, vicious.widgets.cpu, "$1", 5)
memwid = widgets.memory.new()
vicious.register(memwid, vicious.widgets.mem, widgets.memory.vicious_format, 7)
volwid = widgets.volume.new()
vicious.register(volwid, vicious.widgets.volume, "$1", 3, 'Master')
randrwid = widgets.randr.new()
batwid = widgets.battery.new()
vicious.register(batwid, vicious.widgets.bat, widgets.battery.vicious_format, 5, 'BAT0')
netwid = widgets.net.new()
vicious.register(netwid, vicious.widgets.net, widgets.net.vicious_format, 11)
-- }}}

botbox = {}
botbox = awful.wibox({ position = "bottom", screen = 1 })
botbox.opacity = 10
wids = {
    separate,
    mpdwid, separate,
    cpuwid, separate,
    memwid, separate,
    randrwid, separate,
    volwid, separate,
    batwid, separate,
    netwid, separate,
}

mounts = { '/', '/home', host == 'deskbert' and '/mnt/music' or nil}
fswids = {}
for i, m in ipairs(mounts) do
    local fmt = string.format('%s ${%s used_gb}/${%s size_gb}', m, m, m)
    local w = widget({ type = "textbox" })
    vicious.register(w, vicious.widgets.fs, fmt, 120)
    table.insert(fswids, w)
    table.insert(fswids, separate)
end
botbox.widgets = awful.util.table.join(wids, fswids,
    { layout = awful.widget.layout.horizontal.leftright })

-- {{{ Place widgets
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            s == 1 and mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

end
-- }}}
