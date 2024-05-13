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
      local function flash(prompt_bufnr) -- function to add labels to jump to
        require('flash').jump {
          pattern = '^',
          label = { after = { 0, 0 } },
          search = {
            mode = 'search',
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
              end,
            },
          },
          action = function(match)
            local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        }
      end
      require('telescope').setup {
        defaults = {
          mappings = {
            n = {
              -- disable some keymaps
              -- ["j"] = actions.noop, -- already used for something else, see below
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

              ['j'] = flash,

              ['<C-h>'] = actions.cycle_history_prev,
              ['<C-s>'] = actions.cycle_history_next,
            },
            i = {
              -- set new keymaps
              ['<C-n>'] = actions.move_selection_next,
              ['<C-t>'] = actions.move_selection_previous,

              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,

              ['<C-j>'] = flash,

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
      end, { desc = 'Find in current buffer' })

      -- Section 1: Search for a buffer / in all buffers
      vim.keymap.set('n', '<leader>bf', builtin.buffers, { desc = 'Find buffer by filename' })
      vim.keymap.set('n', '<leader>bg', function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live grep in buffers' }
      end, { desc = 'Grep in buffers' })

      -- Section 2: Search for a file / in all files
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', function()
        builtin.live_grep { prompt_title = 'Live grep in files' }
      end, { desc = 'Find files (grep)' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find old (recent) file' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find current word in files' })

      -- Section 3: Lsp / code
      vim.keymap.set('n', '<leader>lx', builtin.diagnostics, { desc = 'Workspace diagonstics' })
      vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Goto symbol in current buffer' })
      vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, { desc = 'Goto symbol in all buffers' })

      -- Section 4: Git
      vim.keymap.set('n', '<leader>gb', function()
        builtin.git_branches { prompt_title = 'Git branches. <cr> check-out; <C-d> delete; <C-y> merge; <C-a> create new' }
      end, { desc = 'List branchs' })
      vim.keymap.set('n', '<leader>gc', function()
        builtin.git_commits { prompt_title = 'Git commits. <cr> checkout; open diff in <c-v> vertical <c-x> horizontal' }
      end, { desc = 'List commits' })
      vim.keymap.set('n', '<leader>gs', function()
        builtin.git_status { prompt_title = 'Git status. <cr> open file; <tab> stage/unstage file' }
      end, { desc = 'Git status' })

      -- Section 5: Search in misc.
      vim.keymap.set('n', "<leader>s'", builtin.marks, { desc = 'Marks' })
      vim.keymap.set('n', '<leader>s.', builtin.resume, { desc = 'Repeat previous search' })
      vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = 'Registers' })
      vim.keymap.set('n', '<leader>s:', builtin.command_history, { desc = 'Command history' })
      vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = 'Select telescope builtin' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>sd', function()
        builtin.find_files { cwd = '~/.dotfiles/' }
      end, { desc = 'Personal dotfiles' })
      vim.keymap.set('n', '<leader>sD', function()
        builtin.live_grep { prompt_title = 'Live grep in dotfiles', cwd = '~/.dotfiles/' }
      end, { desc = 'Personal dotfiles (grep)' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>sm', function()
        require('telescope').extensions.notify.notify()
      end, { desc = 'Messages (notifications)' })
      vim.keymap.set('n', '<leader>sM', builtin.man_pages, { desc = 'Manpages' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Neovim config files' })
      vim.keymap.set('n', '<leader>sN', function()
        builtin.live_grep { prompt_title = 'Live grep in neovim config files', cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Neovim config files (grep)' })
      vim.keymap.set('n', '<leader>so', builtin.vim_options, { desc = 'Vim options' })

      -- Section 6: No search; change UI etc
      vim.keymap.set('n', '<leader>uo', function()
        builtin.colorscheme { enable_preview = true }
      end, { desc = 'Select colorscheme' })

      -- It's also possible to pass additional configuration options.
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
