return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Find Text" })
            vim.keymap.set("n", "<leader>F", function()
                builtin.find_files({ hidden = true, no_ignore = true })
            end, { desc = "Find all files" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
