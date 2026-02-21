----------
-- Keymaps
----------

-- There are several locations where keymaps are set.
-- 1) The keymaps that do not require a plugin are changed in this file. They may be standard (neo)vim keymaps or layzvim keymaps.
-- 2) The lazyvim keymaps for plugins that we want to change/remove are in plugins/keymaps_lazyvim.lua
-- 3) The lazyvim keymaps for the lsp that we want to change/remove are in plugins/keymaps_lsp.lua
-- 4) Finally, my own custom keymaps are in plugings/keymaps_own.lua

-- When to use vim.keymap.set, and when to use wk.add?
-- Important: vim.keymap.set cannot be used to set icons. wk.add cannot be used to map expressions.
-- --> current convention: ALways use vim.keymap.set. If we want an icon, use wk.add to ONLY add the icon!
--
-- TODO: wk.add({..., icon="X"}) *sometimes* removes description if this is not set by me.
-- e.g. when doing wk.add({"f", icon="X"}), the icon is set, but the description is lost.
--
-- -----------------------------------------------------------------------------
-- Remapping for Ruud
-- -----------------------------------------------------------------------------
-- Default key for action;   Wanted mapping         Default action for key;
-- key is now freed up                              new key needed for it
-- (key reused?              ACTION         KEY              (new key assigned?
-- ! = key still free)                                     ! = action unmapped)
-- -----------------------   ------------------    ----------------------------
-- n/a                 (h)   LEFT            h      (LEFT)                  n/a
-- yes                  k    UP              t      TILL                    yes
-- yes                  j    DOWN            n      NEXTRESULT              yes
-- yes                  l    RIGHT           s      SUBSTCHAR               yes
-- n/a                 (H)   SCREENTOP       H      (SCREENTOP)             n/a
-- yes                  L    SCREENBOTTOM    S      SUBSTLINE                !
-- yes                  n    NEXTRESULT      l      RIGHT                   yes
--  !                   N    PREVRESULT      L      SCREENBOTTOM            yes
-- yes                  t    TILL            k      UP                      yes
-- yes                  T    TILLBACK        K      HELP                    yes
-- yes                  K    HELP            T      TILLBACK                yes
-- yes                  s    SUBSTCHAR       j      DOWN                    yes
-- ----------------------------------------------------------------------------
-- We have not yet set a key for: SUBSTLINE. This is not a problem, because it's
-- the same as CHANGELINE (key: cc).

local wk = require("which-key")
local movecursor = "blue"
local changelayout = "green"

------------------------------------------------
-- Remove lazyvim commands (do before reused) --
------------------------------------------------

-- save file
vim.keymap.del("", "<C-s>")
-- move line
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

------------------------------------------
-- Direct, single keys (in normal mode) --
------------------------------------------

-- Navigation with hnts
vim.keymap.set("", "h", "h", { desc = "Move left", silent = true })
vim.keymap.set("", "t", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up", expr = true, silent = true })
vim.keymap.set("", "n", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down", expr = true, silent = true })
vim.keymap.set("", "s", "l", { desc = "Move right", silent = true })
wk.add({
  { "h", icon = { icon = "󰁍", color = movecursor } },
  { "t", icon = { icon = "󰁝", color = movecursor } },
  { "n", icon = { icon = "󰁅", color = movecursor } },
  { "s", icon = { icon = "󰁔", color = movecursor } },
})

-- Move to beginning/end of line/screen
vim.keymap.set("", "H", "H", { desc = "Move to top of screen" }) -- re-set; was overwritten by lazyvim
vim.keymap.set("", "S", "L", { desc = "Move to bottom of screen" })
vim.keymap.set("", "M", "M", { desc = "Move to middle of screen" })
vim.keymap.set("", "B", "^", { desc = "Move to beginning of line" })
vim.keymap.set("", "E", "$", { desc = "Move to end of line" })
wk.add({
  { "H", icon = { icon = "󰘣", color = movecursor } },
  { "S", icon = { icon = "󰘡", color = movecursor } },
  { "M", icon = { icon = "󰘢", color = movecursor } },
  { "B", icon = { icon = "󰘟", color = movecursor } },
  { "E", icon = { icon = "󰘠", color = movecursor } },
})

-- Search results
vim.keymap.set("", "l", "n", { desc = "Next search result" })
vim.keymap.set("", "L", "N", { desc = "Prev search result" })

-- Help
vim.keymap.set("n", "T", "K", { desc = "Help" })

-- Substitute (substitute line not remapped; not necessary because is same as cc)
vim.keymap.set("n", "j", "s", { desc = "Substitute character" })

wk.add({
  { "f", desc = "Move to next char", icon = "" },
  { "F", desc = "Move to prev char", icon = "" },
  { "k", desc = "Till", icon = "" }, -- set in flash.nvim
  { "K", desc = "Till (backwards)", icon = "" }, --set in flash.nvim
})

-- Housekeeping
---- add icon for unchanged mappings
wk.add({
  { "^", desc = "Move to beginning of line", icon = { icon = "󰘟", color = movecursor } },
  { "$", desc = "Move to end of line", icon = { icon = "󰘠", color = movecursor } },
})
---- remove unused mappings
pcall(vim.keymap.del, "", "N")

------------------------------
-- Move, copy, insert lines --
------------------------------

-- Move lines
vim.keymap.set("n", "<A-n>", "<cmd>m .+1<cr>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<A-t>", "<cmd>m .-2<cr>==", { desc = "Move line up", silent = true })
vim.keymap.set("i", "<A-t>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up", silent = true })
vim.keymap.set("i", "<A-n>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down", silent = true })
vim.keymap.set("v", "<A-n>", ":m '>+1<cr>gv=gv", { desc = "Move lines down", silent = true })
vim.keymap.set("v", "<A-t>", ":m '<-2<cr>gv=gv", { desc = "Move lines up", silent = true })

-- Move and copy lines
vim.keymap.set("n", "<A-N>", "mzyyP`z", { desc = "Copy line down" })
vim.keymap.set("n", "<A-T>", "mzyyp`z", { desc = "Copy line up" })
vim.keymap.set("i", "<A-N>", "<esc>mzyyP`zi", { desc = "Copy line down" })
vim.keymap.set("i", "<A-T>", "<esc>mzyyp`zi", { desc = "Copy line up" })

-- Add empty line
wk.add({ "<leader>o", "o<Up><Esc>", desc = "Add empty line after", icon = "_" })
wk.add({ "<leader>O", "O<Down><Esc>", desc = "Add empty line before", icon = "_" })

-------------------------
-- Windows and buffers --
-------------------------

-- Move between windows
---- using vim prefix control-w
vim.keymap.set("", "<C-w>h", "<C-w>h", { desc = "Go to window on left" })
vim.keymap.set("", "<C-w>t", "<C-w>k", { desc = "Go to window above" })
vim.keymap.set("", "<C-w>n", "<C-w>j", { desc = "Go to window below" })
vim.keymap.set("", "<C-w>s", "<C-w>l", { desc = "Go to window on right" })
---- direct shortcut
vim.keymap.set("", "<C-h>", "<C-w>h", { desc = "Go to window on left" })
vim.keymap.set("", "<C-t>", "<C-w>k", { desc = "Go to window above" })
vim.keymap.set("", "<C-n>", "<C-w>j", { desc = "Go to window below" })
vim.keymap.set("", "<C-s>", "<cmd>wincmd l<cr>", { desc = "Go to window on right" })
---- icons
wk.add({
  { "<C-w>h", icon = { icon = "", color = movecursor } },
  { "<C-w>t", icon = { icon = "", color = movecursor } },
  { "<C-w>n", icon = { icon = "", color = movecursor } },
  { "<C-w>s", icon = { icon = "", color = movecursor } },
})
---- remove unused mappings
vim.keymap.set("", "<C-w>k", "<nop>")
vim.keymap.set("", "<C-w>j", "<nop>")
vim.keymap.set("", "<C-w>l", "<nop>")
vim.keymap.set("", "<C-k>", "<nop>")
vim.keymap.set("", "<C-j>", "<nop>")
vim.keymap.set("", "<C-l>", "<nop>")
wk.add({
  { "<C-w>k", hidden = true },
  { "<C-w>j", hidden = true },
  { "<C-w>l", hidden = true },
  { "<C-k>", hidden = true },
  { "<C-j>", hidden = true },
  { "<C-l>", hidden = true },
})

-- Move windows
---- using vim prefix control-w
vim.keymap.set("n", "<C-w>H", "<C-w>H", { desc = "Move window to far left" })
vim.keymap.set("n", "<C-w>T", "<C-w>K", { desc = "Move window to far top" })
vim.keymap.set("n", "<C-w>N", "<C-w>J", { desc = "Move window to far bottom" })
vim.keymap.set("n", "<C-w>S", "<C-w>L", { desc = "Move window to far right" })
---- direct shortcut
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to far left" })
vim.keymap.set("n", "<C-S-t>", "<C-w>K", { desc = "Move window to far top" })
vim.keymap.set("n", "<C-S-n>", "<C-w>J", { desc = "Move window to far bottom" })
vim.keymap.set("n", "<C-S-s>", "<C-w>L", { desc = "Move window to far right" })
---- icons
wk.add({
  { "<C-w>H", icon = { icon = "", color = changelayout } },
  { "<C-w>T", icon = { icon = "", color = changelayout } },
  { "<C-w>N", icon = { icon = "", color = changelayout } },
  { "<C-w>S", icon = { icon = "", color = changelayout } },
})
---- add icon for unchanged mappings
wk.add({
  { "<leader>wd", desc = "Delete window", icon = { icon = "", color = "red" } },
  { "<leader>wq", desc = "Quit window", icon = { icon = "", color = "red" } },
})
---- remove unused mappings
vim.keymap.set("", "<C-w>K", "<nop>")
vim.keymap.set("", "<C-w>J", "<nop>")
vim.keymap.set("", "<C-w>L", "<nop>")
wk.add({ { "<C-w>K", hidden = true }, { "<C-w>J", hidden = true }, { "<C-w>L", hidden = true } })

-- Create windows
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal split" })
wk.add({ { "|", icon = "" }, { "\\", icon = "" } })

-- Move to other buffer
---- direct shortcut
vim.keymap.set("n", "<A-h>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<A-s>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

---------------
-- Utilities --
---------------

-- File info
wk.add({
  "<leader>fp",
  function()
    local path = vim.fn.expand("%:i")
    vim.notify(path)
  end,
  desc = "Current file path",
  icon = "",
})
wk.add({
  "<leader>fP",
  function()
    local path = vim.fn.expand("%:I")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end,
  desc = "Current file path to clipboard",
  icon = "",
})

------------------------
-- prev ([) and next (])
------------------------

-- Alternatives for [ and ] (because difficult on custom keyboards).
wk.add({ { "gp", proxy = "[", group = "Go prev" }, { "gn", proxy = "]", group = "Go next" } })
-- IMPORTED

-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

------- Go to dashboard (home)
---vim.keymap.set("n", "<leader>h", "<cmd>Dashboard<cr>", { desc = "Home (dashboard)" })

-- vim.keymap.set("n", "<leader>Cd", function()
--   require("telescope.builtin").find_files({ cwd = "~/.dotfiles/" })
-- end, { desc = "Find personal [d]otfiles" })
-- vim.keymap.set("n", "<leader>CD", function()
--   require("telescope.builtin").live_grep({ cwd = "~/.dotfiles/" })
-- end, { desc = "Grep personal [d]otfiles" })
-- vim.keymap.set("n", "<leader>Cn", function()
--   require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
-- end, { desc = "Find [n]eovim config files" })
-- vim.keymap.set("n", "<leader>CN", function()
--   require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") })
-- end, { desc = "Grep [n]eovim config files" })
--
-- Removing
