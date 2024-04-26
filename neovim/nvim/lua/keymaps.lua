-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- ================
-- Ruud's remapping
-- ================
--
--
-- ------------------------------
-- Normal-mode alphanumberic keys
-- ------------------------------
--
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
--
--
-- ----------
-- Leader key
-- ----------
-- (* = implemented)
--
-- *   / Search current buffer
--    [b buffer (and tab)]
-- *   c close buffer
--    [C config]
--    [D debug]
-- *   e file explorer
--    [f file]
--    [g git]
-- *   h home
--    [l lsp and code]
-- *   m toggle comment
--     o open line below stay in normal mode
--     O open line above stay in normal mode
--    [p plugins]
-- *   q close window [resembles :q]
-- *   Q quit neovim
--    [s search/find]
--    [S Session]
--    [t terminal]
--    [T test]
--    [u user-interface]
--    [w window]
-- *   W save [resembles :w]
--    [x diagnostics]
--
-- Groups
--
--    [b buffer (and tab)]
--       b go to previously active buffer
--      [c close]
--         c current buffer
--         C all others buffers
--         r buffers to right
--         l buffers to left
-- *     f find buffer by filename
-- *     g grep in buffers
--       H go to first buffer
--      [p pick]
--         t from tabline
--       S go to last buffer
--       t new tab
--
--    [w window]
--       w go to previously active window
--      [c close]
--         c current window
--
--    [f file]
--       n new file
-- *     f find file by filename
-- *     g grep in files
-- *     o old (recent) files
-- *     w find word in files
-- *     y filepath
-- *     Y filepath to clipboard
--
--    [g git]
--       l start lazygit
-- *     c list commits
-- *     b list branches
-- *     s status
--
--    [l lsp and code]
--       a code action (?)
--       A source action (?)
--       d docstring
--       f format
--       l lsp info
--       m mason
--       r rename
-- *     s symbols (? builtin.symbols or builtin.lsp_xxx_symbols?)
-- *     x diagnostics in all buffers (or: seperate menu?)
--
--    [x diagnostics]
--       b current buffer
--       w all buffers
--       ...
--
--
--    [D debug]
--       ...
--
--    [p plugins]
--       h checkhealth
--       m mason
--       u update
--       ...
--
--    [C config]
-- *     n neovim config files
-- *     d personal dotfiles
--
--    [r run code]
--       ...
--
--    [t terminal]
--       f in floating window
--       | in vertical split
--       \ in horizontal split
--
--    [T test]
--       ...
--
--    [S Session]
--       l open last
--       ...
--
--    [s search/find]
-- *     ' marks
-- *     . previous search
-- *     : command history
-- *     " registers
-- *     b telescope builtin
-- *     c commands
-- *     n notifications
-- *     k keymaps
-- *     h help
-- *     m manpages
--       p yank history
--
--    [u user-interface]
--       a toggle autopairs
--       b toggle background
--       c toggle autocompletion
--       C toggle color highlight (?)
-- *     d dismiss notifications
--       e toggle diagnostics
--       g toggle signcolumn
--       f toggle foldcolumn
--       i indentation
--       l toggle codelens
--       N toggle notifications
--       n line numbering
-- *     o colorscheme
--       p toggle paste mode
--       s toggle spellcheck
--       S toggle statusline
--       T toggle tabline
--       u toggle url highlight
--       w toggle word wrap
--       y toggle syntax highlight (buffer)

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('', '<C-e>', '<Nop>')
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
vim.keymap.set('n', 'T', 'K', { remap = true, desc = 'Help' })

-- Substitute (substitute line not remapped; not necessary because is same as cc)
vim.keymap.set('n', 'j', 's', { desc = 'Substitute character' })

-- Till -- TODO: Use flash instead. Currently problem with flash settings, see flash.lua.
vim.keymap.set('', 'k', 't', { desc = 'Till (forward)' })
vim.keymap.set('', 'K', 'T', { remap = false, desc = 'Till (backward)' })

-- Move Lines
vim.keymap.set('n', '<A-n>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-t>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<A-n>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-t>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-n>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-t>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

------------
-- LEADER --
------------

---- Direct actions ----

-- Commenting lines
vim.keymap.set('n', '<leader>m', 'gcc', { remap = true, desc = 'Co[m]ment line' })
vim.keymap.set('x', '<leader>m', 'gc', { remap = true, desc = 'Co[m]ment selection' })

-- Closing buffer, window, and neovim
vim.keymap.set('n', '<leader>c', '<leader>bc', { remap = true, desc = '[C]lose buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = '[Q]uit window' })
vim.keymap.set('n', '<leader>Q', '<cmd>qa<cr>', { desc = '[Q]uit neovim' })
vim.keymap.set('n', '<leader>W', '<cmd>w<cr>', { desc = '[W]rite (save)' })
vim.keymap.set('n', '<leader>bc', '<cmd>bdelete<cr>', { desc = '[C]lose buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Go to other [b]uffer' })

-- Go to dashboard (home)
vim.keymap.set('n', '<leader>H', '<cmd>Dashboard<cr>', { desc = '[H]ome (dashboard)' })

---- Inside menu ----

-- File info
vim.keymap.set('n', '<leader>fn', '<cmd>ene | startinsert<cr>', { desc = '[n]ew file' })
vim.keymap.set('n', '<leader>fy', function()
  local path = vim.fn.expand '%:p'
  vim.notify(path)
end, { desc = '[y] Current file path' })
vim.keymap.set('n', '<leader>fY', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = '[Y] Current file path to clipboard' })

-- User interface
vim.keymap.set('n', '<leader>ud', function()
  require('notify').dismiss { pending = true, silent = true }
end, { desc = '[D]ismiss notifications' })
--
--
--
--

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
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { '*' },
  command = 'nnoremap <buffer> K T',
})
-- vim: ts=4 sts=4 sw=4 et
