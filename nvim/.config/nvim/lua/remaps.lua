vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- allows to move highlighted blocks up and down with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J brings the line below onto the same line
vim.keymap.set("n", "J", "mzJ`z")

--Keep cursor centered when using d and u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--Search next and prev for f command
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

--makes <leader>p not rewrite paste thing
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- leader y to yank to keyboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to Clipboard" })

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete to _" })

vim.keymap.set("n", "<C-t>", ":Neotree filesystem focus right<CR>", { desc = "Open Filetree" })


vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.updatetime = 200
vim.opt.signcolumn = 'yes'

vim.opt.smartindent = true
vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"
