return {
    {"git@github.com:folke/which-key.nvim", lazy = true},
    {
        "git@github.com:gcmt/wildfire.vim",
        config = function()
            vim.cmd[[
                " use '*' to mean 'all other filetypes'
                " in this example, html and xml share the same text objects
                let g:wildfire_objects = {
                    \ "*" : ["i'", 'i"', "i)", "i]", "i}", "i>"],
                    \ "html,xml" : ["at", "it"],
                \ }
            ]]
        end,
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
    {
        'mbbill/undotree',
        keys = {
            {"cud", ":UndotreeToggle<CR>", "n"},
        },
    },
    {
        {
            "git@github.com:tpope/vim-surround",
            dependencies = {
                "git@github.com:tpope/vim-repeat",
            }
        },
    },
}
