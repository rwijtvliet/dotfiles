return {
  -- Line at top of screen with buffers.
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.indicator = { style = "underline" }
    end,
  },
  -- General colorscheme tweaks to enhance readability.
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = opts.colorscheme or "tokyonight"

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local cursor = vim.api.nvim_get_hl(0, { name = "CursorLine" })
          if cursor.bg then
            vim.api.nvim_set_hl(0, "NormalNC", { bg = string.format("#%06x", cursor.bg) })
          end
          vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })
        end,
      })
    end,
  },
  -- Additional colorschemes.
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        -- contrast = "",
        dim_inactive = true,
        -- italic = {
        --   strings = false,
        -- },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        dim_inactive = { enabled = true, percentage = 0.75 },
      })
    end,
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = { dark_variant = "moon" },
  },
}
