return {
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

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

    -- Basic debugging keymaps, feel free to change to your liking!
    -- *  [d debug]
    -- *     b toggle breakpoint
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: toggle breakpoint' })
    -- *     B set contidional breakpoint
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: conditional breakpoint' })
    -- *     c run to curson
    vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Debug: run to cursor' })
    -- *     i <F2> step in
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: step into' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Debug: step into' })
    -- *     o <F3> step over
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: step over' })
    vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'Debug: step over' })
    -- *     O <F4> step out
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: step out' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Debug: step out' })
    -- *     s <F5> start
    vim.keymap.set('n', '<leader>ds', dap.continue, { desc = 'Debug: start/continue' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: start/continue' })
    -- *     S <S-F5> restart
    vim.keymap.set('n', '<leader>dS', dap.restart_frame, { desc = 'Debug: restart' })
    vim.keymap.set('n', '<F-18>', dap.restart_frame, { desc = 'Debug: restart' }) -- = S-F5
    -- *     q close debugger
    vim.keymap.set('n', '<leader>dq', dap.close, { desc = 'Debug: close' })
    -- *     Q terminate debugger
    vim.keymap.set('n', '<leader>dQ', dap.restart_frame, { desc = 'Debug: quit (terminate)' }) -- = S-F5
    -- *     l last session result
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>dl', dapui.toggle, { desc = 'Debug: see last session result' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: see last session result' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
