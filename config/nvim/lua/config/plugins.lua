vim.pack.add({
  -- dependencies
  "https://github.com/nvim-tree/nvim-web-devicons",
  -- plugins
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
})

require("everforest").setup({
  background = "hard",
  ui_contrast = "high",
})
vim.cmd("colorscheme everforest")

require("lualine").setup()
