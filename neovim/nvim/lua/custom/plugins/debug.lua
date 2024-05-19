return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Creates a beautiful debugger UI
    'theHamsta/nvim-dap-virtual-text',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want.
        -- (Any debugger from the debug list in mason.)
        'debugpy',
      },
    }

    -- stylua: ignore start
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
    vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Set conditional breakpoint' })
    vim.keymap.set('n', '<leader>dC', dap.clear_breakpoints, { desc = 'Clear all breakpoints' })

    vim.keymap.set('n', '<leader>ds', dap.continue,          { desc = 'Start/continue' })
    vim.keymap.set('n', '<F1>',       dap.continue,          { desc = 'Start/continue' })
    vim.keymap.set('n', '<leader>dS', dap.restart_frame,     { desc = 'Restart' })
    vim.keymap.set('n', '<F13>',      dap.restart_frame,     { desc = 'Restart' }) -- = S-F1
    vim.keymap.set('n', '<leader>dc', dap.run_to_cursor,     { desc = 'Run to cursor' })
    vim.keymap.set('n', '<leader>di', dap.step_into,         { desc = 'Step into' })
    vim.keymap.set('n', '<F2>',       dap.step_into,         { desc = 'Step into' })
    vim.keymap.set('n', '<leader>do', dap.step_over,         { desc = 'Step over' })
    vim.keymap.set('n', '<F3>',       dap.step_over,         { desc = 'Step over' })
    vim.keymap.set('n', '<leader>dO', dap.step_out,          { desc = 'Step out' })
    vim.keymap.set('n', '<F4>',       dap.step_out,          { desc = 'Step out' })

    vim.keymap.set('n', '<leader>dq', dap.close,             { desc = 'Close debugger' })
    vim.keymap.set('n', '<leader>dQ', dap.terminate,         { desc = 'Disconnect debugger' })
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>dt', dapui.toggle,          { desc = 'Toggle debug UI (and see last result)' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle,       { desc = 'Toggle REPL' })
    vim.keymap.set('n', '<leader>dv', function() dapui.eval(nil, { enter = true }) end, { desc = 'Debug: show variable under cursor' }) -- Dap UI setup
    -- stylua: ignore end

    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
          disconnect = '',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
