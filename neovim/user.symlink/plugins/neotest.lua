return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "folke/neodev.nvim",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-python",
  },
  lazy = false,
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          dap = { justMyCode = false },
        },
        require "neotest-plenary",
        --require "neotest-vim-test" {
        --  ignore_file_types = { "python", "vim", "lua" },
        --},
      },
    }
  end,
}
