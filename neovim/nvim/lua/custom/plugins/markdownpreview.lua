local run_if_markdown = function(command)
  local f = function()
    if vim.bo.filetype ~= 'markdown' then
      vim.notify('This only works for markdown files', vim.log.levels.WARN)
    else
      vim.cmd(command)
    end
  end
  return f
end
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
      { '<leader>Ms', run_if_markdown 'MarkdownPreview', desc = 'Start preview' },
      { '<leader>Mc', run_if_markdown 'MarkdownPreviewStop', desc = 'Close preview' },
      { '<leader>Mt', run_if_markdown 'MarkdownPreviewToggle', desc = 'Toggle preview' },
      { '<leader>Mp', run_if_markdown '! $(cd $(dirname "%") && pandoc $(basename "%") -o $(basename "%").pdf)', desc = 'Export as pdf (pandoc)' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
