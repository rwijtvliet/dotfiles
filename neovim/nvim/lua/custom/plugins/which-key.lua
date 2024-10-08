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
      require('which-key').add {
        { '<leader>b', group = '  Buffer (and tab)' },
        { '<leader>bc', group = '  Close' },

        { '<leader>d', group = '  Debug' },

        { '<leader>f', group = 'File', icon = '' },

        { '<leader>g', group = ' Git' },
        { '<leader>ga', group = ' Add (stage)', icon = '' },
        { '<leader>gu', group = ' Unstage', icon = '' },
        { '<leader>gD', group = ' Diff', icon = '' },
        { '<leader>gt', group = ' Toggle', icon = '' },
        { '<leader>gr', group = ' Reset' },

        { '<leader>l', group = '  Lsp and code' },

        { '<leader>m', group = '  Terminal' },

        { '<leader>M', group = '  Markdown' },

        { '<leader>P', group = '  Plugins' },

        { '<leader>J', group = ' Run code (jukit)', icon = '󰜎' },
        -- { '<leader>k',  group = ' Run code (jupynium)', icon = '󰜎' },
        { '<leader>r', group = ' Run code (iron)', icon = '󰜎' },
        -- { '<leader>R',  group = ' Run code (molten)', icon = '󰜎' },

        { '<leader>s', group = '  Search' },

        { '<leader>S', group = ' 󰖲 Restore session' },

        { '<leader>t', group = '  Test' },
        { '<leader>tf', group = '  File' },
        { '<leader>tt', group = '  Toggle' },

        { '<leader>u', group = ' 󰉼 UI/UX' },

        { '<leader>w', group = '  Window' },
        { '<leader>wm', group = ' 󰆾 Move window (swap)' },

        { '<leader>q', group = '  Quit / close' },

        { '<leader>x', group = '  Diagnostics' },
      }
      -- visual mode
      require('which-key').add({
        { '<leader>g', group = ' 󰊢 Git' },
        { '<leader>s', group = ' 󰹑 Screenshot' },
      }, { mode = 'v' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
