return {
  "folke/todo-comments.nvim",
  event = "UIEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function() require("todo-comments").setup {} end,
}
