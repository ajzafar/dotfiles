awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     keys = clientkeys,
                     buttons = clientbuttons
                   },
      callback = awful.titlebar.add
    },
    { rule = {}, callback = awful.client.setslave },
    { rule = { class = "Tilda" ,
               name = "tilda" },
      properties = { floating = true,
                     size_hints_honor = true,
                     size_hints = {
                                    user_position = false,
                                    user_size = false,
                                    program_position = true,
                                    program_size = true
                                  },
                     border_width = 0,
                   },
      callback = awful.titlebar.remove
    },
    { rule = { class = "MPlayer" },
      properties = { floating = true,
                     border_width = 0,
                     sticky = true,
                     focus = true,
                     tag = tags[screen.count()][1],
                     ontop = true
                 },
      callback = awful.titlebar.remove },
    { rule = { class = "gimp" },
      properties = { floating = true,
                     tag = tags[1][5] } },
    { rule = { class = "Chromium-browser" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Liferea" },
      properties = { tag = tags[1][3] } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "feh" },
      properties = { floating = true } },
}