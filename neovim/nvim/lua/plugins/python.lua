return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    lazy = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
    end,
    config = function()
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>")
      vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateOperator<CR>")
      vim.keymap.set("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>")
      vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>")
      vim.keymap.set("n", "<leader>mo", ":MoltenOpenOutput<CR>")
      vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>")
    end,
  },

  -- {
  --   "3rd/image.nvim",
  --   opts = {
  --     backend = "wezterm",
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --       },
  --     },
  --   },
  -- },
  --
  --

  {
    "Vigemus/iron.nvim",
    ft = { "python" },
    opts = function()
      local view = require("iron.view")

      return {
        config = {
          scratch_repl = true,

          repl_definition = {
            python = {
              format = require("iron.fts.common").bracketed_paste,
              command = { "ipython", "--no-autoindent" },
            },
          },

          repl_open_cmd = view.split.vertical.botright(0.30),
        },

        highlight = { italic = true },
        ignore_blank_lines = true,
      }
    end,
  },
}
