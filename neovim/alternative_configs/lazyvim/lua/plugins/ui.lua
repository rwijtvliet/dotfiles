return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    event = "UIEnter",
    config = function()
      require("gruvbox").setup {
        contrast = "",
        dim_inactive = true,
        italic = {
          strings = false,
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "UIEnter",
    lazy = true,
    config = function()
      require("catppuccin").setup {
        dim_inactive = { enabled = true, percentage = 0.25 },
      }
    end,
  },
}
