return {
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup({
      timeout = 150,
      default_mappings = false,
      mappings = {
        i = { g = { c = "<Esc>" } },
      },
    })
  end,
}
