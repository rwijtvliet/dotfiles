return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["<A-h>"] = "prev_source",
        ["<A-s>"] = "next_source",
        ["l"] = "noop",
        ["s"] = "noop", --"child_or_open",
        ["n"] = "noop",
        ["t"] = "noop",
        ["<"] = "noop",
        [">"] = "noop",
        ["_"] = "open_tabnew",
        ["|"] = "open_vsplit",
        ["\\"] = "open_split",
      },
    },
    filesystem = { filtered_items = { visible = true } },
  },
  keys = function(_, keys)
    -- function returns table, in order to replace (instead of append) previous config
    return {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root() })
        end,
        desc = "File explorer",
      },
      {
        "<leader>re",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "File explorer (cwd)",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    }
  end,
}
