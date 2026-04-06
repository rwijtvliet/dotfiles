return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "aoeuidhtnspyfgcrlqjkxbmwvz",
    -- modes = { char = { keys = { "f", "F", ["t"] = "k", ["K"] = "T", ";", "." } } },
    modes = {
      search = { enabled = true },
      char = {
        keys = { "f", "F", ";", ".", ["t"] = "k", ["T"] = "K" },
        char_actions = function(motion)
          -- f = always forward / to right, F = always backwards / to left
          return { [motion] = "next", [motion:match("%l") and motion:upper() or motion:lower()] = "prev" } --
        end,
      },
    },
  },
  keys = {
    { "t", mode = { "n", "x", "o" }, false },
    { "T", mode = { "n", "x", "o" }, false },

    {
      "k",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ search = { mode = "t" } })
      end,
      desc = "Flash till",
    },
    {
      "K",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ search = { mode = "t", forward = false } })
      end,
      desc = "Flash till backward",
    },
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
    {
      "gw",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ pattern = vim.fn.expand("<cword>") })
      end,
      desc = "Flash: jump (current word)",
    },
  },
}
