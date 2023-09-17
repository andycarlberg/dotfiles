-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle filetree" },
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  { 
    -- Heuristically set expandtab and shiftwidth
    "tpope/vim-sleuth" 
  },
}
