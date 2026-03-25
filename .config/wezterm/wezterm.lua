local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "/bin/zsh" }
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 15.0
config.color_scheme = "nordfox"
config.enable_wayland = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
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
