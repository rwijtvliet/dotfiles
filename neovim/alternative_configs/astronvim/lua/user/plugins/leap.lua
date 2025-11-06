return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  lazy = false,
  config = function() require("leap").add_default_mappings() end,
  opts = {
    highlight_unlabeled_phase_one_targets = true,
    safe_labels = { "j", "k", "f", "l", "u", "H", "K", "F", "L", "G", "U", "S" },
  },
}
