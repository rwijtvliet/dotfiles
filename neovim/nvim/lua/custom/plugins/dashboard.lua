return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = function(_, opts)
    local logo = [[
  __________                .__/\      
  \______   \__ __ __ __  __| _)/_____ 
   |       _/  |  \  |  \/ __ |/  ___/ 
   |    |   \  |  /  |  / /_/ |\___ \  
   |____|_  /____/|____/\____ /____  > 
          \/                 \/    \/  
                           .__         
    ____   ____  _______  _|__| _____  
   /    \_/ __ \/  _ \  \/ /  |/     \ 
  |   |  \  ___(  <_> )   /|  |  Y Y  \
  |___|  /\___  >____/ \_/ |__|__|_|  /
       \/     \/                    \/ 
  ]]
    logo = string.rep('\n', 8) .. logo .. '\n\n'

    opts.theme = 'doom'
    opts.config = {}
    opts.config.header = vim.split(logo, '\n')
    opts.config.center = {
      --stylua: ignore start
      { desc = " New file",           icon = " ", key = "SPC f n", action = "ene | startinsert" },
      { desc = " Find file",          icon = " ", key = "SPC f f", action = false },
      { desc = " Find text",          icon = " ", key = "SPC f g", action = false },
      { desc = " Recent files",       icon = " ", key = "SPC f o", action = false },
      { desc = " Restore session",    icon = " ", key = "SPC", action = false }, --'lua require("persistence").load()' },
      { desc = " Personal dotfiles",  icon = " ", key = "SPC C d", action = false },
      { desc = " Neovim config",      icon = " ", key = "SPC C n", action = false },
      { desc = " Quit",               icon = " ", key = "SPC Q", action = "qa" },
      -- stylua: ignore end
    }
    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(' ', 30 - #button.desc)
      button.key_format = '  %s'
    end
  end,
}
