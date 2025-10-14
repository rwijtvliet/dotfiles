return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  -- opts = { modes = { char = { keys = { ["t"] = "k", ["T"] = "K" } } } },
  opts = { --function(_, opts)
    -- return vim.tbl_deep_extend('force', opts, {
    labels = 'aoeuidhtnspyfgcrlqjkxbmwvz',
    -- modes = { char = { keys = { "f", "F", ["t"] = "k", ["K"] = "T", ";", "." } } },
    modes = {
      search = { enabled = true },
      char = { keys = { 'f', 'F', ';', '.', ['t'] = 'k', ['T'] = 'K' } },
    },
    remote_op = { restore = true },
    -- })
    -- end,
  },
  keys = {
    {
      'gj',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash: jump',
    },
    {
      'gJ',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash: treesitter',
    },
    {
      'gw',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump { pattern = vim.fn.expand '<cword>' }
      end,
      desc = 'Flash: jump (current word)',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Flash: remote',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Flash: treesitter search',
    },
    {
      '<leader>uf',
      mode = { 'n' },
      function()
        require('flash').toggle()
        vim.notify 'Toggling search with flash'
      end,
      desc = 'Toggle flash (for finding) on/off',
    },
  },
}
