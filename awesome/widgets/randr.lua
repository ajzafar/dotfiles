local randr = {}

local function randrfunc(state, external, main)
    local state = state or 'off'
    local external = external or 'LVDS1'
    local main = main or 'VGA1'
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

local menu = { items = {
    { 'Off', randrfunc('off') },
    { 'Below', randrfunc('below') },
    { 'Above', randrfunc('above') },
    { 'Left', randrfunc('left-of') },
    { 'Right', randrfunc('right-of') },
    { 'Same', randrfunc('same-as') },
}}

function randr.new(args)
    local args = args or {}
    local widget = wibox.widget.textbox()

    widget:set_text('Unknown')
    widget:buttons(awful.button({ }, 1, function() awful.menu.toggle(menu) end))

    return widget
end

return randr
