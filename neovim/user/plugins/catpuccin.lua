return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "UIEnter",
  config = function()
    require("catppuccin").setup {
      dim_inactive = { enabled = true, percentage = 0.25 },
    }
  end,
}
