return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = function(_, opts)
    local logo = [[
                                   ▁      
   ▁▁▁▁▁▁▁▁▁▁                  ▁▁ / ▌     
   \▁▁▁▁▁▁   \▁▁ ▁▁ ▁▁ ▁▁  ▁▁▁│ ▁▌\▞▁▁▁▁▁ 
    │       ▁▞  ▌  \  ▌  \/  ▂▂  ▌/  ▂▂▂▞ 
    │    ▌   \  ▌  ▞  ▌  ▞  ▞▁/  ▌\▁▁▁  \ 
    │▂▂▂▂▌▂  ▞▂▂▂▂▞\▂▂▂▂▞\▂▂▂▂  ▞▂▂▂▂▂  ▞ 
           \▞                 \▞      \▞  
                              ▁▁          
   ▁▁▁▁▁   ▁▁▁▁  ▁▁▁▁▁▁▁▁  ▁▁│▁▁▌ ▁▁▁▁▁▁  
  /     \▁/ ▂▂ \/  ▂▂ \  \/  ▖  ▌/ ▁  ▁ \ 
  │   ▌  \  ▁▁▁▞  ▞▁/  ▌    ▞│  ▌  ▌  ▌  \
  │▂▂▂▌  ▞\▂▂▂  ▌▂▂▂▂▂▞ \▂▂▞ │▂▂▌▂▂▌▂▂▌  ▞
       \▞     \▞                       \▞ 
  ]]
    logo = string.rep('\n', 8) .. logo .. '\n\n'

    opts.theme = 'doom'
    opts.config = {}
    opts.config.header = vim.split(logo, '\n')
    opts.config.center = {
      -- TODO: Add actions
      --stylua: ignore start
      { desc = "New file",             icon = "", key = "SPC f n", action = false },
      { desc = "Find file",            icon = "", key = "SPC f f", action = false },
      { desc = "Find file (grep)",     icon = "", key = "SPC f F", action = false },
      { desc = "Recent files",         icon = "", key = "SPC f o", action = false },
      { desc = "Restore last session", icon = "", key = "SPC S l", action = false },
      { desc = "Personal dotfiles",    icon = "", key = "SPC s d", action = false },
      { desc = "Neovim config",        icon = "", key = "SPC s n", action = false },
      { desc = "Quit",                 icon = "", key = "SPC q q", action = "qa" },
      { desc = "",                     icon = " ", key = "<Esc>",   action = "bdelete" },
      -- stylua: ignore end
    }
    for _, button in ipairs(opts.config.center) do
      button.desc = '  ' .. button.desc .. string.rep(' ', 30 - #button.desc)
      button.key_format = '  %s'
    end
  end,
}
