local awful = awful
local os = { execute = os.execute }
local string = { format = string.format }
local widget = widget

module('widgets.randr')

local function randrfunc(state, external, main)
    local state = state or 'off'
    local external = external or 'S-video'
    local main = main or 'VGA-0'
    local cmd = 'xrandr --output ' .. external
    if state ~= 'off' then
        cmd = string.format('%s --auto; %s --%s %s', cmd, cmd, state, main)
    else
        cmd = cmd .. ' --off'
    end

    return function()
        os.execute(cmd)
        randrwid.text = state
    end
end

local menu = awful.menu{ items = {
    { 'Off', randrfunc('off') },
    { 'Below', randrfunc('below') },
    { 'Above', randrfunc('above') },
    { 'Left', randrfunc('left-of') },
    { 'Right', randrfunc('right-of') }
}}

function new(args)
    local args = args or {}
    local widget = widget{ type = 'textbox' }

    widget.text = 'Unknown'
    widget.width = 50
    widget:buttons(awful.button({ }, 1, function() awful.menu.toggle(menu) end))

    return widget
end
