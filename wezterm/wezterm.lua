local wezterm = require('wezterm')
local ssh_domains = require('ssh_servers')

return {
    -- Font and colors
    font = wezterm.font 'Fira Code',
    font_size = 11.0,
    color_scheme = 'DanQing (base16)',

    -- Key mappings
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        -- More easy split key mappings
        {
            key = '|',
            mods = 'LEADER|SHIFT',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },

        {
            key = '-',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },

        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        {
            key = 'a',
            mods = 'LEADER|CTRL',
            action = wezterm.action.SendString '\x01',
        },
    },

    -- SSH domains
    ssh_domains = ssh_domains
}
