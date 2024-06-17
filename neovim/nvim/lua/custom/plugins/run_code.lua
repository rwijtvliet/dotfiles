return {
  -- Molten.
  -- Run code in ipython, but not in separate window. Instead, see output as floating window on top of source code.
  -- (-) Cannot access the ipython instance to "play around" with code.
  -- (-) Cannot run code cells defined by `# %%` markers (has own concept of "cells").
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    dependencies = {
      'folke/which-key.nvim',
      -- In molten_image_provider, below, use ...
      { -- ... "wezterm", or ...
        'willothy/wezterm.nvim',
        config = true,
        enabled = true,
      },
      {
        -- ... "image.nvim"
        '3rd/image.nvim',
        enabled = false,
        dependencies = {
          'vhyrro/luarocks.nvim',
          priority = 1001, -- this plugin needs to run before anything else
          opts = { rocks = { 'magick' } },
        },
        opts = { backend = 'kitty' },
      },
    },
    config = function()
      require('which-key').register { ['<leader>R'] = { name = ' 󰜎 Run code (molten)', _ = 'which_key_ignore' } }
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_image_provider = 'wezterm'
      vim.g.molten_auto_open_output = false
      vim.g.molten_split_direction = 'right'
      vim.g.molten_split_size = 30
    end,
    keys = {
      -- Normal mode
      { '<leader>Ra', '<Cmd>MoltenInit<Cr>', desc = 'Start' },
      { '<leader>Ri', '<Cmd>MoltenImagePopup<Cr>', desc = 'Show image' },
      { '<leader>Rl', '<Cmd>MoltenEvaluateLine<Cr>', desc = 'Run current line' },
      { '<leader>Rs', '<Cmd>MoltenShowOutput<Cr>', desc = 'Show output' },
      { '<leader>Rh', '<Cmd>MoltenHideOutput<Cr>', desc = 'Hide output' },
      { '<leader>Rx', '<Cmd>MoltenReevaluateCell<Cr>', desc = 'Run cell' },
      { '<leader>RR', '<Cmd>noautocmd MoltenEnterOutput<Cr>', desc = 'Enter output window' },
      { '<leader>Ro', '<Cmd>MoltenEvaluateOperator<Cr>', desc = 'Run + operator' },
      -- Visual mode
      { '<leader>R', ':<C-u>MoltenEvaluateVisual<CR>', desc = 'Run selection', mode = 'v' },
    },
  },

  -- Iron.
  -- Run code in ipython window inside neovim.
  -- (+) Works.
  -- (-) Cannot display images inline (?).
  {
    'Vigemus/iron.nvim',
    dependencies = { 'folke/which-key.nvim' },
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
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = { italic = true }, -- make code that was just sent italic
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands

      require('which-key').register { ['<leader>r'] = { name = ' 󰜎 Run code (iron)', _ = 'which_key_ignore' } }
      -- from outside REPL only
      vim.keymap.set('n', '<leader>rr', function()
        iron.repl_for(vim.bo.filetype)
      end, { desc = 'REPL: start/toggle/hide (from code buffer)' })
      vim.keymap.set('n', '<leader>rf', function()
        iron.focus_on(vim.bo.filetype)
      end, { desc = 'REPL: focus on repl (from code buffer)' })
      vim.keymap.set('n', '<leader>rC', function()
        iron.close_repl(vim.bo.filetype)
      end, { desc = 'REPL: close (from code buffer)' })
      -- vim.keymap.set('n', 'gR', iron.send_motion, { desc = 'Run motion' }) -- TODO: not working
      vim.keymap.set('n', '<leader>rl', iron.send_line, { desc = 'Run line' })
      vim.keymap.set('n', '<leader>rp', iron.send_paragraph, { desc = 'Run paragraph' })
      vim.keymap.set('n', '<leader>rc', iron.send_until_cursor, { desc = 'Run until cursor' })
      vim.keymap.set('n', '<leader>rb', iron.send_file, { desc = 'Run buffer' })

      ---- from inside REPL only
      vim.keymap.set('n', '<leader>rR', iron.repl_restart, { desc = 'REPL: restart (from inside REPL)' })

      -- visual mode
      vim.keymap.set('v', '<leader>r', iron.visual_send, { desc = 'Run selection' })
    end,
  },

  -- Jupynium.
  -- Runs file as jupyter notebook in browser.
  -- (+) Works: can run cells, can see output (also graphs) in browser. Adding code in source file in nvim gets (one-way)
  --     synchronised to notebook in browser.
  -- (-) Cannot "play around" by running code directly in notebook. Can insert cell, but then the correspondence
  --     between cells in nvim and cells in notebook gets messed up. Only possibility is to go to bottom of notebook
  --     and add code there.
  -- (-) Uncomfortable workflow: notebook in different window and using different keyboard shortcuts for navigation than nvim.
  {
    'kiyoon/jupynium.nvim',
    build = 'pip3 install --user .',
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
    dependencies = {
      'rcarriga/nvim-notify', -- optional
      'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect
      'folke/which-key.nvim',
    },
    config = function()
      local jup = require 'jupynium'
      jup.setup {
        use_default_keybindings = false,
        -- auto_attach_to_server = true,
      }
      require('which-key').register { ['<leader>j'] = { name = ' 󰜎 Run code (jupyter)', _ = 'which_key_ignore' } }
      vim.keymap.set({ 'n', 'x' }, '<leader>jj', '<cmd>JupyniumStartAndAttachToServer<CR><Cmd>JupyniumStartSync<Cr>', { desc = 'falseJupynium start' })
      vim.keymap.set({ 'n', 'x' }, '<leader>jx', '<cmd>JupyniumExecuteSelectedCells<CR>', { desc = 'Jupynium execute selected cells' })
      vim.keymap.set({ 'n', 'x' }, '<leader>jc', '<cmd>JupyniumClearSelectedCellsOutputs<CR>', { desc = 'Jupynium clear selected cells' })
      vim.keymap.set({ 'n' }, '<leader>jT', '<cmd>JupyniumKernelHover<cr>', { desc = 'Jupynium hover (inspect a variable)' })
      vim.keymap.set({ 'n', 'x' }, '<leader>jS', '<cmd>JupyniumScrollToCell<cr>', { desc = 'Jupynium scroll to cell' })
      vim.keymap.set({ 'n', 'x' }, '<leader>jo', '<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>', { desc = 'Jupynium toggle selected cell output scroll' })
      vim.keymap.set('n', '<PageUp>', '<cmd>JupyniumScrollUp<cr>', { desc = 'Jupynium scroll up' })
      vim.keymap.set('n', '<PageDown>', '<cmd>JupyniumScrollDown<cr>', { desc = 'Jupynium scroll down' })
    end,
  },

  -- jukit
  -- Runs file in ipython split with additional formatting
  -- (+) Should (?) be able to show images as well
  -- (-) Does not repect `# %%` cell markers (uses its own)
  {
    'luk400/vim-jukit',
    enabled = true,
    dependencies = { 'folke/which-key.nvim' },
    init = function()
      vim.g.jukit_cell_marker = '# %%'
      vim.g.jukit_comment_mark = '%%'
      vim.g.jukit_mappings = 0
      vim.g.jukit_inline_plotting = 1
    end,
    config = function()
      require('which-key').register { ['<leader>J'] = { name = ' 󰜎 Run code (jukit)', _ = 'which_key_ignore' } }
      vim.g.jukit_shell_cmd = '/opt/homebrew/Caskroom/miniconda/base/bin/ipython'
      vim.keymap.set('n', '<leader>Js', '<cmd>call jukit#cells#split()<cr>', { desc = 'Split cell' })
      vim.keymap.set('n', '<leader>Jn', '<cmd>call jukit#cells#jump_to_next_cell()<cr>', { desc = 'Next cell' })
      vim.keymap.set('n', '<leader>Jt', '<cmd>call jukit#cells#jump_to_previous_cell()<cr>', { desc = 'Prev cell' })
      vim.keymap.set('n', '<leader>Ja', '<cmd>call jukit#splits#output()<cr>', { desc = 'create split for output' })
      vim.keymap.set('v', '<leader>J', ':<C-U>call jukit#send#selection()<cr>', { desc = 'Jukit run selection' })
    end,
  },
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
}
