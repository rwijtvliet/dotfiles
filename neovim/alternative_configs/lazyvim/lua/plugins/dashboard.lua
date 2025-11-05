return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local logo = [[
  __________                .__/\                               .__          
  \______   \__ __ __ __  __| _)/_____   ____   ____  _______  _|__| _____   
   |       _/  |  \  |  \/ __ |/  ___/  /    \_/ __ \/  _ \  \/ /  |/     \  
   |    |   \  |  /  |  / /_/ |\___ \  |   |  \  ___(  <_> )   /|  |  Y Y  \ 
   |____|_  /____/|____/\____ /____  > |___|  /\___  >____/ \_/ |__|__|_|  / 
          \/                 \/    \/       \/     \/                    \/  
  (based on LazyVim)
  ]]
    logo = string.rep("\n", 8) .. logo .. "\n\n"

    opts.theme = "doom"
    opts.config.header = vim.split(logo, "\n")
    opts.config.center = {
      --stylua: ignore start
      { desc = " New file",           icon = " ", key = "N", action = "ene | startinsert" },
      { desc = " Find file",          icon = " ", key = "f", action = LazyVim.telescope("files") },
      { desc = " Find text",          icon = " ", key = "g", action = "Telescope live_grep" },
      { desc = " Recent files",       icon = " ", key = "r", action = "Telescope oldfiles" },
      { desc = " Restore session",    icon = " ", key = "S", action = 'lua require("persistence").load()' },
      { desc = " Personal dotfiles",  icon = " ", key = "d", action = "lua require('telescope.builtin').find_files({cwd='~/.dotfiles'})" },
      { desc = " Neovim config",      icon = " ", key = "c", action = [[lua LazyVim.telescope.config_files()()]] },
      { desc = " Lazy extras",        icon = " ", key = "x", action = "LazyExtras" },
      { desc = " Lazy",               icon = "󰒲 ", key = "l", action = "Lazy" },
      { desc = " Quit",               icon = " ", key = "q", action = "qa" },
      -- stylua: ignore end
    }
    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 30 - #button.desc)
      button.key_format = "  %s"
    end
  end,
}
