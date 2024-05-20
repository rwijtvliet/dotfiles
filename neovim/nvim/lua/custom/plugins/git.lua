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

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        --stylua: ignore start
        map('n', ']g', function() if vim.wo.diff then vim.cmd.normal { ']g', bang = true } else gitsigns.nav_hunk 'next' end end, { desc = 'Git: next change' })
        map('n', '[g', function() if vim.wo.diff then vim.cmd.normal { '[g', bang = true } else gitsigns.nav_hunk 'prev' end end, { desc = 'Git: prev change' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Git: stage hunk' })
        map('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Git: reset hunk' })
        -- normal mode
        map('n', '<leader>gah', gitsigns.stage_hunk,                   { desc = 'Git: add (stage) hunk' })
        map('n', '<leader>gab', gitsigns.stage_buffer,                 { desc = 'Git: add (stage) entire buffer' })
        map('n', '<leader>guh', gitsigns.undo_stage_hunk,              { desc = 'Git: unstage hunk' })
        map('n', '<leader>grh', gitsigns.reset_hunk,                   { desc = 'Git: reset hunk' })
        map('n', '<leader>grb', gitsigns.reset_buffer,                 { desc = 'Git: reset entire buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk,                 { desc = 'Git: preview hunk' })
        map('n', '<leader>gB', gitsigns.blame_line,                   { desc = 'Git: blame current line' })
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
