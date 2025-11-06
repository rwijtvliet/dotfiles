return {
  -- color themes
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'tokyonight-storm'
      -- vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      require('tokyonight').setup {
        on_colors = function(colors)
          colors.border = '#565f89' --more visible vertical line between splits
        end,
      }
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    event = 'UIEnter',
    opts = {
      contrast = 'soft',
      dim_inactive = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'UIEnter',
    lazy = true,
    opts = {
      dim_inactive = { enabled = true, percentage = 0.75, shade = 'dark' },
      integrations = {
        indent_blankline = {
          enabled = true,
          scope_color = 'lavender', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        which_key = true,
      },
      color_overrides = { border = '#ffffff' },
      custom_highlights = function(C)
        return {
          CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
          CmpItemKindKeyword = { fg = C.base, bg = C.red },
          CmpItemKindText = { fg = C.base, bg = C.teal },
          CmpItemKindMethod = { fg = C.base, bg = C.blue },
          CmpItemKindConstructor = { fg = C.base, bg = C.blue },
          CmpItemKindFunction = { fg = C.base, bg = C.blue },
          CmpItemKindFolder = { fg = C.base, bg = C.blue },
          CmpItemKindModule = { fg = C.base, bg = C.blue },
          CmpItemKindConstant = { fg = C.base, bg = C.peach },
          CmpItemKindField = { fg = C.base, bg = C.green },
          CmpItemKindProperty = { fg = C.base, bg = C.green },
          CmpItemKindEnum = { fg = C.base, bg = C.green },
          CmpItemKindUnit = { fg = C.base, bg = C.green },
          CmpItemKindClass = { fg = C.base, bg = C.yellow },
          CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
          CmpItemKindFile = { fg = C.base, bg = C.blue },
          CmpItemKindInterface = { fg = C.base, bg = C.yellow },
          CmpItemKindColor = { fg = C.base, bg = C.red },
          CmpItemKindReference = { fg = C.base, bg = C.red },
          CmpItemKindEnumMember = { fg = C.base, bg = C.red },
          CmpItemKindStruct = { fg = C.base, bg = C.blue },
          CmpItemKindValue = { fg = C.base, bg = C.peach },
          CmpItemKindEvent = { fg = C.base, bg = C.blue },
          CmpItemKindOperator = { fg = C.base, bg = C.blue },
          CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
          CmpItemKindCopilot = { fg = C.base, bg = C.teal },
        }
      end,
    },
  },
  {
    'neanias/everforest-nvim',
    version = false,
    event = 'UIEnter',
    config = function()
      require('everforest').setup {
        background = 'hard',
        ui_contrast = 'high',
      }
    end,
  },
  { 'bluz71/vim-nightfly-colors' },
  { 'NLKNguyen/papercolor-theme' },
  { 'rebelot/kanagawa.nvim' },
  { 'navarasu/onedark.nvim' },
  {
    'EdenEast/nightfox.nvim',
    init = function()
      -- Load the colorscheme here.
      -- vim.cmd.colorscheme 'nightfox'
      -- vim.cmd.hi 'Comment gui=none'
    end,
    opts = { options = { dim_inactive = true } },
  },
}
