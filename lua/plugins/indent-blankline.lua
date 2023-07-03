return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            vim.opt.list = true
            -- vim.opt.listchars:append "space:⋅"
            vim.opt.listchars:append "eol:↴"
            require("indent_blankline").setup {
                char = "│",
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = false,
                vim.cmd ([[
                    highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine
                    " highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline
                ]])
            }
        end,
    },
}
