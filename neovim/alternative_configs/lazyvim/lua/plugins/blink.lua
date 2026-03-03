return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap = opts.keymap or {}
    opts.keymap["<C-n>"] = { "select_next", "fallback" }
    opts.keymap["<C-t>"] = { "select_prev", "fallback" }
    opts.keymap["<C-s>"] = { "accept", "fallback" }
    opts.keymap["<C-p>"] = nil
  end,
}
