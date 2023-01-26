local wezterm = require('wezterm')
local ssh_domains = require('ssh_servers')

-- Integration with neovim panes
local function isViProcess(pane)
    -- get_foreground_process_name On Linux, macOS and Windows,
    -- the process can be queried to determine this path. Other operating systems
    -- (notably, FreeBSD and other unix systems) are not currently supported
    -- return pane:get_foreground_process_name():find('n?vim') ~= nil
    -- Use get_title as it works for multiplexed sessions too
    return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
            -- This should match the keybinds you set in Neovim.
            wezterm.action.SendKey({ key = vim_direction, mods = 'CTRL' }),
            pane
        )
    else
        window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

wezterm.on('update-status', function(window, pane)
    local meta = pane:get_metadata() or {}
    if meta.is_tardy then
        local secs = meta.since_last_response_ms / 1000.0
        window:set_right_status(string.format('tardy: %5.1fs⏳', secs))
    else
        window:set_right_status("")
    end
end)

return {
    -- Font and colors
    font = wezterm.font 'Fira Code',
    font_size = 11,
    freetype_load_target = "Light",
    freetype_render_target = "HorizontalLcd",
    color_scheme = 'Tomorrow Night Eighties',

    -- Key mappings
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        -- More easy split key mappings
        { key = '|', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
        { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },

        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendString '\x01', },

        -- Integration with neovim panes
        { key = 'h', mods = 'CTRL', action = wezterm.action.EmitEvent('ActivatePaneDirection-left') },
        { key = 'j', mods = 'CTRL', action = wezterm.action.EmitEvent('ActivatePaneDirection-down') },
        { key = 'k', mods = 'CTRL', action = wezterm.action.EmitEvent('ActivatePaneDirection-up') },
        { key = 'l', mods = 'CTRL', action = wezterm.action.EmitEvent('ActivatePaneDirection-right') },
    },

    -- SSH domains
    ssh_domains = ssh_domains
}
