return {
  "rcarriga/nvim-dap-ui",
  name = "nvimdapui",
  config = function()
    require("nvimdapui").setup {
      mappings = { toggle = "r" },
    }
  end,
}
