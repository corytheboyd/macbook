local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font('JetBrains Mono')
config.font_size = 14.0
config.color_scheme = 'Gruvbox Dark (Gogh)'

return config
