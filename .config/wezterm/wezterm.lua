local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Colors and Opacity
config.color_scheme = "Oxocarbon Dark (Gogh)"
config.window_background_opacity = 0.8
config.text_background_opacity = 1

-- Borders
config.window_padding = {
	left = "0.5cell",
	right = "0",
	top = "0",
	bottom = "0",
}

-- Font
config.font = wezterm.font("MesloLGL Nerd Font Mono")
config.font_size = 14

-- Tabs
-- config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Disabling keybindings
config.keys = {
	-- 	-- New tab
	-- 	{
	-- 		key = "t",
	-- 		mods = "CMD",
	-- 		action = wezterm.action.DisableDefaultAssignment,
	-- 	},
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendString("\x1bb") },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendString("\x1bf") },
	-- Tab navigation
	{ key = "h", mods = "CMD|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
}

return config
