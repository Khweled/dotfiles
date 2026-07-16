return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvimtools/none-ls.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- keymaps
				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Signature Help"
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)

				opts.desc = "Format code"
				vim.keymap.set("n", "<leader>gf", function()
					require("conform").format({ async = true, lsp_fallback = true })
				end)
				--vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)
			end,
		})

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config with all icons
		vim.diagnostic.config({
			signs = {
				text = signs,
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		-- Setup servers
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Auto format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				require("conform").format({ async = false, lsp_fallback = true })
			end,
		})

		-- Global LSP settings (applied to all servers)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Config lsp servers here
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- PYTHON SHITE --
		local function get_python_venv(root)
			for _, name in ipairs({ ".venv", "venv", "env", "report-env" }) do
				local path = root .. "/" .. name .. "/bin/python"
				if vim.fn.executable(path) == 1 then
					return path
				end
			end
			return "python"
		end

		local root_dir = vim.fs.root(0, { "pyproject.toml", "package.json", ".git" })
		root_dir = root_dir or vim.uv.cwd()

		vim.lsp.config("basedpyright", {
			root_dir = root_dir,

			settings = {
				basedpyright = {
					typeCheckingMode = "standard",
				},
				python = {
					pythonPath = get_python_venv(root_dir),
				},
			},
		})
		vim.lsp.enable("basedpyright")

		vim.lsp.config("ruff", { root_dir = root_dir })
		vim.lsp.enable("ruff")
		require("conform").setup({
			formatters_by_ft = {
				python = { "ruff_fix" },
			},
			formatters = {
				ruff_fix = {
					command = "ruff",
					args = { "check", "--fix", "$FILENAME" },
					stdin = false,
				},
			},
		})

		-- PYTHON SHITE END --

		vim.lsp.config("clangd", {
			cmd = { "clangd", "--fallback-style=none" },
			capabilities = capabilities,
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root_dir = vim.fs.root(0, {
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
				".git",
			}),
			single_file_support = true,
		})
		vim.lsp.enable("clangd")
	end,
}
