return { 
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        window = {
          mappings = {
            ["<A-h>"] = "prev_source",
            ["<A-s>"] = "next_source",
            ["l"] = false,
            ["s"] = "child_or_open",
            ["n"] = "", 
            ["t"] = "",
            ["<"] = false,
            [">"] = false,
            ["_"] = "open_tabnew",
            ["|"] = "open_vsplit",
            ["\\"] = "open_split",
          },
        },
      })
    end,
  }
