vim.api.nvim_create_autocmd("FileType", {
  pattern = { "elixir", "nix" },
  callback = function()
    vim.treesitter.start()
  end
})
