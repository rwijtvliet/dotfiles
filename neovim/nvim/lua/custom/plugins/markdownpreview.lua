return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.g.mkdp_auto_close = 0 --don't close when switching to different buffer
      vim.g.mkdp_page_title = '${name}'
      vim.g.mkdp_combine_preview = 1 -- same window for all markdow
    end,
    keys = {
      { '<leader>Ms', '<cmd>MarkdownPreview<cr>', desc = 'Start preview' },
      { '<leader>Mc', '<cmd>MarkdownPreviewStop<cr>', desc = 'Close preview' },
      { '<leader>Mt', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle preview' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
