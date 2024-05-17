return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▐' },
        change = { text = '▐' },
        untracked = { text = '▗' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
          --stylua: ignore start
          if vim.wo.diff then vim.cmd.normal { ']g', bang = true } else gitsigns.nav_hunk 'next' end
          --stylua: ignore end
        end, { desc = 'Git: next change' })
        map('n', '[g', function()
          --stylua: ignore start
          if vim.wo.diff then vim.cmd.normal { '[g', bang = true } else gitsigns.nav_hunk 'prev' end
          --stylua: ignore end
        end, { desc = 'Git: prev change' })

        -- Actions
        -- visual mode
        --stylua: ignore start
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Git: stage hunk' })
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Git: reset hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk,                   { desc = 'Git: stage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk,                   { desc = 'Git: reset hunk' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk,              { desc = 'Git: undo stage hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer,                 { desc = 'Git: stage entire buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer,                 { desc = 'Git: reset entire buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk,                 { desc = 'Git: preview hunk' })
        map('n', '<leader>gb', gitsigns.blame_line,                   { desc = 'Git: blame current line' })
        -- Diff
        map('n', '<leader>gDd', gitsigns.diffthis,                    { desc = 'Git: diff against index' })
        map('n', '<leader>gDc', function() gitsigns.diffthis '@' end, { desc = 'Git: diff against last commit' })
        -- Toggles
        map('n', '<leader>gtb', gitsigns.toggle_current_line_blame,    { desc = 'Git: toggle show blame' })
        map('n', '<leader>gtd', gitsigns.toggle_deleted,               { desc = 'Git: toggle show deleted' })
        map('n', '<leader>gth', "<Cmd>Gitsigns toggle_linehl<Cr>",     { desc = 'Git: toggle line highlighting' })
        --stylua: ignore end
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
