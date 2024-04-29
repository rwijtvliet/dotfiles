return {
  'stevearc/resession.nvim',
  lazy = false,
  keys = function()
    vim.keymap.set('n', '<leader>Ss', function()
      require('resession').save()
    end, { desc = 'Save' })
    vim.keymap.set('n', '<leader>Sl', function()
      require('resession').load()
    end, { desc = 'Load ' })
    vim.keymap.set('n', '<leader>Sd', function()
      require('resession').delete()
    end, { desc = 'Delete' })
  end,
  config = function(_, opts)
    -- fn to get session name
    local function get_session_name()
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
        require('resession').save(get_session_name(), { dir = 'dirsession', notify = false })
      end,
    })
    -- set keymap that depends on function
    vim.keymap.set('n', '<leader>Sr', function()
      require('resession').load(get_session_name(), { dir = 'dirsession', silence_errors = true })
    end, { desc = 'Restore session (of folder/branch)' })
    require('resession').setup(opts)
  end,
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = false,
    },
  },
}
