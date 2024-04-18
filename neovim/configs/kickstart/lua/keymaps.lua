-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

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

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Navigation
---- using '' for mode to specify normal (= 'n'), visual (= 'v'), and operator-pending (= 'o') mode. See `:help map-modes`
vim.keymap.set('', 'h', 'h', { desc = 'Move left' }) -- for completeness
vim.keymap.set('', 'n', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'move down' })
vim.keymap.set('', 't', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'move up' })
vim.keymap.set('', 's', 'l', { desc = 'move right' })
---- Disable arrow keys
vim.keymap.set('', '<left>', '<cmd>echo "Use h to move left!!"<CR>')
vim.keymap.set('', '<right>', '<cmd>echo "Use s to move right!!"<CR>')
vim.keymap.set('', '<up>', '<cmd>echo "Use t to move up!!"<CR>')
vim.keymap.set('', '<down>', '<cmd>echo "Use n to move down!!"<CR>')

-- Move to beginning/end of line/screen
vim.keymap.set('', 'H', 'H', { desc = 'Move cursor to top of screen' }) -- for completeness
vim.keymap.set('', 'S', 'L', { desc = 'Move cursor to bottom of screen' })
vim.keymap.set('', 'B', '^', { desc = 'Move to beginning of line' })
vim.keymap.set('', 'E', '$', { desc = 'Move to end of line' })

-- Move between windows
---- see `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
vim.keymap.set('n', '<C-n>', '<C-w>j', { desc = 'Go to Lower Window' })
vim.keymap.set('n', '<C-t>', '<C-w>k', { desc = 'Go to Upper Window' })
vim.keymap.set('n', '<C-s>', '<C-w>l', { desc = 'Go to Right Window' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Go to Left Window' })
vim.keymap.set('n', '<leader>wn', '<C-w>j', { desc = 'Go to Lower Window' })
vim.keymap.set('n', '<leader>wt', '<C-w>k', { desc = 'Go to Upper Window' })
vim.keymap.set('n', '<leader>ws', '<C-w>l', { desc = 'Go to Right Window' })

-- Move between buffers
vim.keymap.set('n', '<A-h>', '<cmd>bprev<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<A-s>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- Search results
vim.keymap.set('', 'l', 'n', { desc = 'Next search result' })
vim.keymap.set('', 'L', 'N', { desc = 'Prev search result' })

-- Help
vim.keymap.set('n', 'T', 'K', { desc = 'Help' })

-- Substitute (substitute line not remapped; not necessary because is same as cc)
vim.keymap.set('n', 'j', 's', { desc = 'Substitute character' })

-- Till -- TODO: Use flash instead. Currently problem with flash settings, see flash.lua.
vim.keymap.set('', 'k', 't', { desc = 'Till (forward)' })
vim.keymap.set('', 'K', 'T', { desc = 'Till (backward)' })

-- Move Lines
vim.keymap.set('n', '<A-n>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-t>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<A-n>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-t>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-n>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-t>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Commenting lines
vim.keymap.set('n', '<leader>m', 'gcc', { desc = 'Co[m]ment line' })
vim.keymap.set('x', '<leader>m', 'gc', { desc = 'Co[m]ment selection' })

---- File info
vim.keymap.set('n', '<leader>fy', function()
  local path = vim.fn.expand '%:p'
  vim.notify(path)
end, { desc = '[y] Current file path' })
vim.keymap.set('n', '<leader>fY', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = '[Y] Current file path to clipboard' })
--
--
--
--
--
--

---- Go to dashboard (home)
vim.keymap.set('n', '<leader>h', '<cmd>Dashboard<cr>', { desc = 'Home (dashboard)' })
--
--
-- TODO: These are from the initial kickstart config. See if still needed later.
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=4 sts=4 sw=4 et
