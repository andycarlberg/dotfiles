return {
  { 
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDowm<cr>" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>" },
    },
    config = function()
      require("nvim-tmux-navigation").setup {}
    end,
  },
}
