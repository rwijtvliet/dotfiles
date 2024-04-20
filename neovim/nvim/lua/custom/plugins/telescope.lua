-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require 'telescope.actions'
      require('telescope').setup {
        defaults = {
          mappings = {
            n = {
              -- disable some keymaps
              -- ["j"] = actions.noop, -- already used for something else, see below
              ['j'] = false,
              ['k'] = false,
              ['s'] = false,
              ['L'] = false,
              ['<Down>'] = false,
              ['<Up>'] = false,

              -- set new keymaps
              ['n'] = actions.move_selection_next,
              ['t'] = actions.move_selection_previous,
              ['<C-n>'] = actions.move_selection_next,
              ['<C-t>'] = actions.move_selection_previous,
              ['S'] = actions.move_to_bottom,

              ['u'] = actions.preview_scrolling_up,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['d'] = actions.preview_scrolling_down,
              ['<C-d>'] = actions.preview_scrolling_down,

              --['j'] = flash,

              ['<C-h>'] = actions.cycle_history_prev,
              ['<C-s>'] = actions.cycle_history_next,
            },
            i = {
              -- set new keymaps
              ['<C-n>'] = actions.move_selection_next,
              ['<C-t>'] = actions.move_selection_previous,

              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,

              --['<C-j>'] = flash,

              ['<C-h>'] = actions.cycle_history_prev,
              ['<C-s>'] = actions.cycle_history_next,
            },
          },
          layout_config = { prompt_position = 'top' },
          sorting_strategy = 'ascending',
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'

      -- Section 0: Search in current buffer
      vim.keymap.set('n', '<leader>/', function() -- Slightly advanced example of overriding default behavior and theme
        builtin.current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown { winblend = 10, previewer = false, prompt_title = 'Search in current buffer' }
        )
      end, { desc = '[/] Find in current buffer' })

      -- Section 1: Search for a buffer / in all buffers
      vim.keymap.set('n', '<leader>bf', builtin.buffers, { desc = 'Find buffer by [f]ilename' })
      vim.keymap.set('n', '<leader>bg', function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live grep in buffers' }
      end, { desc = '[G]rep in buffers' })

      -- Section 2: Search for a file / in all files
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find file by [f]ilename' })
      vim.keymap.set('n', '<leader>fg', function()
        builtin.live_grep { prompt_title = 'Live grep in files' }
      end, { desc = '[G]rep in files' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find [o]ld (recent) file' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find current [w]ord in files' })

      -- Section 3: Lsp / code
      vim.keymap.set('n', '<leader>lx', builtin.diagnostics, { desc = '[x] Workspace diagonstics' })
      vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Goto [s]ymbol in current buffer' })
      vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, { desc = 'Goto [s]ymbol in all buffers' })

      -- Section 3: Git
      vim.keymap.set('n', '<leader>gb', function()
        builtin.git_branches { prompt_title = 'Git branches. <cr> check-out; <C-d> delete; <C-y> merge; <C-a> create new' }
      end, { desc = 'List [b]ranchs' })
      vim.keymap.set('n', '<leader>gc', function()
        builtin.git_commits { prompt_title = 'Git commits. <cr> checkout; open diff in <c-v> vertical <c-x> horizontal' }
      end, { desc = 'List [c]ommits' })
      vim.keymap.set('n', '<leader>gs', function()
        builtin.git_status { prompt_title = 'Git status. <cr> open file; <tab> stage/unstage file' }
      end, { desc = 'Git [s]tatus' })

      -- Section 4: Search in configuration
      vim.keymap.set('n', '<leader>Cd', function()
        builtin.find_files { cwd = '~/.dotfiles/' }
      end, { desc = 'Find personal [d]otfiles' })
      vim.keymap.set('n', '<leader>CD', function()
        builtin.live_grep { cwd = '~/.dotfiles/' }
      end, { desc = 'Grep personal [d]otfiles' })
      vim.keymap.set('n', '<leader>Cn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Find [n]eovim config files' })
      vim.keymap.set('n', '<leader>CN', function()
        builtin.live_grep { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Grep [n]eovim config files' })
      vim.keymap.set('n', '<leader>Co', builtin.vim_options, { desc = 'Search vim [o]ptions' })

      -- Section 5: Search in misc.
      vim.keymap.set('n', "<leader>s'", builtin.marks, { desc = "['] Search marks" })
      vim.keymap.set('n', '<leader>s.', builtin.resume, { desc = '[.] Repeat previous search' })
      vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = '["] Search registers' })
      vim.keymap.set('n', '<leader>s:', builtin.command_history, { desc = '[:] Search command history' })
      vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = 'Select telescope [b]uiltin' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Search [c]ommands' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search [h]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search [k]eymaps' })
      vim.keymap.set('n', '<leader>sm', builtin.man_pages, { desc = 'Search [m]anpages' })
      vim.keymap.set('n', '<leader>sn', function()
        require('telescope').extensions.notify.notify()
      end, { desc = 'Find notifications' })

      -- Section 6: No search; change UI etc
      vim.keymap.set('n', '<leader>uo', function()
        builtin.colorscheme { enable_preview = true }
      end, { desc = 'Select c[o]lorscheme' })

      -- It's also possible to pass additional configuration options.
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
