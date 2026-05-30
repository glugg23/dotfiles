vim.pack.add({
  -- dependencies
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
  -- plugins
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/brenoprata10/nvim-highlight-colors",
})

require("everforest").setup({
  background = "hard",
  ui_contrast = "high",
})
vim.cmd("colorscheme everforest")

require("lualine").setup()
require("nvim-highlight-colors").setup()
