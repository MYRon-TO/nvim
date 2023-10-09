return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
        config = function()
            vim.g.copilot_enabled = true
            vim.api.nvim_set_keymap("i", "<C-Y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
            vim.cmd([[
                let g:copilot_no_tab_map = v:true
            ]])
            vim.g.copilot_filetypes = {
              ["*"] = true,
            }
        end,
    },
}

