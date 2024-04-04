local wezterm = require 'wezterm'
local config = {
	font = wezterm.font('JetBrainsMono Nerd Font'),
	font_size = 15.0,
	color_scheme = 'nordfox',
	enable_wayland = false,
	hide_tab_bar_if_only_one_tab = true,
	enable_scroll_bar = true,
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 8,
	},
}
return config
