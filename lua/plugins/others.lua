return {
    {"folke/which-key.nvim", lazy = true},
    {
        "gcmt/wildfire.vim",
        config = function()
            vim.g.wildfire_objects = {
                "*", "/", "_", "`", "#", ":", "|", "+", "=", "~", ">", "<", "@", "%", "!", "&", "$", ";", ".",
            }
        end
    },
    {
        'machakann/vim-sandwich',
        config = function()
            vim.cmd([[
                let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

                let g:sandwich_no_default_key_mappings = 1
                " add
                nmap <leader>a <Plug>(sandwich-add)
                xmap <leader>a <Plug>(sandwich-add)
                omap <leader>a <Plug>(sandwich-add)
                " delete
                nmap <leader>d <Plug>(sandwich-delete)
                xmap <leader>d <Plug>(sandwich-delete)
                nmap <leader>db <Plug>(sandwich-delete-auto)
                " replace
                nmap <leader>r <Plug>(sandwich-replace)
                xmap <leader>r <Plug>(sandwich-replace)
                nmap <leader>rb <Plug>(sandwich-replace-auto)
            ]])
        end,
    },
    {
        'mbbill/undotree',
        keys = {
            {"cud", ":UndotreeToggle<CR>", "n"},
        },
    },
}
