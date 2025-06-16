return {
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
    dependencies = { 'nvim-tree/nvim-web-devicons', 'ojroques/nvim-bufdel' },
    lazy = false, -- TODO: check why this is needed. (If removed, the bufferline is not shown when restoring a session)
    keys = {
      -- stylua: ignore start
      { '<leader>1',   '<Cmd>BufferLineGoToBuffer 1<CR>',         desc = 'which_key_ignore' },
      { '<leader>2',   '<Cmd>BufferLineGoToBuffer 2<CR>',         desc = 'which_key_ignore' },
      { '<leader>3',   '<Cmd>BufferLineGoToBuffer 3<CR>',         desc = 'which_key_ignore' },
      { '<leader>4',   '<Cmd>BufferLineGoToBuffer 4<CR>',         desc = 'which_key_ignore' },
      { '<leader>5',   '<Cmd>BufferLineGoToBuffer 5<CR>',         desc = 'which_key_ignore' },
      { '<leader>6',   '<Cmd>BufferLineGoToBuffer 6<CR>',         desc = 'which_key_ignore' },
      { '<leader>7',   '<Cmd>BufferLineGoToBuffer 7<CR>',         desc = 'which_key_ignore' },
      { '<leader>8',   '<Cmd>BufferLineGoToBuffer 8<CR>',         desc = 'which_key_ignore' },
      { '<leader>9',   '<Cmd>BufferLineGoToBuffer 9<CR>',         desc = 'which_key_ignore' },
      { '<A-h>',       '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
      { '<A-s>',       '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
      { '[b',          '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
      { ']b',          '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
      -- submenu: buffer
      { '<leader>bp',  '<Cmd>BufferLineTogglePin<CR>',            desc = 'Toggle pin' },
      { '<leader>bh',  '<Cmd>BufferLineCyclePrev<CR>',            desc = 'Go to prev buffer' },
      { '<leader>bH',  '<Cmd>BufferLineCyclePrev<CR>',            desc = 'Go to first buffer' },
      { '<leader>bs',  '<Cmd>BufferLineCycleNext<CR>',            desc = 'Go to next buffer' },
      { '<leader>bS',  '<Cmd>BufferLineCycleNext<CR>',            desc = 'Go to last buffer' },
      { '<leader>bt',  '<cmd>BufferLinePick<cr>',                 desc = 'Pick from bufferline' },
      -- submenu: buffer closing
      { '<leader>bcp', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Non-pinned' },
      { '<leader>bco', '<Cmd>BufferLineCloseOthers<CR>',          desc = 'All others' },
      { '<leader>bcr', '<Cmd>BufferLineCloseRight<CR>',           desc = 'All to the right' },
      { '<leader>bcl', '<Cmd>BufferLineCloseLeft<CR>',            desc = 'All to the left' },
      -- stylua: ignore end
    },
    opts = {
      options = {
        close_command = 'BufDel %d', -- can be a string | function, | false see "Mouse actions"
        separator_style = 'thick',
        indicator = {
          icon = '', -- this should be omitted if indicator style is not 'icon'
          style = 'underline',
        },
        --   close_command = function(n) require("mini.bufremove").delete(n, false) end,
        --   right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        --   diagnostics_indicator = function(_, _, diag)
        --     local icons = require('lazyvim.config').icons.diagnostics
        --     local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
        --     return vim.trim(ret)
        --   end,
        sort_by = 'insert_at_end',
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

  -- Better delete buffer (i.e., without closing window)
  {
    'ojroques/nvim-bufdel',
    name = 'bufdel',
    keys = {
      { '<leader>c', '<cmd>BufDel<cr>', desc = 'Close buffer' },
      { '<leader>C', '<cmd>BufDel!<cr>', desc = "Close buffer (don't save)" },
      { '<leader>bcc', '<cmd>BufDel!<cr>', desc = 'Current buffer' },
    },
    opts = { next = 'alternate' },
  },

  -- Move/Resize window.
  {
    'mrjones2014/smart-splits.nvim',
    lazy = true,
    dependencies = { 'kwkarlwang/bufresize.nvim' },
    keys = {
      --stylua: ignore start
      -- focus window
      { '<C-h>',       function() require('smart-splits').move_cursor_left() end,  desc = 'Focus to left window',   mode = {'', 't', 'i'}},
      { '<C-t>',       function() require('smart-splits').move_cursor_up() end,    desc = 'Focues to above window', mode = {'', 't', 'i'}},
      { '<C-n>',       function() require('smart-splits').move_cursor_down() end,  desc = 'Focus to below window',  mode = {'', 't', 'i'}},
      { '<C-s>',       function() require('smart-splits').move_cursor_right() end, desc = 'Focus to right window',  mode = {'', 't', 'i'}},
      { '<leader>wh',  function() require('smart-splits').move_cursor_left() end,  desc = 'Focus to left window',   },
      { '<leader>wt',  function() require('smart-splits').move_cursor_up() end,    desc = 'Focues to above window', },
      { '<leader>wn',  function() require('smart-splits').move_cursor_down() end,  desc = 'Focus to below window',  },
      { '<leader>ws',  function() require('smart-splits').move_cursor_right() end, desc = 'Focus to right window',  },
      -- resize window
      { '<C-Left>',    function() require('smart-splits').resize_left() end,       desc = 'Resize window left',  mode = {'', 't', 'i'}},
      { '<C-Up>',      function() require('smart-splits').resize_up() end,         desc = 'Resize window up',    mode = {'', 't', 'i'}},
      { '<C-Down>',    function() require('smart-splits').resize_down() end,       desc = 'Resize window down',  mode = {'', 't', 'i'}},
      { '<C-Right>',   function() require('smart-splits').resize_right() end,      desc = 'Resize window right', mode = {'', 't', 'i'}},
      -- resize window: persistent
      { '<leader>wr',  function() require('smart-splits').start_resize_mode() end, desc = 'Resize', },
      -- swap buffer
      { '<leader>wmh', function() require('smart-splits').swap_buf_left() end,     desc = 'Swap buffer left', },
      { '<leader>wmt', function() require('smart-splits').swap_buf_up() end,       desc = 'Swap buffer above', },
      { '<leader>wmn', function() require('smart-splits').swap_buf_down() end,     desc = 'Swap buffer down', },
      { '<leader>wms', function() require('smart-splits').swap_buf_right() end,    desc = 'Swap buffer right', },
      --stylua: ignore end
    },
    opts = {
      ignored_filetypes = { 'nofile', 'quickfix', 'qf', 'prompt' },
      ignored_buftypes = { 'nofile' },
      resize_mode = {
        quit_key = '<Esc>', -- key to exit persistent resize mode
        resize_keys = { 'h', 'n', 't', 's' }, -- keys to use for moving in resize mode in order of left, down, up' right
        silent = false,
        hooks = {
          on_enter = function()
            vim.notify 'Entering window resize mode, press <esc> to exit.'
          end,
          on_leave = function()
            vim.notify 'Resize finished.'
            require('bufresize').register()
            -- TODO: remove when solved
            vim.keymap.set('', 'h', 'h', { desc = 'Move left' }) -- for completeness
            vim.keymap.set('', 'n', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'move down' })
            vim.keymap.set('', 't', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'move up' })
            vim.keymap.set('', 's', 'l', { desc = 'move right' })
            vim.keymap.set('', 'H', 'H', { desc = 'Move cursor to top of screen' }) -- for completeness
            vim.keymap.set('', 'S', 'L', { desc = 'Move cursor to bottom of screen' })
            vim.keymap.set('n', 'T', 'K', { remap = true, desc = 'Help' })
          end,
        },
        at_edge = 'stop',
      },
    },
  },

  -- Highlight certain text such as
  -- TODO:
  -- HACK: and
  -- NOTE:
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  --line at bottom of window
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = false,
          globalstatus = false,
          refresh = {
            statusline = 500,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics', 'trouble' },
          lualine_c = { 'filename' },
          lualine_x = {
            'encoding',
            'filesize',
            'filetype',
            'trouble',
            { require('noice').api.statusline.mode.get, cond = require('noice').api.statusline.mode.has, color = { fg = '#ff9e64' } }, -- to show @recording
          },
          lualine_y = { 'searchcount' },
          lualine_z = { 'location', 'progress' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'trouble' },
      }
    end,
  },

  --hexcolors
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup { '*' }
    end,
  },

  --indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#703C35' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#75603B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#315F7F' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#614A36' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#486339' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#66386D' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#265662' })
      end)
      require('ibl').setup {
        scope = { char = '🬃' },
        indent = { char = '▏', highlight = highlight },
        exclude = { filetypes = { 'dashboard' } },
      }
    end,
  },

  -- only highlight cursor in active window, not in all windows.
  {
    'tummetott/reticle.nvim',
    event = 'VeryLazy', -- optionally lazy load the plugin
    opts = {
      -- add options here if you wish to override the default settings
    },
  },

  -- popup window for command line
  {
    'folke/noice.nvim',
    opts = {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup', -- Use a popup window for the command line
        opts = { position = { row = '80%' }, size = { width = '80%' } },
      },
    },
  },
}
