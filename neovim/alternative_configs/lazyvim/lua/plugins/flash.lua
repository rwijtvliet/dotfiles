-- TODO: Key mappings not working.
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  -- opts = { modes = { char = { keys = { ["t"] = "k", ["T"] = "K" } } } },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
      labels = "aoeuidhtnspyfgcrlqjkxbmwvz",
      -- modes = { char = { keys = { "f", "F", ["t"] = "k", ["K"] = "T", ";", "." } } },
      modes = { char = { keys = { "f", "F", ";", ".", ["t"] = "k", ["T"] = "K" } } },
    })
  end,
  keys = {
    {
      "gj",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "gJ",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
  -- {
  --   "r",
  --   mode = "o",
  --   function()
  --     require("flash").remote()
  --   end,
  --   desc = "Remote Flash",
  -- },
  -- {
  --   "R",
  --   mode = { "o", "x" },
  --   function()
  --     require("flash").treesitter_search()
  --   end,
  --   desc = "Treesitter Search",
  -- },
  -- {
  --   "<c-s>",
  --   mode = { "c" },
  --   function()
  --     require("flash").toggle()
  --   end,
  --   desc = "Toggle Flash Search",
  -- },
}
