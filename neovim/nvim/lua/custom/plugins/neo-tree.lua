-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute { source = 'filesystem', toggle = true }
      end,
      desc = 'File explorer',
    },
    -- {
    --   '<leader>re',
    --   function()
    --     require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }
    --   end,
    --   desc = 'File explorer (cwd)',
    -- },
    {
      '<leader>ge',
      function()
        require('neo-tree.command').execute { source = 'git_status', toggle = true }
      end,
      desc = 'Git [e]xplorer',
    },
    {
      '<leader>be',
      function()
        require('neo-tree.command').execute { source = 'buffers', toggle = true }
      end,
      desc = 'Buffer [e]xplorer',
    },
  },
  opts = {
    window = {
      mappings = {
        ['<A-h>'] = 'prev_source',
        ['<A-s>'] = 'next_source',
        ['l'] = 'noop',
        ['s'] = 'noop', --"child_or_open",
        ['n'] = 'noop',
        ['t'] = 'noop',
        ['<'] = 'noop',
        ['>'] = 'noop',
        ['_'] = 'open_tabnew',
        ['|'] = 'open_vsplit',
        ['\\'] = 'open_split',
      },
    },
    filesystem = {
      filtered_items = { visible = true },
    },
  },
}
