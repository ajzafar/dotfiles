-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,        -- 1
    awful.layout.suit.tile.bottom,     -- 2
    awful.layout.suit.tile.top,        -- 3
    awful.layout.suit.tile,            -- 4
    awful.layout.suit.tile.left,       -- 5
    awful.layout.suit.fair,            -- 6
    awful.layout.suit.fair.horizontal, -- 7
    awful.layout.suit.spiral,          -- 8
    awful.layout.suit.spiral.dwindle,  -- 9
    awful.layout.suit.max.fullscreen,  -- 10
    awful.layout.suit.magnifier,       -- 11
    awful.layout.suit.max,             -- 12
}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names  = { '☿', '♀', '♁', '♂', '♃', '♄', '♅', '♆', '♇' },
    layout = { 4, 12 },
}

for i = 1, table.getn(tags.names) do
    tags.layout[i] = tags.layout[i] and layouts[tags.layout[i]] or layouts[1]
end

tags[1] = awful.tag(tags.names, 1, tags.layout)

for s = 2, screen.count() do
    tags[s] = awful.tag({ 1 }, s)
end
-- }}}
