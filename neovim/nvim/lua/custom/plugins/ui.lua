return {
  -- color themes
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
