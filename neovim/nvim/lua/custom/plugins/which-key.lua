-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
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
      require('which-key').setup()
      require('which-key').register {
        ['<leader>b'] = { name = '  Buffer (and tab)', _ = 'which_key_ignore' },
        ['<leader>bc'] = { name = '  Close', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '  Debug', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '  File', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = ' 󰊢 Git', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '  Lsp and code', _ = 'which_key_ignore' },
        ['<leader>p'] = { name = '  Plugins', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '  Search', _ = 'which_key_ignore' },
        ['<leader>S'] = { name = ' 󰖲 Session', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '  Terminal', _ = 'which_key_ignore' },
        ['<leader>T'] = { name = '  Test', _ = 'which_key_ignore' },
        ['<leader>u'] = { name = ' 󰉼 UI/UX', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '  Window', _ = 'which_key_ignore' },
        ['<leader>wm'] = { name = ' 󰆾 Move window (swap)', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = '  Quit / close', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = '  Diagnostics', _ = 'which_key_ignore' },
      }
      -- visual mode
      -- require('which-key').register({
      --   ['<leader>h'] = { 'Git [H]unk' },
      -- }, { mode = 'v' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
