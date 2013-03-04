widgets = require('widgets')
wibox = require('wibox')

-- {{{ Widget creation
-- Create a textclock widget
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
mytextclock = awful.widget.textclock("%A %x %k:%M:%S", 1)
mytextclock:buttons(awful.button({ }, 1, function() naughty.notify{ text = awful.util.pread("date +'%s'") } end ))
separate = wibox.widget.textbox()
separate:set_markup(' <span color="black">|</span> ')

-- Create a systray
mysystray = wibox.widget.systray()

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
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
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

mpdwid = widgets.mpd.new{ notify = mpd_notify }
vicious.register(mpdwid, widgets.mpd.vicious_worker, widgets.mpd.vicious_format, 3, { connection = mpd_con })
cpuwid = widgets.cpu.new()
vicious.register(cpuwid, vicious.widgets.cpu, "$1", 5)
memwid = widgets.memory.new()
vicious.register(memwid, vicious.widgets.mem, widgets.memory.vicious_format, 7)
-- memwid = awful.widget.progressbar()
-- memwid:set_max_value(100)
-- vicious.register(memwid, vicious.widgets.mem, function(widget, args) for k,v in ipairs(args) do print(k,v) end; widget:set_value(98) return 1 end, 7)
volwid = widgets.volume.new()
vicious.register(volwid, vicious.widgets.volume, "$1", 2, 'Master')
randrwid = widgets.randr.new()
batwid = widgets.battery.new()
vicious.register(batwid, vicious.widgets.bat, widgets.battery.vicious_format, 5, 'BAT0')
diskwid = widgets.disk.new{ mounts = { '/', '/home', '/mnt/music' } }
vicious.register(diskwid, vicious.widgets.fs, widgets.disk.vicious_format, 29)

promptwid = awful.widget.prompt()
-- }}}

botbox = awful.wibox({ position = "bottom", screen = 1 })
botbox.opacity = 10
local layout = wibox.layout.fixed.horizontal()
layout:add(separate)
layout:add(mpdwid)
layout:add(separate)
layout:add(cpuwid)
layout:add(separate)
layout:add(memwid)
layout:add(separate)
layout:add(randrwid)
layout:add(separate)
layout:add(volwid)
layout:add(separate)
layout:add(batwid)
layout:add(separate)
layout:add(diskwid)
layout:add(separate)
layout:add(promptwid)
botbox:set_widget(layout)

-- {{{ Place widgets
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters

    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])

    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(mysystray) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}
