return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap = opts.keymap or {}
    opts.keymap["<C-n>"] = { "select_next", "fallback" }
    opts.keymap["<C-t>"] = { "select_prev", "fallback" }
    opts.keymap["<C-s>"] = { "accept", "fallback" }
    opts.keymap["<C-l>"] = {
      function(cmp)
        if LazyVim.cmp.map({ "ai_nes", "ai_accept" })() then
          return true
        end
        return cmp.select_and_accept()
      end,
      "fallback",
    }
    opts.keymap["<C-p>"] = nil
    opts.keymap["<CR>"] = { "fallback" }
  end,
}
