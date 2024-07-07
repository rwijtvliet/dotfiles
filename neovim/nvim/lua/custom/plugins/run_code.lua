return {
  -- Molten.
  -- Run code in ipython, but not in separate window. Instead, see output as floating window on top of source code.
  -- (-) Cannot access the ipython instance to "play around" with code.
  -- (-) Cannot run code cells defined by `# %%` markers (has own concept of "cells").
  {
    'benlubas/molten-nvim',
    enabled = false,
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    dependencies = {
      -- For images.
      -- In molten_image_provider, below, use ...
      { -- ... "wezterm", or ...
        'willothy/wezterm.nvim', --puts pane on the right, which is not a neovim buffer. Difficult when navigating to/from code.
        config = true,
        enabled = false,
      },
      {
        -- ... "image.nvim"
        '3rd/image.nvim',
        enabled = true,
        dependencies = {
          'vhyrro/luarocks.nvim',
          priority = 1001, -- this plugin needs to run before anything else
          opts = { rocks = { 'magick' } },
        },
        opts = {
          backend = 'kitty',
          integrations = {}, -- do whatever you want with image.nvim's integrations
          max_width = 100, -- tweak to preference
          max_height = 12, -- ^
          max_height_window_percentage = math.huge, -- this is necessary for a good experience
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true,
          window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
        },
      },
      -- Other dependencies.
    },
    config = function()
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_auto_open_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_output_show_more = true
      -- vim.g.molten_split_direction = 'right'
      -- vim.g.molten_split_size = 30

      local function create_cell(start_line, end_line, kernel)
        end_line = end_line - 1
        if end_line - start_line <= 0 then
          return
        end
        vim.fn.MoltenDefineCell(start_line, end_line, kernel)
      end
      local function find_and_process_sections()
        local kernel = vim.fn.MoltenRunningKernels(true)[1]
        if not kernel then
          vim.notify('No Molten kernel is running yet.', vim.log.levels.WARN)
          return
        end

        local buffer = vim.api.nvim_buf_get_lines(0, 0, -1, false) -- Read current buffer
        local section_lines = {} -- Table to store cells
        local pattern = '^%s*#%s*%%%s*' -- zero or more whitespace, one #, zero or more whitespace, two %, zero or more characters
        -- Find cells.
        for line_number, line_content in ipairs(buffer) do
          if line_content:match(pattern) then
            table.insert(section_lines, line_number)
          end
        end
        -- Process each cell.
        for i = 1, #section_lines do
          local start_line = section_lines[i]
          local end_line = section_lines[i + 1] or #buffer -- Use end of buffer for the last section
          create_cell(start_line, end_line, kernel)
        end
      end
      vim.keymap.set('n', '<leader>Rc', find_and_process_sections, { desc = 'Create cells' })
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
              command = { 'ipython', '-i', '--no-autoindent', '--nosep' },
            },
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
    enabled = false,
    build = 'pip3 install --user .',
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
    dependencies = {
      'rcarriga/nvim-notify', -- optional
      'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect
    },
    config = function()
      local jup = require 'jupynium'
      jup.setup {
        use_default_keybindings = false,
        -- auto_attach_to_server = true,
      }
      vim.keymap.set({ 'n', 'x' }, '<leader>kj', '<cmd>JupyniumStartAndAttachToServer<CR><Cmd>JupyniumStartSync<Cr>', { desc = 'falseJupynium start' })
      vim.keymap.set({ 'n', 'x' }, '<leader>kx', '<cmd>JupyniumExecuteSelectedCells<CR>', { desc = 'Jupynium execute selected cells' })
      vim.keymap.set({ 'n', 'x' }, '<leader>kc', '<cmd>JupyniumClearSelectedCellsOutputs<CR>', { desc = 'Jupynium clear selected cells' })
      vim.keymap.set({ 'n' }, '<leader>kT', '<cmd>JupyniumKernelHover<cr>', { desc = 'Jupynium hover (inspect a variable)' })
      vim.keymap.set({ 'n', 'x' }, '<leader>kS', '<cmd>JupyniumScrollToCell<cr>', { desc = 'Jupynium scroll to cell' })
      vim.keymap.set({ 'n', 'x' }, '<leader>ko', '<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>', { desc = 'Jupynium toggle selected cell output scroll' })
      vim.keymap.set('n', '<PageUp>', '<cmd>JupyniumScrollUp<cr>', { desc = 'Jupynium scroll up' })
      vim.keymap.set('n', '<PageDown>', '<cmd>JupyniumScrollDown<cr>', { desc = 'Jupynium scroll down' })
    end,
  },

  -- jukit
  -- Runs file in ipython split with additional formatting
  -- (+) Should (?) be able to show images as well, but does not work
  ------ * on wezterm, no images are shown. Not when specifying vim.g.jukit_image_viewer =  'ueberzug', and also not when specifying matplotlib.use('module://matplotlib-backend-kitty') or '...-sixel'
  ------ * on kitty, there is an error message with "tty"
  -- (-) Does not repect `# %%` cell markers (uses its own)
  {
    'luk400/vim-jukit',
    enabled = true,
    init = function()
      -- vim.g.jukit_mpl_style = 'ggplot' --vim.fn.expand '~/.config/nvim/helpers/matplotlib-backend-kitty/backend.mplstyle'
      vim.g.jukit_cell_marker = '# %%'
      vim.g.jukit_comment_mark = '%%'
      vim.g.jukit_terminal = ''
      vim.g.jukit_mappings = 0
      vim.g.jukit_inline_plotting = 1
      vim.g.jukit_image_viewer = 'ueberzug'
    end,
    config = function()
      vim.g.jukit_shell_cmd = '/opt/homebrew/Caskroom/miniconda/base/bin/ipython'
      vim.keymap.set('n', '<leader>Ja', '<cmd>call jukit#splits#output()<cr>', { desc = 'create split for output' })
      vim.keymap.set('n', '<leader>Jq', '<cmd>call jukit#splits#close_output_split()<cr>', { desc = 'close split for output' })
      vim.keymap.set('n', '<leader>JA', '<cmd>call jukit#splits#output_and_history()<cr>', { desc = 'create split for output+history' })
      vim.keymap.set('n', '<leader>JQ', '<cmd>call jukit#splits#close_output_and_history(0)<cr>', { desc = 'close split for output+history' })
      vim.keymap.set('n', '<leader>Js', '<cmd>call jukit#cells#split()<cr>', { desc = 'Split cell' })
      vim.keymap.set('n', '<leader>Jn', '<cmd>call jukit#cells#jump_to_next_cell()<cr>', { desc = 'Next cell' })
      vim.keymap.set('n', '<leader>Jt', '<cmd>call jukit#cells#jump_to_previous_cell()<cr>', { desc = 'Prev cell' })
      vim.keymap.set('n', '<leader>Jl', '<cmd>call jukit#send#line()<cr>', { desc = 'Send line' })
      vim.keymap.set('v', '<leader>J', ':<C-U>call jukit#send#selection()<cr>', { desc = 'Jukit run selection' })
    end,
  },

  -- jupyter-vim
  -- (-) runs in seperate window
  -- (+) can show plots, both in jupyter console (=terminal) and jupyter qtconsole (=gui)
  {
    'jupyter-vim/jupyter-vim',
    name = 'jupytervim',
    dependencies = { 'folke/which-key.nvim', 'GCBallesteros/NotebookNavigator.nvim' },
    config = function()
      local function open_wezterm_with_commands_async(commands)
        local command = "wezterm start -- bash -c ' " .. commands .. " '"
        local handle
        handle = vim.loop.spawn('sh', { args = { '-c', command }, detached = true }, function(code, signal)
          if handle then
            handle:close()
            if code ~= 0 then
              vim.notify('WezTerm command failed with code ' .. code .. ' and signal ' .. signal, vim.log.levels.ERROR)
            else
              vim.notify('WezTerm command executed successfully', vim.log.levels.INFO)
            end
          end
        end)
        vim.loop.unref(handle)
      end
      local function launch_jupyter_in_wezterm_and_connect()
        local change_cwd_cmd = 'cd ' .. vim.fn.getcwd()
        local install_ipython_kernel_cmd = 'poetry run python -m ipykernel install --user --name target_env --display-name "Python (target_env)"'
        local jupyter_cmd = vim.g.python3_host_prog .. ' -m jupyter console --kernel target_env'
        local commands = change_cwd_cmd .. ' && ' .. install_ipython_kernel_cmd .. ' && ' .. jupyter_cmd
        open_wezterm_with_commands_async(commands)
        vim.defer_fn(function()
          vim.cmd 'JupyterConnect'
        end, 3000)
        vim.defer_fn(function()
          vim.cmd [[ JupyterSendCode ( "import matplotlib; matplotlib.use( 'module://matplotlib-backend-sixel')" ) ]]
        end, 4000)
      end
      local function launch_jupyter_qtconsole_and_connect()
        local change_cwd_cmd = 'cd ' .. vim.fn.getcwd()
        local install_ipython_kernel_cmd = 'poetry run python -m ipykernel install --user --name target_env --display-name "Python (target_env)"'
        local jupyter_cmd = vim.g.python3_host_prog .. ' -m jupyter qtconsole --kernel target_env'
        local commands = change_cwd_cmd .. ' ; ' .. install_ipython_kernel_cmd .. ' ; ' .. jupyter_cmd
        os.execute(commands .. ' & ')
        vim.defer_fn(function()
          vim.cmd 'JupyterConnect'
        end, 3000)
      end
      local function get_selected_lines()
        vim.cmd 'normal! gv' -- force 'refresh' of selection. Otherwise prev selection might be used.
        local buf = vim.api.nvim_get_current_buf()
        local start_pos = vim.api.nvim_buf_get_mark(buf, '<')
        local end_pos = vim.api.nvim_buf_get_mark(buf, '>')
        local lines = vim.api.nvim_buf_get_lines(buf, start_pos[1] - 1, end_pos[1], false)
        return table.concat(lines, '\n')
      end
      vim.g.jupyter_mapkeys = 0 -- don't use defaults

      require('which-key').register { ['<leader>j'] = { name = ' 󰜎 Run code (jupyter-nvim)', _ = 'which_key_ignore' } }
      require('which-key').register { ['<leader>ja'] = { name = ' 󱘖 Prepare console', _ = 'which_key_ignore' } }
      vim.keymap.set('n', '<leader>jac', '<Cmd>JupyterConnect<Cr>', { desc = 'Connect to existing' })
      vim.keymap.set('n', '<leader>jad', '<Cmd>JupyterDisconnect<Cr>', { desc = 'Disconnect' })
      vim.keymap.set('n', '<leader>jaa', function()
        if vim.bo.filetype ~= 'python' then
          vim.notify('Only possible in python buffer.', vim.log.levels.ERROR)
          return
        end
        launch_jupyter_in_wezterm_and_connect()
      end, { desc = 'Start+connect jupyter console' })
      vim.keymap.set('n', '<leader>jaA', function()
        if vim.bo.filetype ~= 'python' then
          vim.notify('Only possible in python buffer.', vim.log.levels.ERROR)
          return
        end
        launch_jupyter_qtconsole_and_connect()
      end, { desc = 'Start+connect jupyter qtconsole' })

      vim.keymap.set('n', '<leader>jf', '<Cmd>JupyterRunFile<Cr>', { desc = 'Run file' })
      vim.keymap.set('n', '<leader>jl', '<Cmd>JupyterSendCount<Cr>', { desc = 'Run line' })
      vim.keymap.set('n', '<leader>jx', '<Cmd>JupyterSendCell<Cr>', { desc = 'Jupyter run cell' })
      vim.keymap.set('n', '<leader>jy', function()
        vim.cmd 'JupyterSendCell'
        require('notebook-navigator').move_cell 'd'
      end, { desc = 'Jupyter run cell+next' })
      -- visual
      -- vim.keymap.set('v', '<leader>j', ':<C-U>JupyterRunVisual<Cr>', { desc = 'Jupyter run selection' })
      vim.keymap.set('v', '<leader>j', function()
        local txt = get_selected_lines() -- :gsub('"', '\\"'):gsub('\n', '\\n')
        vim.notify(txt)
        -- vim.cmd('JupyterSendCode "' .. get_selected_lines():gsub('"', '\\"'):gsub('\n', '\\n') .. '"')
      end, { desc = 'test' })
      if vim.g.vim_virtualenv_path then
      end
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
  --
  -- Test
  { 'bfredl/nvim-ipy' },
}
