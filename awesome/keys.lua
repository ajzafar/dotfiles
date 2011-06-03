function mpd_cmd(cmd, notify)
    local notify = notify and mpd_notify or nil
    return function()
        os.execute('mpc ' .. cmd .. ' > /dev/null')
        if notify then notify() end
    end
end

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 5, awful.tag.viewprev),
    awful.button({ }, 4, awful.tag.viewnext)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Control" }, "m", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "n", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "n", function () awful.layout.inc(layouts, -1) end),

    awful.key({            }, "Print", function () awful.util.spawn("sshot.sh") end),
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey, "Shift", "Control" }, "r",    function () load_theme(beautiful.get().name) end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- application switcher from the awesome wiki
    awful.key({ modkey, "Control" }, "Tab", function ()
            -- If you want to always position the menu on the same place set coordinates
            awful.menu.menu_keys.down = { "Down", "Alt_L" }
            local cmenu = awful.menu.clients({width=245}, { keygrabber=true, coords={x=525, y=330} })
        end),
    awful.key({modkey}, "space", function() os.execute("xlock -mode blank") end),
    -- MPD control
    awful.key({modkey, "Control" }, "space", mpd_cmd('toggle', false)),
    awful.key({modkey, "Control", "Mod1" }, "space", mpd_notify),
    awful.key({modkey, "Control" }, "Left", mpd_cmd('prev', true)),
    awful.key({modkey, "Control" }, "Right", mpd_cmd('next', true)),
    awful.key({modkey, "Control" }, "Up", mpd_cmd('volume +5', false)),
    awful.key({modkey, "Control" }, "Down", mpd_cmd('volume -5', false)),
    -- Special Thinkpad keys
    awful.key({ },                  "XF86Display", function () os.execute("xset dpms force off") end),
    awful.key({ },                  "XF86ScreenSaver", function () os.execute("xlock -mode blank") end),
    -- Volume keys
    awful.key({ "Shift" },          "XF86AudioMute", function () os.execute("amixer sset Speaker toggle") end),
    -- awful.key({ },                  "XF86AudioMute", function () obvious_alsa:mute() end),
    -- awful.key({ },                  "XF86AudioRaiseVolume", function () obvious_alsa:raise("5%") end),
    -- awful.key({ },                  "XF86AudioLowerVolume", function () obvious_alsa:lower("5%") end)
    nil -- so I can reorder keys without hassle
)

function Entry(arg)
    local key, cmd = arg.key, arg.cmd
    if key and cmd then
        globalkeys = awful.util.table.join(globalkeys,
                                           awful.key({modkey, "Mod1"}, key,
                                               function()
                                                   awful.util.spawn(cmd)
                                               end))
    end
end

awefile('appkeys.lua')

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "f",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "i",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "d",      function (c) awful.titlebar.remove(c)         end),
    awful.key({ modkey,           }, "p",      function (c) c.sticky = not c.sticky end),
    awful.key({ modkey, "Control" }, "d",      function (c) c.border_width = c.border_width ~= 0 and 0 or beautiful.border_width             end),
    awful.key({ modkey, "Shift"   }, "d",
        function (c)
            awful.titlebar.add(c, { modkey = modkey })
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    nil -- so I can reorder keys without hassle
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Mod1" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}