-- IMPORTED

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

-- Disable unwanted keymaps
---- Navigate to other split (set by lazyvim)
vim.keymap.set("n", "<C-j>", "")
vim.keymap.set("n", "<C-k>", "")
vim.keymap.set("n", "<C-l>", "")
---- Navigate to other buffer
vim.keymap.set("n", "L", "")
---- Move line (set by lazyvim)
vim.keymap.set("n", "<A-j>", "")
vim.keymap.set("n", "<A-k>", "")
vim.keymap.set("i", "<A-j>", "")
vim.keymap.set("i", "<A-k>", "")
vim.keymap.set("v", "<A-j>", "")
vim.keymap.set("v", "<A-k>", "")

---- Navigation
vim.keymap.set("", "h", "h", { expr = false, silent = true, desc = "move left" })
vim.keymap.set("", "n", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "move down" })
vim.keymap.set("", "t", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "move up" })
vim.keymap.set("", "s", "l", { expr = false, silent = true, desc = "move right" })

---- Move to beginning/end of line/screen
vim.keymap.set("", "H", "H", { desc = "Move cursor to top of screen" }) -- re-set; was overwritten by lazyvim
vim.keymap.set("", "S", "L", { desc = "Move cursor to bottom of screen" })
vim.keymap.set("", "B", "^", { desc = "Move to beginning of line" })
vim.keymap.set("", "E", "$", { desc = "Move to end of line" })

---- Move between windows
vim.keymap.set("n", "<C-n>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-t>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-s>", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<leader>wn", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<leader>wt", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<leader>ws", "<C-w>l", { desc = "Go to Right Window", remap = true })

---- Move between buffers
vim.keymap.set("n", "<A-h>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<A-s>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

---- Search results
vim.keymap.set("", "l", "n", { desc = "Next search result" })
vim.keymap.set("", "L", "N", { desc = "Prev search result" })

---- Help
vim.keymap.set("n", "T", "K", { noremap = true, desc = "Help" })

---- Substitute (substitute line not remapped; not necessary because is same as cc)
vim.keymap.set("n", "j", "s", { desc = "Substitute character" })

---- Till -- TODO: Use flash instead. Currently problem with flash settings, see flash.lua.
vim.keymap.set("", "k", "t", { expr = false, noremap = true, desc = "Till (forward)" })
vim.keymap.set("", "K", "T", { expr = false, noremap = true, desc = "Till (backward)" })

---- Move Lines
vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
vim.keymap.set("n", "<A-n>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-t>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-n>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-t>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-n>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-t>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

---- Comment Lines
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, silent = true, desc = "Comment line" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, silent = true, desc = "Comment selection" })

---- File info
vim.keymap.set("n", "<leader>fp", function()
  local path = vim.fn.expand("%:p")
  vim.notify(path)
end, { desc = "Current file path" })
vim.keymap.set("n", "<leader>fP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Current file path to clipboard" })

---- Go to dashboard (home)
vim.keymap.set("n", "<leader>h", "<cmd>Dashboard<cr>", { desc = "Home (dashboard)" })

vim.keymap.set("n", "<leader>Cd", function()
  require("telescope.builtin").find_files({ cwd = "~/.dotfiles/" })
end, { desc = "Find personal [d]otfiles" })
vim.keymap.set("n", "<leader>CD", function()
  require("telescope.builtin").live_grep({ cwd = "~/.dotfiles/" })
end, { desc = "Grep personal [d]otfiles" })
vim.keymap.set("n", "<leader>Cn", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find [n]eovim config files" })
vim.keymap.set("n", "<leader>CN", function()
  require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") })
end, { desc = "Grep [n]eovim config files" })
