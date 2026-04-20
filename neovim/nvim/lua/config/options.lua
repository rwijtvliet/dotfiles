-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("config.clipboard")

-----------------------------
-- Ensure python is available
-----------------------------

local function get_nvim_venv_bin()
  local function assert_exists(path)
    if vim.loop.fs_stat(path) == nil then
      error(
        "Error when loading the configuration. We are trying to find the path of the python environment for neovim, but cannot find the following path: "
          .. path
          .. ". Check if it exists!"
      )
    end
  end

  local path = os.getenv("HOME") .. "/.dotfiles/neovim/.venv/"
  assert_exists(path)

  local winpath = path .. "/Scripts/python.exe"
  if pcall(assert_exists, winpath) then
    return winpath
  end
  local unixpath = path .. "/bin/python"
  if pcall(assert_exists, unixpath) then
    return unixpath
  end
  error("Could not find python binary in " .. path .. ".")
end

vim.g.python3_host_prog = get_nvim_venv_bin()
