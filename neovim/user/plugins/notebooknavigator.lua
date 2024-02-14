return {
  "GCBallesteros/NotebookNavigator.nvim",
  dependencies = {
    "echasnovski/mini.comment",
    "Vigemus/iron.nvim", -- repl provider
    -- "akinsho/toggleterm.nvim", -- alternative repl provider
    -- "benlubas/molten-nvim", -- alternative repl provider
    "anuvyklack/hydra.nvim",
  },
  event = "VeryLazy",
  config = function()
    local nn = require "notebook-navigator"
    nn.setup { activate_hydra_keys = "<leader>h" }
  end,
}
