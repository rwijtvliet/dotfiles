-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- New notification handler
-- vim.notify = require 'notify'

vim.opt.termguicolors = true

-- Ensure python is available
local function get_base_python()
  local virtual_env = os.getenv 'VIRTUAL_ENV'
  if not virtual_env then
    print 'No virtual environment is currently activated.'
  else
    -- Get the parent directory of the virtual environment
    local base_dir = virtual_env:match '(.+)/.+$'
    local base_python = base_dir .. '/bin/python'
    print(base_python)
  end
end

local function get_base_python()
  local venv = os.getenv 'VIRTUAL_ENV'
  local path = os.getenv 'PATH'
  local j = 0
  if not path then
    return
  end
  while true do
    -- find directory
    local i = j + 1
    _, j = string.find(path, ':', j + 1)
    if j == nil then
      break
    end
    dir = string.sub(path, i, j - 1)

    -- only consider if not part of venv
    if not (venv and string.find(dir, venv)) then
      local candidate = dir .. '/python'
      if io.open(candidate) then
        return candidate
      end
    end
  end
end
vim.g.python3_host_prog = get_base_python()
-- vim: ts=2 sts=2 sw=2 et
