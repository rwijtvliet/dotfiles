return {
  'stevearc/resession.nvim',
  lazy = false,
  keys = function()
    vim.keymap.set('n', '<leader>Sl', function()
      require('resession').load('last', { silence_errors = true })
    end, { desc = 'Last session' })
    vim.keymap.set('n', '<leader>Sd', function()
      require('resession').delete()
    end, { desc = 'Delete session' })
  end,
  config = function(_, opts)
    local function folder_name()
      return vim.fn.getcwd()
    end
    local function branch_name()
      local branch = vim.trim(vim.fn.system 'git branch --show-current')
      if vim.v.shell_error == 0 then
        return folder_name() .. branch
      else
        return folder_name()
      end
    end
    local function any_buffers_worth_saving()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_option(bufnr, 'buflisted') and not vim.api.nvim_buf_get_option(bufnr, 'readonly') then -- disregard unlisted buffers
          if vim.api.nvim_buf_get_name(bufnr) ~= '' then
            return true -- there is a buffer with a name
          end
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          if #lines > 1 or (#lines == 1 and #lines[1] > 0) then
            return true -- there is a buffer with content
          end
        end
      end
      return false -- no listed, writable, named buffers with content exist
    end

    -- set keymap that depends on function
    vim.keymap.set('n', '<leader>Sf', function()
      require('resession').load(folder_name(), { silence_errors = false }) -- don't silence error otherwise next line is executed on error too
      require('resession').save('last', { notify = false }) -- ensure autosaving is always done to the 'last' session (in case nvim crashes)
    end, { desc = 'Session of folder' })
    vim.keymap.set('n', '<leader>Sg', function()
      require('resession').load(branch_name(), { silence_errors = false }) -- don't silence error otherwise next line is executed on error too
      require('resession').save('last', { notify = false }) -- ensure autosaving is always done to the 'last' session (in case nvim crashes)
    end, { desc = 'Session of folder & git branch' })

    -- set commands
    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        -- Only save session if we have any buffers/files open. This ensures we don't overwrite 'last' with an unwanted session.
        if any_buffers_worth_saving() then
          require('resession').save('last', { notify = false })
          require('resession').save(folder_name(), { notify = false })
          require('resession').save(branch_name(), { notify = false })
        end
      end,
    })

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
