return {
  {
    'kjuq/sixelview.nvim',
    opts = {
      -- a table to specify what files should be viewed by this plugin
      pattern = { '*.jpg', '*.png' },
      -- whether to show an image automatically when an image buffer is opened
      auto = true,
      -- time of delay before showing image
      -- try setting this duration longer if you have a trouble showing image
      delay_ms = 100,
    },
  },

  -- {
  --   '3rd/image.nvim',
  --   dependencies = {
  --     {
  --       'vhyrro/luarocks.nvim',
  --       priority = 1001, -- this plugin needs to run before anything else
  --       opts = {
  --         rocks = { 'magick' },
  --       },
  --     },
  --   },
  --   opts = {
  --     backend = 'ueberzug',
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
  --       },
  --       neorg = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { 'norg' },
  --       },
  --       html = {
  --         enabled = false,
  --       },
  --       css = {
  --         enabled = false,
  --       },
  --     },
  --     max_width = nil,
  --     max_height = nil,
  --     max_width_window_percentage = nil,
  --     max_height_window_percentage = 50,
  --     window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  --     window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
  --     editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --     tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --     hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
  --   },
  -- },
}
