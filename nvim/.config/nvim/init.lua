require("config.lazy")

require("remaps")

vim.opt.fillchars = { eob = " " }
vim.g.mapleader = " "
vim.opt.number = true
vim.wo.relativenumber = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	callback = function()
		if os.getenv("TMUX") then
			os.execute("tmux setw automatic-rename")
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if not os.getenv("TMUX") then
			return
		end
		local buftype = vim.api.nvim_get_option_value("buftype", { scope = "local" })
		local filename = vim.fn.expand("%:t")

		if buftype == "" and filename ~= "" then
			os.execute("tmux rename-window " .. filename)
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "YankHighlight", timeout = 150 })
	end,
})
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#332d42" })

require("rose-pine").setup({
	variant = "main", -- auto, main, moon, or dawn
	dark_variant = "main", -- main, moon, or dawn
	dim_inactive_windows = false,
	extend_background_behind_borders = true,

	enable = {
		terminal = true,
		legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
		migrations = true, -- Handle deprecated options automatically
	},

	styles = {
		bold = true,
		italic = true,
		transparency = false,
	},

	groups = {
		border = "muted",
		link = "iris",
		panel = "surface",

		error = "love",
		hint = "iris",
		info = "foam",
		note = "pine",
		todo = "rose",
		warn = "gold",

		git_add = "foam",
		git_change = "rose",
		git_delete = "love",
		git_dirty = "rose",
		git_ignore = "muted",
		git_merge = "iris",
		git_rename = "pine",
		git_stage = "iris",
		git_text = "rose",
		git_untracked = "subtle",

		h1 = "iris",
		h2 = "foam",
		h3 = "rose",
		h4 = "gold",
		h5 = "pine",
		h6 = "foam",
	},

	palette = {
		-- Override the builtin palette per variant
		moon = {
			--base = "#1c1c1c",
			--overlay = "#363738",
		},
	},
})

vim.cmd.colorscheme("rose-pine")
