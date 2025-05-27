-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Don't use netrw to browse files
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Clipboard interaction with windows if on WSL.
local in_wsl = os.getenv 'WSL_DISTRO_NAME' ~= nil

if in_wsl then
  vim.g.clipboard = {
    name = 'wsl clipboard',
    copy = { ['+'] = { 'clip.exe' }, ['*'] = { 'clip.exe' } },
    paste = { ['+'] = { 'nvim_paste' }, ['*'] = { 'nvim_paste' } },
    cache_enabled = true,
  }
end

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
