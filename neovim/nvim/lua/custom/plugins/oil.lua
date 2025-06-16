return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>E', '<Cmd>Oil --float<Cr>', desc = "Oil: current file's dir" },
  },
  opts = {
    use_default_keymaps = false,
    keymaps = {
      ['?'] = 'actions.show_help',
      --
      ['<Cr>'] = 'actions.select',
      ['<Bs>'] = 'actions.parent',
      ['.'] = 'actions.cd',
      ['_'] = 'actions.open_cwd',
      --
      ['<Esc>'] = 'actions.close',
      ['<leader>E'] = 'actions.close',
      --
      ['<C-p>'] = 'actions.preview',
      ['<C-u>'] = 'actions.preview_scroll_up',
      ['<C-d>'] = 'actions.preview_scroll_down',
      --
      ['<C-s>'] = 'actions.change_sort',
      ['<C-r>'] = 'actions.refresh',
      ['<C-h>'] = 'actions.toggle_hidden',
      --
      ['<C-t>'] = 'actions.open_terminal',
      ['<C-x>'] = 'actions.open_external',
      --
      ['|'] = 'actions.select_vsplit',
      ['\\'] = 'actions.select_split',
    },
  },
}
