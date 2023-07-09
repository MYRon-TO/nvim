return {
    {
        "github/copilot.vim",
        -- lazy = false,
        event = "VeryLazy",
        config = function()
            -- vim.g.copilot_no_tab_map = true
            -- vim.g.copilot_filetypes = {
            --     "*",
            -- }
            vim.cmd [[
                imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")
                let g:copilot_no_tab_map = v:true
                let g:copilot_filetypes = {
                      \ '*': v:true,
                      \ }
                highlight CopilotSuggestion guifg=#555555 ctermfg=8
            ]]
        end,
    },
}
