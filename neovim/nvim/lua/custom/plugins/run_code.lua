return {
  {
    'Vigemus/iron.nvim',
    config = function()
      local iron = require 'iron.core'

      iron.setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { 'zsh' },
            },
            python = { command = 'python3' },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').right(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = '<leader>rc',
          visual_send = '<leader>rc',
          send_file = '<leader>rf',
          send_line = '<leader>rl',
          send_paragraph = '<leader>rp',
          send_until_cursor = '<leader>ru',
          send_mark = '<leader>rm',
          mark_motion = '<leader>mc',
          mark_visual = '<leader>mc',
          remove_mark = '<leader>md',
          cr = '<leader>r<cr>',
          interrupt = '<leader>r<leader>',
          exit = '<leader>rq',
          clear = '<leader>cl',
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
      vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
      vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
    end,
  },
}

-- return {
--   {
--     'CRAG666/code_runner.nvim',
--     dependencies = {
--       'CRAG666/betterTerm.nvim',
--       opts = {
--         position = 'bot',
--         size = 15,
--       },
--       config = function()
--         local betterTerm = require 'betterTerm'
--         -- toggle firts term
--         vim.keymap.set({ 'n', 't' }, '<C-;>', betterTerm.open, { desc = 'Open terminal' })
--         -- Select term focus
--         vim.keymap.set({ 'n' }, '<leader>Tt', betterTerm.select, { desc = 'Select terminal' })
--         -- Create new term
--         local current = 2
--         vim.keymap.set({ 'n' }, '<leader>Tn', function()
--           betterTerm.open(current)
--           current = current + 1
--         end, { desc = 'New terminal' })
--       end,
--     },
--     config = function()
--       require('code_runner').setup {
--         filetype = {
--           java = {
--             'cd $dir &&',
--             'javac $fileName &&',
--             'java $fileNameWithoutExt',
--           },
--           python = 'python3 -u',
--           typescript = 'deno run',
--           rust = {
--             'cd $dir &&',
--             'rustc $fileName &&',
--             '$dir/$fileNameWithoutExt',
--           },
--           c = function(...)
--             local c_base = {
--               'cd $dir &&',
--               'gcc $fileName -o',
--               '/tmp/$fileNameWithoutExt',
--             }
--             local c_exec = {
--               '&& /tmp/$fileNameWithoutExt &&',
--               'rm /tmp/$fileNameWithoutExt',
--             }
--             vim.ui.input({ prompt = 'Add more args:' }, function(input)
--               c_base[4] = input
--               vim.print(vim.tbl_extend('force', c_base, c_exec))
--               require('code_runner.commands').run_from_fn(vim.list_extend(c_base, c_exec))
--             end)
--           end,
--         },
--       }
--       vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
--       vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
--       vim.keymap.set('n', '<leader>rt', ':RunFile tab<CR>', { noremap = true, desc = 'Run file in tab' })
--       vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
--       vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
--       vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
--       vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
--     end,
--   },
-- }
