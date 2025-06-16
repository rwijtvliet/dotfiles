return {
  "CRAG666/code_runner.nvim",
  name = "coderunner",
  lazy = true,
  config = function()
    require("coderunner").setup {
      filetype = {
        python = "python3 -u",
      },
    }
  end,
}
