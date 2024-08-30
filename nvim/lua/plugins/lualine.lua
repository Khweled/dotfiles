return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "rose-pine",
                section_separators = { left = "▓▒░", right = "░▒▓" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    {
                        "filename",
                        file_status = true, -- Displays file status (readonly status, modified status)
                        newfile_status = false, -- Display new file status (new file means no write after created)
                        path = 3, -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        -- 4: Filename and parent dir, with tilde as the home directory

                        shorting_target = 20, -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = "[+]", -- Text to show when the file is modified.
                            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            newfile = "[New]", -- Text to show for newly created file before first write
                        },
                    },
                },
                lualine_x = {
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "", -- e712
                            dos = "", -- e70f
                            mac = "", -- e711
                        },
                    },
                    "filetype",
                },
            },
        })
    end,
}
