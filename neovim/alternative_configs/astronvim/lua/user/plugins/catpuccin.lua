return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "UIEnter",
  lazy = true,
  config = function()
    require("catppuccin").setup {
      dim_inactive = { enabled = true, percentage = 0.25 },
    }
  end,
}
