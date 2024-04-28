--  See `:help vim.keymap.set()`
--
-- ================
-- Ruud's remapping
-- ================
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
-- *   | vsplit
-- *  [b buffer (and tab)]
-- *   c close buffer
-- *  [d debug]
-- *   e file explorer
-- *  [f file]
-- *  [g git]
-- *   h home
-- *  [l lsp and code]
-- *   m toggle comment
-- *   o open line below stay in normal mode
-- *   O open line above stay in normal mode
-- *  [p plugins]
-- *   q close window [resembles :q]
-- *   Q quit neovim
-- *  [s search/find]
-- *  [S Session]
-- *  [t terminal]
-- *  [T test]
-- *  [u user-interface]
-- *  [w window]
-- *   W save [resembles :w]
-- *  [q Quit]
-- *  [x diagnostics]
--
-- Groups
--
-- *  [b buffer (and tab)]
-- *     b go to previously active buffer
-- *    [c close]
-- *       c current buffer
-- *       o all others buffers
-- *       l buffers to left
-- *       r buffers to right
-- *       p non-pinned
-- *     e pick buffer from explorer
-- *     f find buffer by filename
-- *     g grep in buffers
-- *     hs go to buffer on left/right
-- *     HS go to first/last buffer
-- *     r resize mode
--       t pick from tabline
--       T new tab
--
-- *  [w window]
-- *     w go to previously active window
--       = balance windows
-- *     c close current window
-- *     htns go to left/top/bottom/right window
-- *     r resize
-- *    [m] move window (swap)
-- *     | create vertical split
-- *     \ create horizontal split
--
-- *  [f file]
-- *     n new file
-- *     f find file by filename
-- *     g grep in files
-- *     o old (recent) files
-- *     w find word in files
-- *     y filepath
-- *     Y filepath to clipboard
--
-- *  [g git]
--       l start lazygit
-- *     c list commits
-- *     b list branches
-- *     s status
--
-- *  [l lsp and code]
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
-- *  [x diagnostics]
--       b current buffer
--       w all buffers
--       ...
--
--
-- *  [D debug]
--       ...
--
-- *  [p plugins]
--       h checkhealth
--       m mason
--       u update
--       ...
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
-- *  [s search/find]
-- *     ' marks
-- *     . previous search
-- *     : command history
-- *     " registers
-- *     b telescope builtin
-- *     c commands
-- *     d dotfiles
-- *     D grep dotfiles
-- *     h help
-- *     k keymaps
-- *     m messages notifications
-- *     M manpages
-- *     n neovim config
-- *     N grep neovim files
-- *     o vim options
--       p yank history
--
-- *  [u user-interface]
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
--
-- *  [q Quit]
-- *     w Close window
-- *     b Close buffer
-- *     q Quit neovim
-- *     Q Quit neovim without saving

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
---- Commands are repeated under <leader>w
---- >>>> Set by smart-splits plugin
-- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
-- vim.keymap.set('n', '<C-n>', '<C-w>j', { desc = 'Go to Lower Window' })
-- vim.keymap.set('n', '<C-t>', '<C-w>k', { desc = 'Go to Upper Window' })
-- vim.keymap.set('n', '<C-s>', '<C-w>l', { desc = 'Go to Right Window' })
-- Create windows
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { desc = 'Vertical split' })
vim.keymap.set('n', '\\', '<cmd>split<cr>', { desc = 'Horizontal split' })

-- Resize Windows
-- >>>> Set by smart-splits plugin
-- vim.keymap.set('n', '<C-Up>', '<cmd>resize -2<CR>', { desc = 'Resize split up' })
-- vim.keymap.set('n', '<C-Down>', '<cmd>resize +2<CR>', { desc = 'Resize split down' })
-- vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Resize split left' })
-- vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Resize split right' })

-- Move between buffers
-- >>>> Set by bufferline plugin
-- vim.keymap.set('n', '<A-h>', '<cmd>bprev<cr>', { desc = 'Prev Buffer' })
-- vim.keymap.set('n', '<A-s>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

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

-- Add empty line
vim.keymap.set('n', '<leader>o', 'o<esc>', { desc = 'Add empty line after' })
vim.keymap.set('n', '<leader>O', 'O<esc>', { desc = 'Add empty line before' })

------------
-- LEADER --
------------

---- Direct actions ----

-- Commenting lines
vim.keymap.set('n', '<leader>m', 'gcc', { remap = true, desc = 'Comment line' })
vim.keymap.set('x', '<leader>m', 'gc', { remap = true, desc = 'Comment selection' })

-- Closing buffer, window, and neovim
vim.keymap.set('n', '<leader>c', '<cmd>bdelete<cr>', { remap = true, desc = 'Close buffer' })
vim.keymap.set('n', '<leader>W', '<cmd>w<cr>', { desc = 'Write (save)' })

-- Go to dashboard (home)
vim.keymap.set('n', '<leader>H', '<cmd>Dashboard<cr>', { desc = 'Home (dashboard)' })

---- Inside menu ----

-- Buffers
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Go to other buffer' })
vim.keymap.set('n', '<leader>bcc', '<cmd>bdelete<cr>', { desc = 'Current buffer' })
---- additional mappings set by bufferline plugin

-- Windows
---- close
vim.keymap.set('n', '<leader>wc', '<cmd>q<cr>', { desc = 'Close current window' })
---- create
vim.keymap.set('n', '<leader>w|', '<cmd>vsplit<cr>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>w\\', '<cmd>split<cr>', { desc = 'Horizontal split' })
---- navigate
vim.keymap.set('n', '<leader>ww', '<C-w>p', { desc = 'Go to other window' })
-- vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
-- vim.keymap.set('n', '<leader>wt', '<C-w>k', { desc = 'Go to upper window' })
-- vim.keymap.set('n', '<leader>wn', '<C-w>j', { desc = 'Go to lower window' })
-- vim.keymap.set('n', '<leader>ws', '<C-w>l', { desc = 'Go to right window' })
---- additional mappings set by smart-splits plugin

-- Quit
vim.keymap.set('n', '<leader>qw', '<cmd>q<cr>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>qb', '<cmd>bdelete<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit neovim' })
vim.keymap.set('n', '<leader>qQ', '<cmd>qa!<cr>', { desc = "Quit neovim, don't save" })

-- File
---- info
vim.keymap.set('n', '<leader>fn', '<cmd>ene | startinsert<cr>', { desc = 'New file' })
vim.keymap.set('n', '<leader>fy', function()
  local path = vim.fn.expand '%:p'
  vim.notify(path)
end, { desc = 'Current file path' })
vim.keymap.set('n', '<leader>fY', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = 'Current file path to clipboard' })

-- User interface
vim.keymap.set('n', '<leader>ud', function()
  require('notify').dismiss { pending = true, silent = true }
end, { desc = 'Dismiss notifications' })
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
vim.keymap.set('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
