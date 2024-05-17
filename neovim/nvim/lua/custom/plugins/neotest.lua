return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/nvim-nio',
    'folke/neodev.nvim',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-python',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
        --require "neotest-vim-test" {
        --  ignore_file_types = { "python", "vim", "lua" },
        --},
      },
    }
  end,
  -- -- nearest
  -- -- stylua: ignore start
  -- vim.keymap.set('n', '<leader>tr', function() require('neotest').run.run() end,
  --   { desc = 'Neotest: run nearest' })
  -- vim.keymap.set('n', '<leader>td', function() require('neotest').run.run { strategy = 'dap' } end,
  --   { desc = 'Neotest: debug nearest' })
  -- vim.keymap.set('n', '<leader>ts', function() require('neotest').run.stop() end,
  --   { desc = 'Neotest: stop nearest' })
  -- vim.keymap.set('n', '<leader>ta', function() require('neotest').run.attach() end,
  --   { desc = 'Neotest: attach to nearest' })
  -- -- file
  -- vim.keymap.set('n', '<leader>tfr', function() require('neotest').run.run { vim.fn.expand '%' } end,
  --   { desc = 'Neotest: run file' })
  -- vim.keymap.set('n', '<leader>tfd', function() require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' } end,
  --   { desc = 'Neotest: debug file' })
  -- vim.keymap.set('n', '<leader>tfs', function() require('neotest').run.stop { vim.fn.expand '%' } end,
  --   { desc = 'Neotest: stop file' })
  -- vim.keymap.set('n', '<leader>tfa', function() require('neotest').run.attach { vim.fn.expand '%' } end,
  --   { desc = 'Neotest: attach to file' })
  -- -- last
  -- vim.keymap.set('n', '<leader>tR', function() require('neotest').run.run_last() end,
  --   { desc = 'Neotest: run last' })
  -- vim.keymap.set('n', '<leader>tD', function() require('neotest').run.run_last { strategy = 'dap' } end,
  --   { desc = 'Neotest: debug last' })
  -- -- other functionality
  -- vim.keymap.set('n', '<leader>to', function() require('neotest').output_panel.toggle() end,
  --   { desc = 'Neotest: toggle output panel' })
  -- vim.keymap.set('n', '<leader>tu', function() require('neotest').summary.toggle() end,
  --   { desc = 'Neotest: toggle summary' })
  -- vim.keymap.set('n', '[n', function() require('neotest').jump.prev { status='failed' } end,
  --   { desc = 'Neotest: prev failed' })
  -- vim.keymap.set('n', ']n', function() require('neotest').jump.next { status='failed' } end,
  --   { desc = 'Neotest: next failed' })
  -- stylua: ignore end
  keys = {
    -- stylua: ignore start
    { '<leader>tr', function() require('neotest').run.run() end,                                        desc = 'Neotest: run nearest' },
    { '<leader>td', function() require('neotest').run.run { strategy = 'dap' } end,                     desc = 'Neotest: debug nearest' },
    { '<leader>ts', function() require('neotest').run.stop() end,                                       desc = 'Neotest: stop nearest' },
    { '<leader>ta', function() require('neotest').run.attach() end,                                     desc = 'Neotest: attach to nearest' },
    { '<leader>tfr', function() require('neotest').run.run { vim.fn.expand '%' } end,                   desc = 'Neotest: run file' },
    { '<leader>tfd', function() require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' } end, desc = 'Neotest: debug file' },
    { '<leader>tfs', function() require('neotest').run.stop { vim.fn.expand '%' } end,                  desc = 'Neotest: stop file' },
    { '<leader>tfa', function() require('neotest').run.attach { vim.fn.expand '%' } end,                desc = 'Neotest: attach to file' },
    { '<leader>tR', function() require('neotest').run.run_last() end,                                   desc = 'Neotest: run last' },
    { '<leader>tD', function() require('neotest').run.run_last { strategy = 'dap' } end,                desc = 'Neotest: debug last' },
    { '<leader>to', function() require('neotest').output_panel.toggle() end,                            desc = 'Neotest: toggle output panel' },
    { '<leader>tu', function() require('neotest').summary.toggle() end,                                 desc = 'Neotest: toggle summary' },
    { '[n', function() require('neotest').jump.prev { status = 'failed' } end,                          desc = 'Neotest: prev failed' },
    { ']n', function() require('neotest').jump.next { status = 'failed' } end,                          desc = 'Neotest: next failed' },
    -- stylua: ignore end
  },
}
