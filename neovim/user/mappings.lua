local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local is_available = utils.is_available
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local maps = {
  [""] = {
    -- navigation
    ["h"] = { "h", desc = "Move left" },
    -- ["n"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'j' : 'gj'", expr = true, desc = "Move down" },
    ["n"] = { "gj", desc = "Move down" },
    ["<down>"] = { "gj", desc = "Move down" },
    -- ["t"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'k' : 'gk'", expr = true, desc = "Move up" },
    ["t"] = { "gk", desc = "Move up" },
    ["<up>"] = { "gk", desc = "Move up" },
    ["s"] = { "l", desc = "Move right" },
    ["S"] = { "L", desc = "Move cursor to bottom of screen" },
    -- search
    ["l"] = { "n", desc = "Next search result" },
    ["L"] = { "N", desc = "Prev search result" },
    -- leap
    ["m"] = { "<Plug>(leap-forward-to)", desc = "Leap forward to match" },
    ["M"] = { "<Plug>(leap-backward-to)", desc = "Leap backward to match" },
    ["gm"] = { "<Plug>(leap-from-window)", desc = "Leap to match in other window" },
    -- move begining/end of line
    ["B"] = { "^", desc = "Move to beginning of line" },
    ["E"] = { "$", desc = "Move to end of line" },
    -- set mark
    ["<A-m>"] = { "m", desc = "Set marker" },
    -- move till word
    ["k"] = { "t", noremap = true, desc = "Till (forward)" }, -- expr = false needed to override astrovim mapping for k
    ["K"] = { "T", noremap = true, desc = "Till (backward)" },
  },

  -- first key is the mode
  n = {
    -- substitute
    ["j"] = { "s", expr = false, noremap = true, desc = "Substitute character" }, -- expr = false needed to override astrovim mapping for j
    -- REPL with iron (see :h iron-commands for all available commands)
    ["<leader>s"] = { desc = get_icon("Run", 1, true) .. "Run" },
    ["<leader>so"] = { "<cmd>IronRepl<cr>", desc = "Open/toggle REPL" },
    ["<leader>sr"] = { "<cmd>IronRestart<cr>", desc = "Restart REPL" },
    ["<leader>ss"] = { "<cmd>IronFocus<cr>", desc = "Focus REPL" },
    ["<leader>sf"] = { function() require("iron.core").send_file() end, desc = "Run entire file" },
    ["<leader>sl"] = { function() require("iron.core").send_line() end, desc = "Run line" },
    ["<leader>sm"] = { function() require("iron.core").send_motion() end, desc = "Run motion" },
    ["<leader>sv"] = { function() require("iron.core").send_visual() end, desc = "Run selection" },
    ["<leader>sa"] = { function() require("iron.core").send_until_cursor() end, desc = "Run code above" },
    ["<leader>sX"] = { function() require("notebook-navigator").run_and_move() end, desc = "Run cell + move" },
    ["<leader>sx"] = { function() require("notebook-navigator").run_cell() end, desc = "Run cell" },
    ["<leader>sq"] = { "<cmd>IronHide<cr>", desc = "Hide REPL" },
    -- Notebooknavigation (parts not shown above)
    ["]h"] = { function() require("notebook-navigator").move_cell "d" end, desc = "Next cell" },
    ["[h"] = { function() require("notebook-navigator").move_cell "u" end, desc = "Prev cell" },
    -- Testing with Neotest
    ["<leader>T"] = { desc = get_icon("Testing", 1, true) .. "Test" },
    ["<leader>Ta"] = { function() require("neotest").run.attach() end, desc = "Attach" },
    ["<leader>Tf"] = { function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run File" },
    ["<leader>TF"] = {
      function() require("neotest").run.run { vim.fn.expand "%", strategy = "dap" } end,
      desc = "Debug File",
    },
    ["<leader>Tl"] = { function() require("neotest").run.run_last() end, desc = "Run Last" },
    ["<leader>TL"] = { function() require("neotest").run.run_last { strategy = "dap" } end, desc = "Debug Last" },
    ["<leader>Tn"] = { function() require("neotest").run.run() end, desc = "Run Nearest" },
    ["<leader>TN"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug Nearest" },
    ["<leader>To"] = { function() require("neotest").output.open { enter = true } end, desc = "Output" },
    ["<leader>TS"] = { function() require("neotest").run.stop() end, desc = "Stop" },
    ["<leader>Ts"] = { function() require("neotest").summary.toggle() end, desc = "Summary" },
    -- Docstring with Neogen
    ["<leader>D"] = { function() require("neogen").generate() end, desc = "Docstring" },
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- Update some keys used for debugging
    ---- start/restart: unchanged (F5) and new (Shift-F5)
    -- ["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" },
    -- ["<leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" },
    ["<F17>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" }, -- Shift+F5
    ["<leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (S-F5)" },
    ---- pause/stop: unchange (F6) and new (Shift-F6)
    -- ["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" },
    -- ["<leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" },
    ["<F18>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" }, -- Shift+F6
    ["<leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F6)" },
    ---- set breakpoints: unchanged (F9 and Shift-F9)
    -- ["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
    -- ["<leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" },
    -- ["<F21>"] = { function() vim.ui.input({ prompt = "Condition: " }, function(condition) if condition then require("dap").set_breakpoint(condition) end end) end, desc = "Debugger: Conditional Breakpoint", },
    -- ["<leader>dC"] = { function() vim.ui.input({ prompt = "Condition: " }, function(condition) if condition then require("dap").set_breakpoint(condition) end end) end, desc = "Conditional Breakpoint (S-F9)", },
    -- ["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" },
    ---- stepping: changed (F2, F3, F4)
    ["<F2>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" },
    ["<leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F2)" },
    ["<F3>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" },
    ["<leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F3)" },
    ["<F4>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" }, -- Shift+F11
    ["<leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (F4)" },
    ---- unset previous mappings
    ["<F10>"] = false,
    ["<F11>"] = false,
    ["<F23>"] = false,
    ["<F29>"] = false,
    ["<leader>dq"] = { function() require("dap").close() end, desc = "Close Session" },
    ["<leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    ["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" },
    -- Move between buffers
    ["<A-s>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<A-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!end, desc = "Save File" },  -- change description but the same command
    -- Change find actions to follow symlinks
    ["<leader>fF"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true, follow = true } end,
      desc = "Find all files",
    },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore", "-L" }) end,
        }
      end,
      desc = "Find words in all files",
    },
    -- color picker
    ["<leader>uo"] = { "<cmd>Telescope colorscheme<cr>", desc = "Pick colorscheme" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    ["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" },
    ["<C-n>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" },
    ["<C-t>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" },
    ["<C-s>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" },
  },
  i = {},
  v = {
    [">"] = { ">gv", desc = "Increase indentation (visual mode)" },
    ["<"] = { "<gv", desc = "Decrease indentation (visual mode)" },
    ["p"] = { '"_dP', desc = "Don't replace register when pasting in visual mode" },
    ["<leader>s"] = { desc = get_icon("Run", 1, true) .. "Run" },
    ["<leader>sv"] = { function() require("iron.core").send_visual() end, desc = "Run selection" },
  },
}
-- Move lines.
maps.n["<A-t>"] = { "<cmd>m .-2<CR>==", desc = "Move line up" }
maps.n["<A-n>"] = { "<cmd>m .+1<CR>==", desc = "Move line down" }
maps.i["<A-t>"] = { "<Esc><cmd>m .-2<CR>==gi", desc = "Move line up" }
maps.i["<A-n>"] = { "<Esc><cmd>m .+1<CR>==gi", desc = "Move line down" }
maps.v["<A-t>"] = { ":m .-2<CR>==", desc = "Move line(s) up" }
maps.v["<A-n>"] = { ":m .+1<CR>==", desc = "Move line(s) down" }
for _, mode in ipairs { "n", "i", "v" } do
  maps[mode]["<A-Up>"] = maps[mode]["<A-t>"]
  maps[mode]["<A-Down>"] = maps[mode]["<A-n>"]
end
-- Move between splits.
if is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-n>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-t>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-s>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-n>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-t>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-s>"] = { "<C-w>l", desc = "Move to right split" }
end

return maps
