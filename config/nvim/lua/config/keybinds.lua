vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", vim.cmd.so)

vim.keymap.set("n", "<leader>vt", "<Cmd>vert term<CR>")
vim.keymap.set("n", "<leader>ht", "<Cmd>hor term<CR>")

vim.keymap.set("n", "<leader>sw", ":s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { silent = false, desc = "Replace current word" })
vim.keymap.set("n", "<leader>sg", ":%s///g<Left><Left><Left>", { silent = false, desc = "Replace any string globally" })
vim.keymap.set("n", "<leader>sgw", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { silent = false, desc = "Replace current word globally" })

vim.keymap.set("n", ":Q", ":qa")

vim.keymap.set("n", "gl", vim.diagnostic.open_float)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>tt", "<Cmd>Neotree focus left<CR>")
vim.keymap.set("n", "<leader>tr", "<Cmd>Neotree show reveal<CR>")
vim.keymap.set("n", "<leader>tq", "<Cmd>Neotree close<CR>")

vim.keymap.set("", "<MiddleMouse>", "<Nop>")
for i = 2, 4 do
  vim.keymap.set("", string.format("<%d-MiddleMouse>", i), "<Nop>")
end
