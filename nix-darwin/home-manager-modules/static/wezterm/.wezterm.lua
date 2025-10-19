local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font('JetBrains Mono')
config.font_size = 14.0
config.color_scheme = 'Gruvbox Dark (Gogh)'

config.keys = {
  -- Clear screen
  { key = 'k',          mods = 'CMD',       action = act.ClearScrollback 'ScrollbackAndViewport' },

  -- Split panes
  { key = 'd',          mods = 'CMD',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd',          mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Navigate split panes
  { key = 'LeftArrow',  mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CMD|OPT',   action = act.ActivatePaneDirection 'Down' },

  -- New tab/window
  { key = 't',          mods = 'CMD',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n',          mods = 'CMD',       action = act.SpawnWindow },
  { key = 'w',          mods = 'CMD',       action = act.CloseCurrentPane { confirm = true } },

  -- Change tabs
  { key = 'LeftArrow',  mods = 'CMD',       action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD',       action = act.ActivateTabRelative(1) },

  -- Move tabs
  { key = 'LeftArrow',  mods = 'CMD|SHIFT', action = act.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = act.MoveTabRelative(1) },
}

return config
