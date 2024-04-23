-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require('telescope').setup({
        extensions = {
          file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            hidden = true,
            no_ignore = true,
          }
        }
      })

      -- Keymappings
      vim.api.nvim_set_keymap(
        'n',
        '<space>fb',
        ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
        {
          noremap = true,
          desc = 'Telescope file browser'
        }
      )

      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'fzf'
    end
  },

  {
    -- Heuristically set expandtab and shiftwidth
    'tpope/vim-sleuth'
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {} -- this is equalent to setup({}) function
  }
}
