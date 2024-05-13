return {
  -- Statusline
  -- {
  --   'echasnovski/mini.statusline',
  --   opts = {
  --     use_icons = vim.g.have_nerd_font,
  --   },
  --   config = function(_, opts)
  --     require('mini.statusline').setup(opts)
  --     require('mini.statusline').section_location = function()
  --       return '%2l:%-2v'
  --     end
  --   end,
  -- },
  -- Better around/inside objects
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - ci'  - [C]hange [I]nside [']quote
  {
    'echasnovski/mini.ai',
    opts = { n_lines = 500 },
  },
  -- surround text with parens
  {
    'echasnovski/mini.surround',
    -- keys = function(_, keys)
    --   -- Populate the keys based on the user's options
    --   local plugin = require('lazy.core.config').spec.plugins['mini.surround']
    --   local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
    --   local mappings = {
    --     { opts.mappings.add, desc = 'Add Surrounding', mode = { 'n', 'v' } },
    --     { opts.mappings.delete, desc = 'Delete Surrounding' },
    --     { opts.mappings.replace, desc = 'Replace Surrounding' },
    --     { opts.mappings.find, desc = 'Find Right Surrounding' },
    --     { opts.mappings.find_left, desc = 'Find Left Surrounding' },
    --     { opts.mappings.highlight, desc = 'Highlight Surrounding' },
    --     { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
    --   }
    --   mappings = vim.tbl_filter(function(m)
    --     return m[1] and #m[1] > 0
    --   end, mappings)
    --   return vim.list_extend(mappings, keys)
    -- end,
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        --e.g. gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        --e.g. gsaa}) - [S]urround [A]dd [A]round [}]Braces [)]Paren
        delete = 'gsd', -- Delete surrounding
        --e.g.    gsd"   - [S]urround [D]elete ["]quotes
        replace = 'gsr', -- Replace surrounding
        --e.g.     gsr)'  - [S]urround [R]eplace [)]Paren by [']quote
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
      n_lines = 500,
    },
  },
  -- autopairs
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      mappings = {
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\`].', register = { cr = false } },
      },
    },
    keys = {
      {
        '<leader>ua',
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          vim.notify('Auto pairs ' .. (vim.g.minipairs_disable and 'off' or 'on'))
        end,
        desc = 'Toggle auto pairs',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
