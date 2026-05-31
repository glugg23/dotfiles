vim.pack.add({
  -- dependencies
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- plugins
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = vim.version.range("3")
  },
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/brenoprata10/nvim-highlight-colors",
})

local everforest = require("everforest")
everforest.setup({
  background = "hard",
  ui_contrast = "high",
  on_highlights = function(hl, palette)
    hl.NeoTreeNormal = { bg = palette.bg }
    hl.NeoTreeEndOfBuffer = { bg = palette.bg }
  end,
})
everforest.load()

require("lualine").setup({
  options = {
    disabled_filetypes = {
      statusline = { "neo-tree" },
    },
  },
})
require("nvim-highlight-colors").setup()
