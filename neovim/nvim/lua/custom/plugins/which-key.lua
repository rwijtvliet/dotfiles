-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    dependencies = { 'echasnovski/mini.icons' },
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup {
        icons = {
          separator = '➜', -- symbol used between a key and it's label
          group = ' ', -- symbol prepended to a group
        },
        window = {
          border = 'rounded', -- You can choose from "none", "single", "double", "rounded", "solid", "shadow"
          position = 'bottom', -- or "top"
          -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
      }

      -- highlight group aliases
      local hlbufwind = 'WhichKeyIconYellow' -- buffers and windows
      local hlsource = 'markdownH2' -- source control
      local hlquality = 'markdownH3' -- testing and debugging
      local hlrun = 'markdownH4' -- running code
      local hlnvim = 'markdownH5' -- neovim config: packages, UI, etc.
      local warn = 'WhichKeyIconRed'

      require('which-key').add {
        { '<leader>b', group = 'Buffer (and tab)', icon = { icon = '', hl = hlbufwind } },
        { '<leader>bc', group = 'Close', icon = '' },

        { '<leader>d', group = 'Debug', icon = { icon = '', hl = hlquality } },

        { '<leader>f', group = 'File', icon = { icon = '', hl = hlbufwind } },

        { '<leader>g', group = 'Git', icon = { hl = hlsource } },
        { '<leader>ga', group = 'Add (stage)', icon = '' },
        { '<leader>gu', group = 'Unstage', icon = '' },
        { '<leader>gD', group = 'Diff', icon = '' },
        { '<leader>gt', group = 'Toggle', icon = '' },
        { '<leader>gr', group = 'Reset' },

        { '<leader>l', group = 'Lsp and code', icon = '' },

        { '<leader>m', group = 'Terminal', icon = { icon = '', hl = hlrun } },

        { '<leader>M', group = 'Markdown', icon = '' },

        { '<leader>P', group = 'Plugins', icon = { icon = '', hl = hlnvim } },

        { '<leader>J', group = 'Run code (jukit)', icon = { icon = '󰜎', hl = hlrun } },
        -- { '<leader>k',  group = ' Run code (jupynium)', icon = '󰜎' },
        { '<leader>r', group = 'Run code (iron)', icon = { icon = '󰜎', hl = hlrun } },
        -- { '<leader>R',  group = ' Run code (molten)', icon = '󰜎' },

        { '<leader>s', group = 'Search' },

        { '<leader>S', group = 'Restore session', icon = { icon = '󰖲', hl = hlbufwind } },

        { '<leader>t', group = 'Test', icon = { icon = '', hl = hlquality } },
        { '<leader>ta', group = 'Attach', icon = '󰁦' },
        { '<leader>td', group = 'Debug' },
        { '<leader>tr', group = 'Run', icon = '󰜎' },
        { '<leader>ts', group = 'Stop', icon = '' },
        { '<leader>to', group = 'Output panel', icon = '' },

        { '<leader>u', group = 'UI/UX', icon = { icon = '󰙵', hl = hlnvim } },

        { '<leader>w', group = 'Window', icon = { icon = '', hl = hlbufwind } },
        { '<leader>wm', group = 'Move window (swap)', icon = '󰆾' },

        { '<leader>q', group = 'Quit / close', icon = { icon = '󰈆 ', hl = hlbufwind } },

        { '<leader>x', group = 'Diagnostics', icon = { icon = '󱖫', hl = hlquality } },

        -- visual mode

        { '<leader>g', mode = 'v', group = 'Git', icon = { hl = hlquality } },
        { '<leader>s', mode = 'v', group = 'Screenshot', icon = { icon = '󰹑', hl = hlquality } },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
