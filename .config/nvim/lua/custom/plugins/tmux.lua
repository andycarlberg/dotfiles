return {
  "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>", desc = "Switch panes, left." },
      { "<C-j>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<CR>", desc = "Switch panes, down." },
      { "<C-k>","<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<CR>", desc = "Switch panes, up." },
      { "<C-l>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<CR>", desc = "Switch panes, right." },
      { "<C-\\>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<CR>", desc = "Switch to last active pane." },
      { "<C-Space>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<CR>", desc = "Switch to next pane." }
    }
}
