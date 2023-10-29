return{
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = {'dart'},
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
        -- alternatively you can override the default configs
        require("flutter-tools").setup {
          lsp = {
          }
        }
    end,
}
