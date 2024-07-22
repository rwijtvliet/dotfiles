-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

return {

	color_scheme = "Gruvbox Dark (Gogh)",
	font = wezterm.font("JetBrains Mono"),
	underline_thickness = 3,
	underline_position = -4,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	default_prog = { "/bin/zsh", "-i" },

	default_cursor_style = "SteadyBar",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 1,
	force_reverse_video_cursor = true,

	enable_kitty_graphics = true,

	-- vim motions
	keys = {
		{ key = "Escape", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
	},
	key_tables = {
		copy_mode = {
			-- navigation
			---- basic
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "n", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "t", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "s", mods = "NONE", action = act.CopyMode("MoveRight") },
			---- words
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			---- line
			{ key = "B", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "E", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			---- screen
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "S", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			---- document
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			---- selection
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			---- jump
			{ key = "k", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "K", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			-- selection mode
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			-- exit mode
			---- without copy
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			---- with copy
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},
		},
	},
}
