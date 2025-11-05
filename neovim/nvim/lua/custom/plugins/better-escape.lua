return {
  'max397574/better-escape.nvim',
  lazy = false,
  opts = {
    default_mappings = false,
    mappings = {
      i = { -- mode
        g = { c = '<Esc>' },
      },
      c = {
        g = { c = '<Esc>' },
      },
      t = {
        g = { c = '<C-\\><C-n>' },
      },
      v = {
        g = { c = '<Esc>' },
      },
      s = {
        g = { c = '<Esc>' },
      },
    },
    timeout = 150,
  },
}
