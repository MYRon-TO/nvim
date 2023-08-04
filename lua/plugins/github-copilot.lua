return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
        config = function()
            vim.g.copilot_enabled = true
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-Y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
            vim.g.copilot_filetypes = {
              ["*"] = true,
            }
            -- vim.cmd([[
            --     let g:copilot_filetypes = {
            --         \ '*': v:true,
            --         \ }
            --     highlight CopilotSuggestion guifg=#555555 ctermfg=8
            -- ]])
        end,
    },
}

