return {
    {
        "sustech-data/wildfire.nvim",
        lazy = true,
        keys = { "<CR>" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("wildfire").setup({
                surrounds = {
                    { "(", ")" },
                    { "{", "}" },
                    { "<", ">" },
                    { "[", "]" },
                    { "`", "`" },
                },
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                },
                -- filetype_exclude = { "qf" }, --keymaps will be unset in excluding filetypes
                filetype_exclude = {}, --keymaps will be unset in excluding filetypes
            })
        end,
    },
    {
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            lazy = true,
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                    keymaps = {
                        insert = "<C-g>r",
                        insert_line = "<C-g>R",
                        normal = "yr",
                        normal_cur = "yrr",
                        normal_line = "yR",
                        normal_cur_line = "yRR",
                        visual = "yr",
                        visual_line = "yR",
                        delete = "dr",
                        change = "cr",
                        change_line = "cR",
                    },
                })
            end
        },
    },
}
