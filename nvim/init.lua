require("config.lazy")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.fillchars = {eob = " "}
vim.cmd.colorscheme "rose-pine"
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.o.background = dark
vim.keymap.set('n', '<C-t>', ':Neotree filesystem focus left<CR>')
