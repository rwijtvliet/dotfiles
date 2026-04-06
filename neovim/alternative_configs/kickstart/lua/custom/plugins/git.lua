return {
  {
    'tpope/vim-fugitive',
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▐' },
        change = { text = '▐' },
        untracked = { text = '▗' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 300,
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- Navigation
        vim.keymap.set('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal { ']g', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { buffer = bufnr, desc = 'Next git change' })
        vim.keymap.set('n', ']G', function()
          if vim.wo.diff then
            vim.cmd.normal { ']G', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next git change (project)' })
        vim.keymap.set('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal { '[g', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { buffer = bufnr, desc = 'Prev git change' })
        vim.keymap.set('n', '[G', function()
          if vim.wo.diff then
            vim.cmd.normal { '[G', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Prev git change (buffer)' })

        -- Actions
        --- In visual mode
        vim.keymap.set('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { buffer = bufnr, desc = 'Git: stage hunk' })
        vim.keymap.set('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { buffer = bufnr, desc = 'Git: reset hunk' })
        --- In normal mode
        vim.keymap.set('n', '<leader>gah', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Git: add (stage) hunk' })
        vim.keymap.set('n', '<leader>gab', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Git: add (stage) entire buffer' })
        vim.keymap.set('n', '<leader>guh', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Git: unstage hunk' })
        vim.keymap.set('n', '<leader>grh', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Git: reset hunk' })
        vim.keymap.set('n', '<leader>grb', gitsigns.reset_buffer, { buffer = bufnr, desc = 'Git: reset entire buffer' })
        vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Git: preview hunk' })
        vim.keymap.set('n', '<leader>gB', gitsigns.blame_line, { buffer = bufnr, desc = 'Git: blame current line' })
        ----- Diff
        vim.keymap.set('n', '<leader>gDd', gitsigns.diffthis, { buffer = bufnr, desc = 'Git: diff against index' })
        vim.keymap.set('n', '<leader>gDc', function()
          gitsigns.diffthis '@'
        end, { buffer = bufnr, desc = 'Git: diff against last commit' })
        ----- Toggles
        vim.keymap.set('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Git: toggle show blame' })
        vim.keymap.set('n', '<leader>gtd', gitsigns.toggle_deleted, { buffer = bufnr, desc = 'Git: toggle show deleted' })
        vim.keymap.set('n', '<leader>gth', '<Cmd>Gitsigns toggle_linehl<Cr>', { buffer = bufnr, desc = 'Git: toggle line highlighting' })
      end,
    },
  },

  -- lazygit
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gl', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
