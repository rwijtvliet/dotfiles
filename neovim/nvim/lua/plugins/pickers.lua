-- lua/config/noice.lua
return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      -- preserve existing options
      opts.views = opts.views or {}
      opts.views.popupmenu = opts.views.popupmenu or {}
      opts.views.popupmenu.keys = opts.views.popupmenu.keys or {}

      -- remap keys
      opts.views.popupmenu.keys["<C-t>"] = "previous"
      opts.views.popupmenu.keys["<C-p>"] = false
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = opts.defaults or {}
      opts.defaults.mappings = opts.defaults.mappings or {}
      opts.defaults.mappings.i = opts.defaults.mappings.i or {}
      opts.defaults.mappings.n = opts.defaults.mappings.n or {}

      -- remap previous selection to Ctrl+t, disable Ctrl+p
      opts.defaults.mappings.i["<C-t>"] = actions.move_selection_previous
      opts.defaults.mappings.i["<C-p>"] = false
      opts.defaults.mappings.n["<C-t>"] = actions.move_selection_previous
      opts.defaults.mappings.n["<C-p>"] = false
    end,
  },
}
