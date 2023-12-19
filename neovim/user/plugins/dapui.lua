return {
  "rcarriga/nvim-dap-ui",
  name = "nvimdapui",
  lazi = true,
  config = function()
    require("nvimdapui").setup {
      mappings = { toggle = "r" },
    }
  end,
}
