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
      require('which-key').register {
        ['<leader>b'] = { name = '  Buffer (and tab)', _ = 'which_key_ignore' },
        ['<leader>bc'] = { name = '  Close', _ = 'which_key_ignore' },

        ['<leader>d'] = { name = '  Debug', _ = 'which_key_ignore' },

        ['<leader>f'] = { name = '  File', _ = 'which_key_ignore' },

        ['<leader>g'] = { name = ' 󰊢 Git', _ = 'which_key_ignore' },
        ['<leader>ga'] = { name = '  Add (stage)', _ = 'which_key_ignore' },
        ['<leader>gu'] = { name = '  Unstage', _ = 'which_key_ignore' },
        ['<leader>gD'] = { name = '  Diff', _ = 'which_key_ignore' },
        ['<leader>gt'] = { name = '  Toggle', _ = 'which_key_ignore' },

        ['<leader>l'] = { name = '  Lsp and code', _ = 'which_key_ignore' },

        ['<leader>m'] = { name = '  Markdown', _ = 'which_key_ignore' },

        ['<leader>p'] = { name = '  Plugins', _ = 'which_key_ignore' },

        ['<leader>r'] = { name = ' 󰜎 Run code', _ = 'which_key_ignore' },

        ['<leader>s'] = { name = '  Search', _ = 'which_key_ignore' },

        ['<leader>S'] = { name = ' 󰖲 Restore session', _ = 'which_key_ignore' },

        ['<leader>t'] = { name = '  Test', _ = 'which_key_ignore' },
        ['<leader>tf'] = { name = '  File', _ = 'which_key_ignore' },
        ['<leader>tt'] = { name = '  Toggle', _ = 'which_key_ignore' },

        ['<leader>T'] = { name = '  Terminal', _ = 'which_key_ignore' },

        ['<leader>u'] = { name = ' 󰉼 UI/UX', _ = 'which_key_ignore' },

        ['<leader>w'] = { name = '  Window', _ = 'which_key_ignore' },
        ['<leader>wm'] = { name = ' 󰆾 Move window (swap)', _ = 'which_key_ignore' },

        ['<leader>q'] = { name = '  Quit / close', _ = 'which_key_ignore' },

        ['<leader>x'] = { name = '  Diagnostics', _ = 'which_key_ignore' },
      }
      -- visual mode
      require('which-key').register({
        ['<leader>g'] = { name = ' 󰊢 Git', _ = 'which_key_ignore' },
      }, { mode = 'v' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
