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
                -- char_current_context_highlight = "IndentBlanklineIndent1",
                vim.cmd [[
                    highlight IndentBlanklineContextChar guifg=#FFFF00 gui=nocombine
                ]]
                -- char_highlight_list = {
                --     "IndentBlanklineIndent1",
                --     "IndentBlanklineIndent2",
                --     "IndentBlanklineIndent3",
                --     "IndentBlanklineIndent4",
                --     "IndentBlanklineIndent5",
                --     "IndentBlanklineIndent6",
                -- },
            }
        end,
    },
}
