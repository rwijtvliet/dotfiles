return {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  event = "UIEnter",
  config = function()
    require("tokyonight").setup {
      style = "night",
      dim_inactive = true,
      sidebars = { "qf", "help", "terminal", "telescope" },
    }
  end,
}
