local set = vim.opt

set.backspace = "indent,eol,start"

set.showmode = true
set.showcmd = true
set.mouse = "a"

set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.softtabstop = 4

set.number = true
set.relativenumber = true
set.cursorline = true
set.wrap = true
set.linebreak = true
set.scrolloff = 5
set.sidescrolloff = 2
set.ruler = true

set.showmatch = true
set.ignorecase = true
set.smartcase = true

set.wildmenu = true
set.wildmode = "longest:list,full"

set.undofile = true

set.complete:append("o")
set.completeopt = { "menuone", "noselect", "popup" }
set.pumheight = 5
set.pummaxwidth = 40
