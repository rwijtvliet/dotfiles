return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>E", false },
    },
    opts = {
      window = {
        mappings = {
          ["<A-h>"] = "prev_source",
          ["<A-s>"] = "next_source",
          ["l"] = "noop",
          ["s"] = {
            function(state)
              local node = state.tree:get_node()
              if node and node.type == "directory" and not node:is_expanded() then
                state.commands.toggle_node(state)
              end
            end,
            desc = "Expand folder",
          },
          ["n"] = "noop",
          ["C"] = "noop",
          ["t"] = "noop",
          ["<"] = "noop",
          [">"] = "noop",
          ["_"] = { "open_tabnew", desc = "Open in new tap" },
          ["|"] = { "open_vsplit", desc = "Open in vertical split" },
          ["\\"] = { "open_split", desc = "Open in horizontal split" },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with system application",
          },
        },
      },
      filesystem = { filtered_items = { visible = true } },
    },
  },
}
