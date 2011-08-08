-- dsblue by Adnan Zafar
-- Based on/inspired by/taken from:
--  - the default, Zenburn, and Sky Awesome themes
--  - the Modern Glass Blue GTK+ theme
--  - the bblean theme darksky by ratednc-17.com

t               = {}
t.name          = 'dsblue'
local tp        = confdir .. '/themes/' .. t.name
local wpcmd     = 'awsetbg -r '..os.getenv('XDG_CONFIG_HOME')..'/backgrounds-'..host
t.wallpaper_cmd = { wpcmd, wpcmd }

t.font        = "sans 9"
t.menu_height = "15"
t.menu_width  = "150"

-- {{{ Colors
-- Main
t.fg_normal = "#d3deeb"
t.fg_focus  = "#e8e6f8"
t.fg_urgent = "#CC9393"

t.bg_normal = "#363945"
t.bg_focus  = "#591516"
t.bg_urgent = "#cc3739"

-- Borders
t.border_width  = "2"
t.border_normal = "#111214"
t.border_focus  = "#546273"
t.border_marked = "#ff4500"

-- Titlebars
t.titlebar_bg_focus  = "#005aab"
t.titlebar_bg_normal = "#0c3457"
t.titlebar_fg_focus  = "#e8e6f8"
t.titlebar_fg_normal = "#d3deeb"

-- Widget colors
t.widget_fg = '#98a0aa'
t.widget_bg = '#1a1c20'
-- }}}

-- other variables:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
--
-- alternatively add whatever variables you want, accessed as beautiful.whatever

-- {{{ Icons
-- Tag list
t.taglist_squares_sel    = tp .. "/taglist/squarefz.png"
t.taglist_squares_unsel  = tp .. "/taglist/squarez.png"
t.taglist_squares_resize = "true"

-- Layout
t.layout_tile       = tp .. "/layouts/tile.png"
t.layout_tileleft   = tp .. "/layouts/tileleft.png"
t.layout_tilebottom = tp .. "/layouts/tilebottom.png"
t.layout_tiletop    = tp .. "/layouts/tiletop.png"
t.layout_fairv      = tp .. "/layouts/fairv.png"
t.layout_fairh      = tp .. "/layouts/fairh.png"
t.layout_spiral     = tp .. "/layouts/spiral.png"
t.layout_dwindle    = tp .. "/layouts/dwindle.png"
t.layout_max        = tp .. "/layouts/max.png"
t.layout_fullscreen = tp .. "/layouts/fullscreen.png"
t.layout_magnifier  = tp .. "/layouts/magnifier.png"
t.layout_floating   = tp .. "/layouts/floating.png"

-- Titlebar
t.titlebar_close_button_focus  = tp .. "/titlebar/close_focus.png"
t.titlebar_close_button_normal = tp .. "/titlebar/close_normal.png"

t.titlebar_ontop_button_focus_active        = tp .. "/titlebar/ontop_focus_active.png"
t.titlebar_ontop_button_normal_active       = tp .. "/titlebar/ontop_normal_active.png"
t.titlebar_ontop_button_focus_inactive      = tp .. "/titlebar/ontop_focus_inactive.png"
t.titlebar_ontop_button_normal_inactive     = tp .. "/titlebar/ontop_normal_inactive.png"

t.titlebar_sticky_button_focus_active       = tp .. "/titlebar/sticky_focus_active.png"
t.titlebar_sticky_button_normal_active      = tp .. "/titlebar/sticky_normal_active.png"
t.titlebar_sticky_button_focus_inactive     = tp .. "/titlebar/sticky_focus_inactive.png"
t.titlebar_sticky_button_normal_inactive    = tp .. "/titlebar/sticky_normal_inactive.png"

t.titlebar_floating_button_focus_active     = tp .. "/titlebar/floating_focus_active.png"
t.titlebar_floating_button_normal_active    = tp .. "/titlebar/floating_normal_active.png"
t.titlebar_floating_button_focus_inactive   = tp .. "/titlebar/floating_focus_inactive.png"
t.titlebar_floating_button_normal_inactive  = tp .. "/titlebar/floating_normal_inactive.png"

t.titlebar_maximized_button_focus_active    = tp .. "/titlebar/maximized_focus_active.png"
t.titlebar_maximized_button_normal_active   = tp .. "/titlebar/maximized_normal_active.png"
t.titlebar_maximized_button_focus_inactive  = tp .. "/titlebar/maximized_focus_inactive.png"
t.titlebar_maximized_button_normal_inactive = tp .. "/titlebar/maximized_normal_inactive.png"

-- Misc
t.awesome_icon           = tp .. "/other/awesome-icon.png"
t.menu_submenu_icon      = tp .. "/other/submenu.png"
t.tasklist_floating_icon = tp .. "/other/floatingw.png"
-- }}}

theme = t
return theme
