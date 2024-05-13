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
      desc = 'Flash',
    },
    {
      'gJ',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'gw',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump { pattern = vim.fn.expand '<cword>' }
      end,
      desc = 'Flash (current word)',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<leader>uj',
      mode = { 'n' },
      function()
        require('flash').toggle()
        vim.notify 'Toggling search with flash'
      end,
      desc = 'Toggle searching with flash',
    },
  },
}
