local wezterm = require("wezterm")
local config = {
	default_prog = { "/bin/zsh" },
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 15.0,
	color_scheme = "nordfox",
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

config.keys = {
	-- search for things that look like git hashes
	{
		key = "H",
		mods = "SHIFT|CTRL",
		action = wezterm.action.Search({ Regex = "[a-f0-9]{6,}" }),
	},
}
return config
