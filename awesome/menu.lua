-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

feh_bg = 'feh -z --bg-fill ' .. confdir .. '/../backgrounds'

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "refresh background", feh_bg},
                                    { "open terminal", terminal }
                                  }
                        })
