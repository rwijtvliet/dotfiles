return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    dependencies = { { 'willothy/wezterm.nvim', config = true } },
    config = function()
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_image_provider = 'wezterm'
      vim.g.molten_auto_open_output = false
      vim.g.molten_split_direction = 'bottom'
      vim.g.molten_split_size = 30
    end,
    keys = {
      -- Normal mode
      { '<leader>Ri', '<Cmd>MoltenImagePopup<Cr>', desc = 'Show image' },
      { '<leader>Rl', '<Cmd>MoltenEvaluateLine<Cr>', desc = 'Run current line' },
      { '<leader>Rs', '<Cmd>MoltenShowOutput<Cr>', desc = 'Show output' },
      { '<leader>Rh', '<Cmd>MoltenHideOutput<Cr>', desc = 'Hide output' },
      { '<leader>Rx', '<Cmd>MoltenReevaluateCell<Cr>', desc = 'Run cell' },
      { '<leader>RR', '<Cmd>noautocmd MoltenEnterOutput<Cr>', desc = 'Enter output window' },
      { '<leader>Ro', '<Cmd>MoltenEvaluateOperator<Cr>', desc = 'Run + operator' },
      -- Visual mode
      { '<leader>R', ':<C-u>MoltenEvaluateVisual<CR>gv', desc = 'Run selection', mode = 'v' },
    },
  },
  -- -   dependencies = {
  --     {
  --       'vhyrro/luarocks.nvim',
  --       priority = 1001, -- this plugin needs to run before anything else
  --       opts = {
  --         rocks = { 'magick' },
  --       },
  --     },
  --   },
  --   opts = {
  --     backend = 'ueberzug',
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
  --       },
  --       neorg = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { 'norg' },
  --       },
  --       html = {
  --         enabled = false,
  --       },
  --       css = {
  --         enabled = false,
  --       },
  --     },
  --     max_width = nil,
  --     max_height = nil,
  --     max_width_window_percentage = nil,
  --     max_height_window_percentage = 50,
  --     window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  --     window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
  --     editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --     ,
  -- },

  -- Iron.
  -- (+) Works.
  -- (-) Cannot display images inline (?)
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
            python = {
              format = require('iron.fts.common').bracketed_paste,
              command = { 'ipython', '--no-autoindent', '--nosep' },
            },
            -- python = { command = 'ipython --nosep --no-autoindent' }, -- NOTE: currently not used due to ipython crash with matplotlib.
            -- python = { command = 'python' },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').split.vertical.botright(0.40, {
            winfixwidth = false,
            winfixheight = false,
            number = true,
          }),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        -- keymaps = {
        --   send_motion = '<leader>rc',
        --   send_mark = '<leader>rm',
        --   mark_motion = '<leader>mc',
        --   mark_visual = '<leader>mc',
        --   remove_mark = '<leader>md',
        --   cr = '<leader>r<cr>',
        --   interrupt = '<leader>r<leader>',
        --   exit = '<leader>rq',
        --   clear = '<leader>cl',
        -- },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      --stylua: ignore start
      -- iron also has a list of commands, see :h iron-commands for all available commands

      -- from outside REPL only
      vim.keymap.set('n', '<leader>rr', function() iron.repl_for(vim.bo.filetype) end, { desc = 'REPL: start/toggle/hide (from code buffer)' })
      vim.keymap.set('n', '<leader>rf', function() iron.focus_on(vim.bo.filetype) end, { desc = 'REPL: focus on repl (from code buffer)' })
      vim.keymap.set('n', '<leader>rC', function() iron.close_repl(vim.bo.filetype) end, { desc = 'REPL: close (from code buffer)' })
      -- vim.keymap.set('n', 'gR', iron.send_motion, { desc = 'Run motion' }) -- TODO: not working
      vim.keymap.set('n', '<leader>rl', iron.send_line, { desc = 'Run line' })
      vim.keymap.set('n', '<leader>rp', iron.send_paragraph, { desc = 'Run paragraph' })
      vim.keymap.set('n', '<leader>rc', iron.send_until_cursor, { desc = 'Run until cursor' })
      vim.keymap.set('n', '<leader>rb', iron.send_file, { desc = 'Run buffer' })

      -- from inside REPL only
      vim.keymap.set('n', '<leader>rR', iron.repl_restart, { desc = 'REPL: restart (from inside REPL)' })

      -- visual mode
      vim.keymap.set('v', '<leader>r', iron.visual_send, { desc = 'Run selection' })
      --stylua: ignore end
    end,
  },
  {
    'kiyoon/jupynium.nvim',
    build = 'pip3 install --user .',
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
    dependencies = {
      'rcarriga/nvim-notify', -- optional
      'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect
    },
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
