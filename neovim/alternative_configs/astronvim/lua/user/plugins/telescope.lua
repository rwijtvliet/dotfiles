return {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      -- We use extend_tbl to merge the base config with the new options, to avoid overriding
      return require("astronvim.utils").extend_tbl(opts, {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = false,
              ["<C-k>"] = false,
              ["<C-t>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-h>"] = actions.cycle_history_prev,
              ["<C-s>"] = actions.cycle_history_next,
              ["<C-q>"] = actions.close,
            },
            n = {
              ["t"] = actions.move_selection_previous,
              ["n"] = actions.move_selection_next,
              ["<C-t>"] = false,
              ["<C-n>"] = false,
              ["<C-h>"] = actions.cycle_history_prev,
              ["<C-s>"] = actions.cycle_history_next,
            }
          }
        },
      pickers = { colorscheme = {enable_preview = true}}
      })
    end,
  }
