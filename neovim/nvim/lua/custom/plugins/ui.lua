return {
  -- color themes
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    event = 'UIEnter',
    config = function()
      require('gruvbox').setup {
        contrast = 'hard',
        dim_inactive = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'UIEnter',
    lazy = true,
    config = function()
      require('catppuccin').setup {
        dim_inactive = { enabled = true, percentage = 0.25 },
      }
    end,
  },
  -- notification styling
  {
    'rcarriga/nvim-notify',
    name = 'notify',
    lazy = true,
    init = function()
      vim.notify = require 'notify'
    end,
    -- init = function() require("astronvim.utils").load_plugin_with_func("nvim-notify", vim, "notify") end,
    opts = {
      -- on_open = function(win)
      --   vim.api.nvim_win_set_config(win, { zindex = 175 })
      --   if not vim.g.ui_notifications_enabled then
      --     vim.api.nvim_win_close(win, true)
      --   end
      --   if not package.loaded['nvim-treesitter'] then
      --     pcall(require, 'nvim-treesitter')
      --   end
      --   vim.wo[win].conceallevel = 3
      --   local buf = vim.api.nvim_win_get_buf(win)
      --   if not pcall(vim.treesitter.start, buf, 'markdown') then
      --     vim.bo[buf].syntax = 'markdown'
      --   end
      --   vim.wo[win].spell = false
      -- end,
    },
    -- config = require 'plugins.configs.notify',
  },
}
