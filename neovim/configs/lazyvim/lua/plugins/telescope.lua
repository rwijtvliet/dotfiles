return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require("telescope.actions")
    local flash = opts.defaults.mappings.n.s
    return vim.tbl_deep_extend("force", opts, {
      defaults = {
        mappings = {
          n = {
            -- disable some keymaps
            -- ["j"] = actions.noop, -- already used for something else, see below
            ["k"] = actions.noop,
            ["s"] = actions.noop,
            ["L"] = actions.noop,

            -- set new keymaps
            ["n"] = actions.move_selection_next,
            ["t"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-t>"] = actions.move_selection_previous,
            ["S"] = actions.move_to_bottom,

            ["u"] = actions.preview_scrolling_up,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["d"] = actions.preview_scrolling_down,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["j"] = flash,

            ["<C-h>"] = actions.cycle_history_prev,
            ["<C-s>"] = actions.cycle_history_next,
          },
          i = {
            -- disable some keymaps
            -- ["<C-s>"] = false, -- already used for something else, see below

            -- set new keymaps
            ["<C-n>"] = actions.move_selection_next,
            ["<C-t>"] = actions.move_selection_previous, -- TODO: not working in some pickers, e.g. colorscheme picker

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-j>"] = flash,

            ["<C-h>"] = actions.cycle_history_prev,
            ["<C-s>"] = actions.cycle_history_next,
          },
        },
      },
    })
  end,
  keys = function(_, keys)
    -- return table, so that defaults are overwritten (and not merged)
    return {
      -- Command.
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- Buffer.
      {
        "<leader>bf",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Find buffer by filename",
      },
      { "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Current Buffer" },
      -- File.
      { "<leader>fc", LazyVim.telescope.config_files(), desc = "Find Config Files" },
      { "<leader>ff", LazyVim.telescope("files"), desc = "Find Files" },
      { "<leader>fG", LazyVim.telescope("live_grep"), desc = "Live Grep" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
      { "<leader>fw", LazyVim.telescope("grep_string", { word_match = "-w" }), desc = "Find Nearest Word" },
      { "<leader>fw", LazyVim.telescope("grep_string"), mode = "v", desc = "Find Selection" },
      -- File, but inside cwd.
      { "<leader>rff", LazyVim.telescope("files", { cwd = vim.uv.cwd() }), desc = "Find Files (cwd)" },
      { "<leader>rfG", LazyVim.telescope("live_grep", { cwd = vim.uv.cwd() }), desc = "Live Grep (cwd)" },
      { "<leader>rfr", LazyVim.telescope("oldfiles", { cwd = vim.uv.cwd() }), desc = "Find Recent Files (cwd)" },
      {
        "<leader>rfw",
        LazyVim.telescope("grep_string", { cwd = vim.uv.cwd(), word_match = "-w" }),
        desc = "Find Nearest Word (cwd)",
      },
      {
        "<leader>rfw",
        LazyVim.telescope("grep_string", { cwd = vim.uv.cwd() }),
        mode = "v",
        desc = "Find Selection (cwd)",
      },
      -- Git.
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- UI.
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme" },
      -- Code.
      { "<leader>ce", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>cE", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      -- Search.
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    }
  end,
}
