local wezterm = require("wezterm")
return {
	prefer_egl = true,
	-- default_prog = { "/usr/bin/bash", "-i" }, -- msys2
	-- default_prog = { "bash", "-i" },
	default_prog = { "C:/Program Files/Git/usr/bin/zsh.exe", "--login", "-i" }, -- git bash
}
