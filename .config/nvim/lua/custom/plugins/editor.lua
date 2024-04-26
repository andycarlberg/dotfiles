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
    keys = {
      { '<leader>bf', ':Telescope file_browser path=%:p:h select_buffer=true<CR>',                                                desc = 'Browse files' },
      { '<leader>ff', ':Telescope find_files<CR>',                                                                                desc = 'Find files' },
      { '<leader>fF', function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,                desc = 'Find files, all' },
      { '<leader>ft', ':Telescope live_grep<CR>',                                                                                 desc = 'Find text' },
      { '<leader>fT', function() require("telescope.builtin").live_grep({ additional_args = { '--hidden', '--no-ignore' } }) end, desc = 'Find text, all' },
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
