-- Substitute keymaps of the LSP.

local substitute = require("util.keymap_substituter")

local lspconfig_substitutions = {
  ["<A-n>"] = "]r",
  ["<A-p>"] = "[r",
  ["K"] = "T",
}

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers["*"] = opts.servers["*"] or {}
    opts.servers["*"].keys = opts.servers["*"].keys or {}
    opts.servers["*"].keys = substitute.apply(opts.servers["*"].keys, lspconfig_substitutions)
  end,
}
