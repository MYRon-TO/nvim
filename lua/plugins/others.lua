return {
    {
        'mbbill/undotree',
        lazy = true,
        keys = {
            { "cud", ":UndotreeToggle<CR>", "n" },
        },
    },
    {
        'weilbith/nvim-code-action-menu',
        lazy = true,
        cmd = 'CodeActionMenu',
        keys = {
            { "<leader>a", ":CodeActionMenu<CR>", "n" },
        },
    },
}
