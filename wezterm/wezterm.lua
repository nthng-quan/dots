local wezterm = require("wezterm")
local config = wezterm.config_builder()

local color = {
	normal_bg = "#393939",
	normal_fg = "#C5C8C6",
	bright_bg = "#969896",
	bright_fg = "#FFFFFF",
	new_bg = "#57627a",
}

local pad = 0

-- general
config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
config.default_cwd = "D:"
config.warn_about_missing_glyphs = true

-- fonts
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	weight = "Medium",
})
config.font = wezterm.font_with_fallback({
	"JetBrainsMono NF",
	"Cascadia Code",
	"JetBrains Mono",
	"PingFang SC",
})
config.font_size = 13.5

-- ui
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

config.scrollback_lines = 10000
config.show_update_window = true
config.window_background_opacity = 0.99
-- config.win32_system_backdrop = "Acrylic"
config.color_scheme='Tomorrow Night (Gogh)'
config.window_padding = {
	left = pad,
	right = pad,
	top = pad,
	bottom = pad,
}
config.initial_cols = 120
config.initial_rows = 30

config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.5,
}

-- tabs
config.use_fancy_tab_bar = false
config.tab_max_width = 15

config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = color.normal_fg,
			fg_color = color.normal_bg,
			intensity = "Bold",
		},
		inactive_tab_edge = "#000000",
		inactive_tab = {
			bg_color = color.normal_bg,
			fg_color = color.normal_fg,
		},
		inactive_tab_hover = {
			bg_color = color.bright_bg,
			fg_color = color.bright_fg,
			intensity = "Bold",
		},
		new_tab = {
			bg_color = color.bright_bg,
			fg_color = color.bright_fg,
		},
		new_tab_hover = {
			bg_color = color.bright_bg,
			fg_color = color.bright_fg,
			intensity = "Bold",
		},
	},
}

-- keys
-- config.keys = {
-- }

return config
