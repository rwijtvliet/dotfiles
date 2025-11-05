return {
  "folke/neodev.nvim",
  lazy = false,
  config = function()
    require("neodev").setup {
      library = { plugins = { "neotest" }, types = true },
    }
  end,
}
