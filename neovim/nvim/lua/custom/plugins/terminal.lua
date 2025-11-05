return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      vim.keymap.set('n', '<leader>mf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'ToggleTerm float' })
      vim.keymap.set('n', '<leader>mh', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', { desc = 'ToggleTerm horizontal split' })
      vim.keymap.set('n', '<leader>mv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = 'ToggleTerm vertical split' })
      vim.keymap.set('n', '<leader>mt', '<cmd>ToggleTerm direction=tab<cr>', { desc = 'ToggleTerm in tab' })
      vim.keymap.set('t', '<F12>', '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = 'Toggle terminal' })
      -- vim.keymap.set('i', '<F12>', '<Cmd>execute v:count . "ToggleTerm"<CR>', { desc = 'Toggle terminal' })

      require('toggleterm').setup {
        open_mapping = '<F12>',
        highlights = {
          Normal = { link = 'Normal' },
          NormalNC = { link = 'NormalNC' },
          NormalFloat = { link = 'NormalFloat' },
          FloatBorder = { link = 'FloatBorder' },
          StatusLine = { link = 'StatusLine' },
          StatusLineNC = { link = 'StatusLineNC' },
          WinBar = { link = 'WinBar' },
          WinBarNC = { link = 'WinBarNC' },
        },
        size = 10,
        ---@param t Terminal
        on_create = function(t)
          vim.opt.foldcolumn = '0'
          vim.opt.signcolumn = 'no'
          -- local toggle = function()
          --   t:toggle()
          -- end
          vim.keymap.set({ 'n', 't', 'i' }, "<C-'>", function()
            t:toggle()
          end, { desc = 'Toggle terminal', buffer = t.bufnr })
          vim.keymap.set({ 'n', 't', 'i' }, '<F12>', function()
            t:toggle()
          end, { desc = 'Toggle terminal', buffer = t.bufnr })
        end,
        shading_factor = 2,
        direction = 'float',
        float_opts = { border = 'rounded' },
      }
    end,
  },
}
