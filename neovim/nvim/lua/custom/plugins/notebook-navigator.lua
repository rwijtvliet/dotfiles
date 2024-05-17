return {
  'GCBallesteros/NotebookNavigator.nvim',
  dependencies = {
    'echasnovski/mini.comment',
    'hkupty/iron.nvim', -- repl provider
    -- "akinsho/toggleterm.nvim", -- alternative repl provider
    -- "benlubas/molten-nvim", -- alternative repl provider
    --
    -- Navigate through notebook.
    {
      'anuvyklack/hydra.nvim',
      config = function()
        local notebooknav_hydra = require 'hydra' {
          name = 'navigate notebook',
          hint = [[ 
  _t_ / _n_: move up/down          _x_: run cell         _X_: run cell + move down  
                             (Quit with _q_ or _<Esc>_)
              ]], -- multiline string
          config = {
            foreign_keys = 'run',
            invoke_on_body = true,
            hint = {
              position = 'bottom',
              border = 'rounded',
            },
          },
          mode = 'n',
          heads = {
            --stylua: ignore start
            { 't', function() require('notebook-navigator').move_cell 'u' end,     desc = 'Move up' },
            { 'n', function() require('notebook-navigator').move_cell 'd' end,     desc = 'Move down' },
            { 'x', function() require('notebook-navigator').run_cell()  end,       desc = 'Run cell' },
            { 'X', function() require('notebook-navigator').run_and_move()  end,   desc = 'Run cell + move down' },
            { '<Esc>', nil, { exit = true } },
            { 'q', nil, { exit = true } },
            --stylua: ignore end
          },
        }
        --stylua: ignore start
        vim.keymap.set('n', '<leader>rn', function() notebooknav_hydra:activate() end, { desc = 'Notebook: navigate' })
        --stylua: ignore end
      end,
    },

    -- Highlight cell boundaries.
    {
      'echasnovski/mini.hipatterns',
      event = 'VeryLazy',
      opts = function()
        return { highlighters = { cells = require('notebook-navigator').minihipatterns_spec } }
      end,
    },
  },
  event = 'VeryLazy',
  opts = {},
  keys = {
    -- stylua: ignore start
    { '<leader>rx', function() require('notebook-navigator').run_cell() end,     desc = 'Notebook: run cell' },
    { '<leader>rX', function() require('notebook-navigator').run_and_move() end, desc = 'Notebook: run cell + move' },
    { ']h', function() require('notebook-navigator').move_cell 'd' end,          desc = 'Notebook: next cell ' },
    { '[h', function() require('notebook-navigator').move_cell 'u' end,          desc = 'Notebook: prev cell ' },
    -- stylua: ignore end
  },
}
