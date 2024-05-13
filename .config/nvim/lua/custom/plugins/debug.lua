-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      automatic_setup = true,

      ensure_installed = {},

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
    }

    require('dap.ext.vscode').load_launchjs(nil, { php = { 'php', 'module', 'theme', 'twig' } })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Start/Continue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>dr', function() require('dap.repl').toggle() end, { desc = 'Toggle REPL' })
  end,
}
