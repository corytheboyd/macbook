local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font('JetBrains Mono')
config.font_size = 14.0
config.color_scheme = 'Gruvbox Dark (Gogh)'

config.keys = {
  -- Split panes
  { key = 'd',          mods = 'CMD',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd',          mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Navigate panes
  { key = '[',          mods = 'CMD',       action = act.ActivatePaneDirection 'Prev' },
  { key = ']',          mods = 'CMD',       action = act.ActivatePaneDirection 'Next' },
  { key = 'LeftArrow',  mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Down' },

  -- New tab/window
  { key = 't',          mods = 'CMD',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n',          mods = 'CMD',       action = act.SpawnWindow },
  { key = 'w',          mods = 'CMD',       action = act.CloseCurrentPane { confirm = true } },
}

return config
