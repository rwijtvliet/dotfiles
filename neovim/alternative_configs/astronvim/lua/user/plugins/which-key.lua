return {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").register {
      T = {
        name = "Testtt",
      },
    }
    require("which-key").setup {

      -- your configuration comes here.
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end,
}
