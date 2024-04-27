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

  -- list of buffers on top
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle [p]in' },
      { '<leader>bh', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Go to prev buffer' },
      { '<leader>bH', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Go to first buffer' },
      { '<leader>bs', '<Cmd>BufferLineCycleNext<CR>', desc = 'Go to next buffer' },
      { '<leader>bS', '<Cmd>BufferLineCycleNext<CR>', desc = 'Go to last buffer' },
      { '<leader>bt', '<Cmd>BufferLineCycleNext<CR>', desc = 'Pick from [t]abline' }, -- TODO: not yet correct
      { '<A-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
      { '<A-s>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      -- submenu: closing
      { '<leader>bcp', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Non-[p]inned buffers' },
      { '<leader>bco', '<Cmd>BufferLineCloseOthers<CR>', desc = 'All [o]ther buffers' },
      { '<leader>bcr', '<Cmd>BufferLineCloseRight<CR>', desc = 'Buffers to the [r]ight' },
      { '<leader>bcl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Buffers to the [l]eft' },
    },
    opts = {
      options = {
        indicator = {
          icon = '', -- this should be omitted if indicator style is not 'icon'
          style = 'underline',
        },
        --   -- stylua: ignore
        --   close_command = function(n) require("mini.bufremove").delete(n, false) end,
        --   -- stylua: ignore
        --   right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        --   diagnostics = 'nvim_lsp',
        --   always_show_bufferline = false,
        --   diagnostics_indicator = function(_, _, diag)
        --     local icons = require('lazyvim.config').icons.diagnostics
        --     local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
        --     return vim.trim(ret)
        --   end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- Move/Resize window.
  {
    'mrjones2014/smart-splits.nvim',
    lazy = true,
    dependencies = { 'kwkarlwang/bufresize.nvim' },
    opts = {
      ignored_filetypes = { 'nofile', 'quickfix', 'qf', 'prompt' },
      ignored_buftypes = { 'nofile' },
      resize_mode = {
        -- key to exit persistent resize mode
        quit_key = '<ESC>',
        -- keys to use for moving in resize mode
        -- in order of left, down, up' right
        resize_keys = { 'h', 'n', 't', 's' },
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = true,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
          on_enter = function()
            vim.notify 'Entering window resize mode, press <esc> to exit.'
          end,
          on_leave = function()
            vim.notify 'Resize finished.'
            require('bufresize').register()
          end,
        },
        at_edge = 'stop',
      },
    },
  },
  --   "
  -- maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  -- maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  -- maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  -- maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  -- maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  -- maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  -- maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  -- maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
}
