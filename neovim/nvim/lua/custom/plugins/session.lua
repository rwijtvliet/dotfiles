return {
  'stevearc/resession.nvim',
  lazy = false,
  keys = function()
    vim.keymap.set('n', '<leader>Sl', function()
      require('resession').load('last', { silence_errors = true })
    end, { desc = 'Restore last session' })
  end,
  config = function(_, opts)
    -- fn to get session name
    local function session_name_of_folder()
      return vim.fn.getcwd()
    end
    local function session_name_of_branch()
      local name = vim.fn.getcwd()
      local branch = vim.trim(vim.fn.system 'git branch --show-current')
      if vim.v.shell_error == 0 then
        return name .. branch
      else
        return name
      end
    end
    -- set commands
    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        require('resession').save('last', { notify = false })
        require('resession').save(session_name_of_folder(), { notify = false })
        require('resession').save(session_name_of_branch(), { notify = false })
      end,
    })
    -- set keymap that depends on function
    vim.keymap.set('n', '<leader>Sd', function()
      require('resession').load(session_name_of_folder(), { silence_errors = true })
      require('resession').save('last', { notify = false }) -- ensure autosaving is always done to the 'last' session (in case nvim crashes)
    end, { desc = 'Restore session (of directory)' })
    vim.keymap.set('n', '<leader>Sg', function()
      require('resession').load(session_name_of_branch(), { silence_errors = true })
      require('resession').save('last', { notify = false }) -- ensure autosaving is always done to the 'last' session (in case nvim crashes)
    end, { desc = 'Restore session (of directory and git branch)' })

    require('resession').setup(opts)
  end,
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = true,
    },
  },
}
