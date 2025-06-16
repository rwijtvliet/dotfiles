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
-- ---------------------
-- prev ([) and next (])
-- ---------------------
-- *   b buffer
-- *   c notebook cell
-- *   q quickfix item
--
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
-- *   C close buffer (don't save)
-- *  [d debug]
-- *   e file explorer
-- *  [f file]
-- *  [g git]
-- *   h home
-- *  [l lsp and code]
-- *  [m terminal]
-- *  [M markdown]
-- *   o open line below stay in normal mode
-- *   O open line above stay in normal mode
-- *  [P plugins]
-- *   q close window [resembles :q]
-- *   Q quit neovim
-- *  [s search/find]
-- *  [S Session]
-- *  [t test]
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
-- *     t pick from bufferline
-- *     T new tab
-- *     w save
--
-- *  [w window]
-- *     w go to previously active window
--       = balance windows
-- *     c close current window
-- *     htns go to left/top/bottom/right window
--       HTNS move with buffer to left/top/bottom/right window
-- *     r resize
-- *    [m] move window (swap)
-- *     | force vertical split
-- *     \ force horizontal split
--
-- *  [f file]
-- *     n new file
-- *     f find file by filename
-- *     F grep in files
-- *     o old (recent) files
-- *     w find word in files
-- *     y filepath
-- *     Y filepath to clipboard
--
-- *  [g git]
-- *     l start lazygit
-- *     c list commits
-- *     B line blame
-- *     b list branches
-- *     s status
-- *     p preview hunk
-- *    [a add]
-- *       h hunk
-- *       b buffer
-- *    [u unstage]
-- *       h hunk
-- *    [r reset]
-- *       h hunk
-- *       b buffer
--
-- *  [l lsp and code]
-- *     a code action (?)
--       A source action (?)
-- *     d docstring
--       f format
--       l lsp info
-- *     r rename
-- *     s symbols (? builtin.symbols or builtin.lsp_xxx_symbols?)
-- *     x diagnostics in all buffers (or: seperate menu?)
--
-- *  [x diagnostics]
--       b current buffer
--       w all buffers
--       ...
--
-- *  [d debug]
-- *     b toggle breakpoint
-- *     B set contidional breakpoint
-- *     c run to curson
-- *     i <F2> step in
-- *     o <F3> step over
-- *     O <F4> step out
-- *     l last session result
-- *     s <F1> start
-- *     S <S-F1> restart
-- *     q close debugger
-- *     Q terminate debugger
-- *     v eval var under cursor
--
-- *  [P plugins]
-- *     l lazy
-- *     h checkhealth
-- *     m mason
--       u update
--       ...
--
-- *  [r run code].
-- *     b run entire buffer
-- *     c run until cursor
-- *     l run line
-- *     p run paragraph
-- *     x run cell
-- *     y run cell + move next
--
-- *     f focus REPL window
-- *     r start/hide REPL
-- *     c close REPL
-- *     R restart REPL
--
-- *     n navigate
--
--    [m terminal]
--       f in floating window
--       | in vertical split
--       \ in horizontal split
--
-- *  [t test]
-- *     r run nearest
-- *     R run last
-- *     d debug nearest
-- *     D debug last
-- *     s stop nearest
-- *     a attach to nearest
-- *    [f] file
-- *       r run file
-- *       d debug file
-- *       s stop file
-- *     a attach to file
-- *     o toggle output
--       u toggle summary
--
-- *  [S Session]
-- *     l restore last
-- *     d restore directory
-- *     g restore git branch
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
-- *     a toggle autopairs
-- *     b toggle background
--       c toggle autocompletion
--       C toggle color highlight (?)
-- *     d dismiss notifications
--       e toggle diagnostics
--       g toggle signcolumn
-- *     f toggle flash for finding on/of
--       i indentation
-- *     l toggle line numbering
-- *     L toggle relative line numbering
--       N toggle notifications
-- *     o colorscheme
--       p toggle paste mode
-- *     S toggle spellcheck
--       T toggle tabline
--       u toggle url highlight
-- *     w toggle word wrap
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
vim.keymap.set('', 'h', 'h', { desc = 'Move cursor left' }) -- for completeness
vim.keymap.set('', 'n', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cursor down' })
vim.keymap.set('', 't', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cursor up' })
vim.keymap.set('', 's', 'l', { desc = 'Move cursor right' })
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
vim.keymap.set('n', 'T', 'K', { desc = 'Help' })

-- Substitute (substitute line not remapped; not necessary because is same as cc)
vim.keymap.set('n', 'j', 's', { desc = 'Substitute character' })

-- Till
vim.keymap.set('', 'k', 't', { desc = 'Move until next char' })
vim.keymap.set('', 'K', 'T', { desc = 'Move until previous char' })

-- Move Lines
vim.keymap.set('n', '<A-n>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-t>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-n>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-t>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
vim.keymap.set('v', '<A-n>', ":m '>+1<cr>gv=gv", { desc = 'Move lines down' })
vim.keymap.set('v', '<A-t>', ":m '<-2<cr>gv=gv", { desc = 'Move lines up' })

-- Move and copy lines
vim.keymap.set('n', '<A-N>', 'mzyyP`z', { desc = 'Copy line down' })
vim.keymap.set('n', '<A-T>', 'mzyyp`z', { desc = 'Copy line up' })
vim.keymap.set('i', '<A-N>', '<esc>mzyyP`zi', { desc = 'Copy line down' })
vim.keymap.set('i', '<A-T>', '<esc>mzyyp`zi', { desc = 'Copy line up' })
-- TODO: copy lines down/up in visual mode

-- Add empty line
vim.keymap.set('n', '<leader>o', 'o<Up><Esc>', { desc = 'Add empty line after' })
vim.keymap.set('n', '<leader>O', 'O<Down><Esc>', { desc = 'Add empty line before' })

------------------------
-- prev ([) and next (])
------------------------

-- Alternatives for [ and ] (because difficult on custom keyboards).
vim.keymap.set('', 'gt', '[', { remap = true, desc = 'Go prev' })
vim.keymap.set('', 'gn', ']', { remap = true, desc = 'Go next' })
-- TODO: remap gN and gn to gL and gl (search and select)

-- Buffer
vim.keymap.set('n', ']t', 'gt', { desc = 'Next tab' })
vim.keymap.set('n', '[t', 'gT', { desc = 'Prev tab' })

-- Quickfix item
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'Prev quickfix item' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix item' })

-- Diagnostics
vim.keymap.set('n', '[x', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic message' })
vim.keymap.set('n', ']x', vim.diagnostic.goto_next, { desc = 'Next diagnostic message' })

------------
-- LEADER --
------------

---- Direct actions ----

-- Closing buffer, window, and neovim
vim.keymap.set('n', '<leader>W', '<cmd>w<cr>', { desc = 'Write (save)' })

-- Go to dashboard (home)
vim.keymap.set('n', '<leader>H', '<cmd>Dashboard<cr>', { desc = 'Home (dashboard)' })

-- Paste without losing contents of paste-register
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste (keeping register)' })

---- Inside menu ----

-- b Buffers
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Go to other buffer' })
vim.keymap.set('n', '<leader>bT', '<cmd>tabnew<cr>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>bw', '<cmd>w<cr>', { desc = 'Write (save)' })
---- additional mappings set by bufferline plugin

-- w Windows
---- close
vim.keymap.set('n', '<leader>wc', '<cmd>q<cr>', { desc = 'Close current window' })
---- create
vim.keymap.set('n', '<leader>w|', '<C-w>H', { desc = 'Current window to vertical split' })
vim.keymap.set('n', '<leader>w\\', '<C-w>K', { desc = 'Current window to horizontal split' })
---- navigate
vim.keymap.set('n', '<leader>ww', '<C-w>p', { desc = 'Go to other window' })
-- vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
-- vim.keymap.set('n', '<leader>wt', '<C-w>k', { desc = 'Go to upper window' })
-- vim.keymap.set('n', '<leader>wn', '<C-w>j', { desc = 'Go to lower window' })
-- vim.keymap.set('n', '<leader>ws', '<C-w>l', { desc = 'Go to right window' })
---- additional mappings set by smart-splits plugin

-- l LSP/Code

-- P plugins
vim.keymap.set('n', '<leader>Ph', '<cmd>checkhealth<cr>', { desc = 'Check health' })
vim.keymap.set('n', '<leader>Pm', '<cmd>Mason<cr>', { desc = 'Mason' })
vim.keymap.set('n', '<leader>Pl', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>Pv', '<cmd>term cd $HOME/.dotfiles/neovim && poetry install<Cr>', { desc = 'Update neovim virtualenv' })

-- q Quit
vim.keymap.set('n', '<leader>qw', '<cmd>q<cr>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>qb', '<cmd>BufDel<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>qq', '<cmd>wa<cr><cmd>qa<cr>', { desc = 'Quit neovim (save all)' })
vim.keymap.set('n', '<leader>qQ', '<cmd>qa!<cr>', { desc = "Quit neovim, don't save" })

-- f File
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

-- u User interface
vim.keymap.set('n', '<leader>ub', function()
  local newbackground = (vim.go.background == 'dark' and 'light' or 'dark')
  vim.go.background = newbackground
  vim.notify('Background ' .. newbackground)
end, { desc = 'Toggle background' })
vim.keymap.set('n', '<leader>ud', function()
  require('notify').dismiss { pending = true, silent = true }
end, { desc = 'Dismiss notifications' })
vim.keymap.set('n', '<leader>ul', function()
  if vim.wo.nu and vim.wo.rnu then -- to turn off line numbers, first deactivate relative numbers
    vim.wo.rnu = false
  end
  vim.wo.number = not vim.wo.number
  vim.notify('Line numbers ' .. (vim.wo.number and 'on' or 'off'))
end, { desc = 'Toggle line numbers' })
vim.keymap.set('n', '<leader>uL', function()
  if not vim.wo.nu then -- to toggle relative numbers, first show line numbers
    vim.wo.nu = true
  end
  vim.wo.rnu = not vim.wo.rnu
  vim.notify('Relative line numbering ' .. (vim.wo.rnu and 'on' or 'off'))
end, { desc = 'Toggle relative line numbers' })
vim.keymap.set('n', '<leader>uS', function()
  vim.wo.spell = not vim.wo.spell
  vim.notify('Spell check ' .. (vim.wo.spell and 'on' or 'off'))
end, { desc = 'Toggle spell check' })
vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('Wordwrap ' .. (vim.wo.wrap and 'on' or 'off'))
end, { desc = 'Toggle word wrap' })
--
--
--
--
--
--
vim.keymap.set('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- try if there is a disadvantage when setting SINGLE esc to exit terminal mode

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
