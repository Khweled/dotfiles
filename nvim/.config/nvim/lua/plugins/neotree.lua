return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	config = function()
		require("neo-tree").setup({
			window = {
				position = "right",
			},
			event_handlers = {

				{
					event = "file_open_requested",
					handler = function()
						-- auto close
						-- vim.cmd("Neotree close")
						-- OR
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "", -- this can only be used in the git_status source
						renamed = "", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
		})
	end,
}
