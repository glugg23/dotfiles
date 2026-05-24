vim.pack.add({
  "https://github.com/neanias/everforest-nvim"
})

require("everforest").setup({
  background = "hard",
  ui_contrast = "high",
})
vim.cmd("colorscheme everforest")
