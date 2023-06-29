return {
    {
        "git@github.com:github/copilot.vim",
        lazy = false,
        config = function()
            vim.cmd [[
                let g:copilot_no_tab_map = v:true
                imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")
                let g:copilot_filetypes = {
                      \ '*': v:true,
                      \ }
            ]]
        end,
    },
}
