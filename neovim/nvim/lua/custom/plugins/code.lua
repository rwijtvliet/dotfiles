return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Find problems in code
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Trouble: diagnostics',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Trouble: diagnostics (current buffer)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Trouble: symbols',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'Trouble: definitions / references / ...',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Trouble: location list',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Trouble: quickfix list',
      },
    },
  },

  -- Make snapshots.
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    keys = {
      { '<leader>ss', '<Esc><Cmd>CodeSnap<Cr>', mode = 'x', desc = 'Selection to clipboard' },
      { '<leader>sh', '<Esc><Cmd>CodeSnapHighlight<Cr>', mode = 'x', desc = 'Selection with highlights to clipboard' },
    },
    opts = {
      mac_window_bar = false,
      save_path = vim.fn.expand '~/Pictures',
      has_breadcrumbs = true,
      bg_theme = 'sea',
      watermark = '',
    },
  },
}
