return {
  "rcarriga/nvim-dap-ui",
  name = "nvimdapui",
  lazy = true,
  config = function()
    require("nvimdapui").setup {
      mappings = { toggle = "r" },
    }
  end,
}
