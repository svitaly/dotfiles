-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

-- config.font = wezterm.font("Pragmasevka Nerd Font")
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE"

config.tab_bar_at_bottom = true

config.use_fancy_tab_bar = false

-- and finally, return the configuration to wezterm
return config
