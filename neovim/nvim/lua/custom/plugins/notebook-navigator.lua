return {
  {
    'GCBallesteros/NotebookNavigator.nvim',
    dependencies = {
      'echasnovski/mini.comment',
      'Vigemus/iron.nvim', -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      -- 'benlubas/molten-nvim', -- alternative repl provider
      --
      -- Menu to navigate through notebook.
      {
        'anuvyklack/hydra.nvim',
        config = function()
          local notebooknav_hydra = require 'hydra' {
            name = 'navigate notebook',
            hint = [[ _t_ / _n_: move up/down          _x_: run cell         _y_: run cell + move down  
                         (Quit with _q_ or _<Esc>_) ]],
            config = { invoke_on_body = true, hint = { position = 'bottom', border = 'rounded' } },
            mode = 'n',
            heads = {
            --stylua: ignore start
            { 't', function() require('notebook-navigator').move_cell 'u' end,     desc = 'Move up' },
            { 'n', function() require('notebook-navigator').move_cell 'd' end,     desc = 'Move down' },
            { 'x', function() require('notebook-navigator').run_cell()  end,       desc = 'Run cell' },
            { 'y', function() require('notebook-navigator').run_and_move()  end,   desc = 'Run cell + move down' },
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
    },
    event = 'VeryLazy',
    opts = {
      cell_highlight_group = 'Function',
    },
    keys = {
    -- stylua: ignore start
    { '<leader>rx', function() require('notebook-navigator').run_cell() end,     desc = 'Run cell' },
    { '<leader>ry', function() require('notebook-navigator').run_and_move() end, desc = 'Run cell + move' },
    { ']c', function() require('notebook-navigator').move_cell 'd' end,          desc = 'Next notebook cell' },
    { '[c', function() require('notebook-navigator').move_cell 'u' end,          desc = 'Prev notebook cell' },
      -- stylua: ignore end
    },
  },

  -- Highlight cell boundaries.
  {
    'echasnovski/mini.hipatterns',
    after = 'notebook-navigator',
    lazy = false, -- TODO: plugin doesn't always load (?) and trying to set lazy to false to force loading
    event = 'BufEnter *.py',
    opts = function()
      return { highlighters = { cells = require('notebook-navigator').minihipatterns_spec } }
    end,
  },
}
