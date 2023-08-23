return {
    -- {
    --     "gcmt/wildfire.vim",
    --     event = "VeryLazy",
    --     config = function()
    --         vim.cmd [[
    --             " use '*' to mean 'all other filetypes'
    --             " in this example, html and xml share the same text objects
    --             let g:wildfire_objects = {
    --                 \ "*" : ["i'", 'i"', "i)", "i]", "i}", "i>",'i`'],
    --                 \ "html,xml" : ["at", "it"],
    --             \ }
    --         ]]
    --     end,
    -- },
    {
        "sustech-data/wildfire.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("wildfire").setup({
                surrounds = {
                    { "(", ")" },
                    { "{", "}" },
                    { "<", ">" },
                    { "[", "]" },
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
    -- {
    --     'machakann/vim-sandwich',

    --     config = function()
    --         vim.cmd([[
    --             let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
    --             let g:sandwich_no_default_key_mappings = 1
    --             let g:operator_sandwich_no_default_key_mappings = 1
    --             let g:textobj_sandwich_no_default_key_mappings = 1
    --             " add
    --             nmap <leader>a <Plug>(sandwich-add)
    --             xmap <leader>a <Plug>(sandwich-add)
    --            omap <leader>a <Plug>(sandwich-add)
    --             " delete
    --             nmap <leader>d <Plug>(sandwich-delete)
    --             xmap <leader>d <Plug>(sandwich-delete)
    --             nmap <leader>db <Plug>(sandwich-delete-auto)
    --             " replace
    --             nmap <leader>r <Plug>(sandwich-replace)
    --             xmap <leader>r <Plug>(sandwich-replace)
    --             nmap <leader>rb <Plug>(sandwich-replace-auto)
    --         ]])
    --     end,
    -- },
}
