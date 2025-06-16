return {
  "danymat/neogen",
  name = "neogen",
  event = "BufEnter",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "numpydoc",
          },
        },
      },
    }
  end,
}
