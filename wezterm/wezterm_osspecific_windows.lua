local wezterm = require("wezterm")
return {
	prefer_egl = true,
	-- default_prog = { "/usr/bin/bash", "-i" }, -- msys2
	-- default_prog = { "bash", "-i" },
        default_prog = { "C:/Program Files/Git/bin/bash.exe","--login", "-i" }, -- git bash
	-- default_prog = { "C:/Program Files/Git/usr/bin/zsh.exe", "--login", "-i" },  

	-- WSL
	-- default_domain = 'WSL:Ubuntu-24.04',
    launch_menu = {
        {
            label = "Bash",
        args = { "C:/Program Files/Git/bin/bash.exe","--login", "-i" }, -- git bash
            -- args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
        },
        {
            label = "WSL",
            args = { "wsl.exe" },
        },
    },
}
